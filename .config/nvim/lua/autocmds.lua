local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local keymap = vim.keymap.set

-- Keep nvim config synced with remote.
autocmd('VimEnter', {
  command = "lua require('git-scripts').async_pull('~/.config/nvim')",
  group = augroup('config_sync', {}),
})

-- Quickscope colors.
autocmd('ColorScheme', {
  command = [[hi QuickScopePrimary guifg='#F1FA8C' gui=underline ctermfg=155 cterm=underline
              hi QuickScopeSecondary guifg='#FF5555' gui=underline ctermfg=81 cterm=underline]],
  group = augroup('qs_colors', {}),
})

-- Brief highlight on yank.
autocmd('TextYankPost', {
  command = "lua require('vim.highlight').on_yank { timeout = 150 }",
  group = augroup('highlight_yank', {}),
})

-- Delete whitespace on the end of lines.
autocmd('BufWritePre', {
  command = 'let b:savedView = winsaveview() | keeppatterns %s/s+$//e | call winrestview(b:savedView)',
  group = augroup('remove_whitespace', {}),
})

-- Setting options.
autocmd({ 'FileType', 'BufWritePost' }, {
  callback = function()
    vim.cmd('set fo-=cro')
    -- vim.cmd 'set fo-=ro' -- Comments automatically wrap at 80 characters.
    local fts = { 'css', 'html', 'javascript', 'json', 'lua', 'markdown', 'ps1' }
    local size
    for _, value in ipairs(fts) do
      if value == vim.bo.ft then
        size = 2
      end
    end
    size = size or 4
    vim.opt_local.shiftwidth = size
    vim.opt_local.tabstop = size
    vim.opt_local.softtabstop = size
    vim.opt.scl = 'yes:1'
  end,
  group = augroup('setting_options', {}),
})

-- Make the clipboard work in WSL.
autocmd('VimEnter', {
  callback = function()
    if vim.fn.has('unix') then
      local file = io.open('/proc/version', 'r')
      local text = file:read('a')
      if text:find('microsoft', 1, true) then
        autocmd('TextYankPost', {
          command = "call system('echo '.shellescape(join(v:event.regcontents, \"<CR>\")).' |  clip.exe')",
          group = augroup('clipboard', {}),
        })
      end
      file:close()
    end
  end,
  group = augroup('clipboard', {}),
})

-- Setting jump points.
autocmd('InsertEnter', { command = 'let b:__jump_text_changed = 0', group = augroup('set_jump', { clear = false }) })
autocmd('TextChangedI', { command = 'let b:__jump_text_changed = 1', group = augroup('set_jump', { clear = false }) })
autocmd('InsertLeave', {
  command = "lua require('functions').set_jump()",
  group = augroup('set_jump', { clear = false }),
})
