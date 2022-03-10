local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Quickscope colors.
autocmd('ColorScheme', {
  command = "highlight QuickScopePrimary guifg='#F1FA8C' gui=underline ctermfg=155 cterm=underline",
  group = augroup('qs_colors', {}),
})
autocmd('ColorScheme', {
  command = "highlight QuickScopeSecondary guifg='#FF5555' gui=underline ctermfg=81 cterm=underline",
  group = augroup('qs_colors', {}),
})

-- Brief highlight on yank.
autocmd('TextYankPost', {
  command = "lua require('vim.highlight').on_yank { timeout = 150 }",
  group = augroup('highlight_yank', {}),
})

-- Make the clipboard work in WSL.
autocmd(
  'TextYankPost',
  { command = "call system('echo '.shellescape(join(v:event.regcontents, \"<CR>\")).' |  clip.exe')" }
)

-- Packer.
autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  pattern = 'plugins.lua',
  group = augroup('packer_user_config', {}),
})

vim.cmd [[
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

function! ClangFormat()
    let l:savedView = winsaveview()
    let l:file = fnamemodify(bufname(), ":p")
    silent exec "!clang-format -i -style=file " . l:file
    silent exec "e"
    call winrestview(l:savedView)
endfunction
]]

-- Formatting files.
autocmd('BufWritePre', { callback = 'TrimWhiteSpace()', group = augroup('format_on_save', {}) })
autocmd('BufWritePost', {
  callback = 'ClangFormat()',
  pattern = { '*.h', '*.hpp', '*.c', '*.cpp' },
  group = augroup('format_on_save', {}),
})

vim.cmd [[
function! SetTabSize()
    let l:fts = ['html','javascript','json','lua','markdown','ps1']
    if index(l:fts, &ft) >= 0 | setlocal shiftwidth=2 tabstop=2 softtabstop=2
    else | setlocal shiftwidth=4 tabstop=4 softtabstop=4 | endif
endfunction
]]

-- Setting options.
autocmd({ 'BufEnter', 'BufWritePost' }, {
  command = 'call SetTabSize() | set fo-=t fo-=r fo-=o scl=yes:1',
  group = augroup('setting_options', {}),
})

-- Opening nvim with a directory input will open chadtree.
autocmd('StdinReadPre', { command = 'let s:std_in=1', group = augroup('open_chadtree', {}) })
autocmd('VimEnter', {
  command = "if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exec 'CHADopen' | exec 'cd '.argv()[0] | endif",
  group = augroup('open_chadtree', {}),
})
