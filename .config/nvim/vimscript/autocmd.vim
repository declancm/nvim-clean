augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#F1FA8C' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#FF5555' gui=underline ctermfg=81 cterm=underline
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 150})
augroup END

autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' |  clip.exe')

augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

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

augroup format_on_save
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
    autocmd BufWritePost *.h,*.hpp,*.c,*.cpp call ClangFormat()
augroup END

function! SetTabSize()
    let l:fts = ['html','javascript','json','lua','markdown','ps1']
    if index(l:fts, &ft) >= 0 | setlocal shiftwidth=2 tabstop=2 softtabstop=2
    else | setlocal shiftwidth=4 tabstop=4 softtabstop=4 | endif
endfunction

augroup setting_options
    autocmd!
    autocmd BufEnter * :call SetTabSize() | set fo-=t fo-=r fo-=o scl=yes:1
    autocmd BufWritePost * :call SetTabSize() | set fo-=t fo-=r fo-=o scl=yes:1
augroup END

" Open chadtree when opening nvim at a directory.
augroup chadtree_on_directory
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ exec 'CHADopen' | exec 'cd '.argv()[0] | endif
augroup END
