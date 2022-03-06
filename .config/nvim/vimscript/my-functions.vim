" This is a collection of my neovim functions written in vimscript before they\
" had been converted to lua, which are vim friendly.

" Toggle maximizing the current window.

function! MaximizeWindow()
    if (!exists("b:maxWinStatus") || b:maxWinStatus == 0)
        let b:winPositions = winrestcmd()
        silent exec "resize | vertical resize"
        let b:winPositionsNew = winrestcmd()
        if b:winPositions == b:winPositionsNew
            let b:maxWinStatus = 0
            return
        endif
        let b:maxWinStatus = 1
    else
        let b:maxWinStatus = 0
        silent exec b:winPositions
    endif
endfunction

" Toggle the native terminal.

function! ToggleTerminal()
    if &buftype == 'terminal'
        let g:term_bufnr = bufnr()
        call MaximizeWindow()
        if !exists("g:term_prev") || bufname(g:term_prev) == ''
            silent exec "call feedkeys(\"\\<C-\\>\\<C-N>\\<C-^>\", 'n')"
        else
            silent exec "keepalt buffer " . g:term_prev
        end
    else
        let g:term_prev = bufnr()
        if !exists("g:term_bufnr") || bufname(g:term_bufnr) == ''
            silent exec "keepalt term"
        else
            silent exec "keepalt buffer " . g:term_bufnr
        endif
        setlocal nornu nonu scl=no
        call MaximizeWindow()
    endif
endfunction

" In visual mode, { and } go to the last line of the paragraph instead of the
" whitespace.

function! VisualParaUp()
    if line(".") != 1 && line(".") != line("$") | silent exec "norm! k" | endif
    silent exec "Cinnamon { 0"
    if line(".") != 1 || len(getline(".")) == 0 | silent exec "norm! j" | endif
endfunction
function! VisualParaDown()
    if line(".") != 1 && line(".") != line("$") | silent exec "norm! j" | endif
    silent exec "Cinnamon } 0"
    if line(".") != line("$") || len(getline(".")) == 0 | silent exec "norm! k" | endif
endfunction

" When performing a window movement, if the window doesn't exist, make one.

function! WindowMovement(key)
    let l:currentWin = winnr()
    silent exec "wincmd " . a:key
    if (l:currentWin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        silent exec "wincmd ".a:key
    endif
endfunction

" Delete the end of the current word.

function! DeleteEndWord(endKey)
    call feedkeys("\<Space>\<Esc>v" . a:endKey . "c")
endfunction

