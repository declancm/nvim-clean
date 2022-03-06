local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- MAXIMIZE_WINDOW:

-- Toggle maximizing the current window.

keymap('n', '<Leader>z', '<Cmd>lua MaximizeWindow()<CR>', opts)
keymap('x', '<Leader>z', '<Cmd>lua MaximizeWindow()<CR>', opts)

function MaximizeWindow()
  if vim.b.maxWinStatus == nil or vim.b.maxWinStatus == 0 then
    vim.b.winPositions = vim.fn.winrestcmd()
    vim.cmd 'resize | vertical resize'
    vim.b.winPositionsNew = vim.fn.winrestcmd()
    if vim.b.winPositions == vim.b.winPositionsNew then
      vim.b.maxWinStatus = 0
      return
    end
    vim.b.maxWinStatus = 1
  else
    vim.b.maxWinStatus = 0
    vim.cmd 'silent exec b:winPositions'
  end
end

-- NATIVE_TERMINAL:

-- Toggle the native terminal.

keymap('t', '<C-N>', '<C-\\><C-N>', opts)
keymap('n', '<C-Bslash>', '<Cmd>lua ToggleTerminal()<CR>', opts)
keymap('t', '<C-Bslash>', '<Cmd>lua ToggleTerminal()<CR>', opts)

vim.cmd 'autocmd TermOpen * startinsert'
vim.cmd "autocmd BufEnter * if &buftype == 'terminal' | startinsert | endif"

function ToggleTerminal()
  if vim.bo.buftype == 'terminal' then
    vim.g.term_bufnr = vim.fn.bufnr()
    MaximizeWindow()
    if vim.g.term_prev == nil or vim.fn.bufname(vim.g.term_prev) == '' then
      vim.cmd 'call feedkeys("\\<C-\\>\\<C-N>\\<C-^>", "n")'
    else
      vim.cmd('keepalt buffer ' .. vim.g.term_prev)
    end
  else
    vim.g.term_prev = vim.fn.bufnr()
    if vim.g.term_bufnr == nil or vim.fn.bufname(vim.g.term_bufnr) == '' then
      vim.cmd 'keepalt terminal'
    else
      vim.cmd('keepalt buffer ' .. vim.g.term_bufnr)
    end
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.signcolumn = 'no'
    MaximizeWindow()
  end
end

-- NOTES:

-- Toggle your notes file and keep it synced with the github remote.

keymap('n', '<Leader>nt', '<Cmd>call NotesToggle()<CR>', opts)

vim.cmd [[
" Add the file to keep synced.
let g:notes_full_path = expand("~/notes/notes.txt")
let g:notes_dir = expand(g:notes_full_path, ":h")

function! NotesToggle()
    " Check if current directory is the notes directory.
    let l:currentDir = getcwd(0)
    if l:currentDir ==# g:notes_dir
        if exists("b:notes_modified") && b:notes_modified == 1
            " Commit and push when file has been modified.
            silent exec "w"
            echom "Your changes to " . bufname("%") . " are being committed."
            lua require("git-scripts").async_commit('',vim.g.notes_dir)
            silent exec "e# | lcd -"
        else
            " Only return when nothing has been modified.
            silent exec "w | e# | lcd -"
        endif
        " set nolbr nobri nowrap cc=80
        set fo-=t
    else
        silent exec "lcd " . g:notes_dir
        lua require("git-scripts").async_pull(vim.g.notes_dir)
        silent exec "edit " . g:notes_full_path
        " set wrap lbr bri cc=0
        set fo+=t
        let &showbreak=repeat(' ',6)
    endif
endfunction

" Check if modified every time the buffer is saved.
exec "autocmd BufEnter " . g:notes_full_path . " let b:notes_modified = 0"
exec "autocmd BufWritePre " . g:notes_full_path . " if &modified | let b:notes_modified = 1 | endif"
]]

-- CTRL-BS:

-- Delete the start of the word.
-- If at the start of the line, will delete all the whitespace.
-- Works with plugins that change what a word is such as wordmotion (recognizes
-- camelCase etc. as separate words).

keymap('i', '<C-H>', '<Cmd>call DeleteStartWord("b")<CR>', opts)
keymap('i', '<M-BS>', '<Cmd>call DeleteStartWord("B")<CR>', opts)

vim.cmd [[
function! DeleteStartWord(backKey)
    let l:cursorPos = getcurpos()
    if l:cursorPos[2] < 3
        call feedkeys("\<BS>", 'n')
    else
        normal! b
        let l:cursorNew = getcurpos()
        silent exec "call cursor(l:cursorPos[1], l:cursorPos[2])"
        if l:cursorPos[1] - l:cursorNew[1] != 0
            normal! d0i
        else
            call feedkeys("\<Space>\<Esc>v" . a:backKey . "c")
        endif
    endif
endfunction
]]

-- CTRL-DEL:

-- Delete the end of the word.
-- Works with plugins that change what a word is such as wordmotion (recognizes
-- camelCase etc. as separate words).

keymap('i', '<C-Del>', '<Cmd>lua DeleteEndWord("e")<CR>', opts)
keymap('i', '<M-Del>', '<Cmd>lua DeleteEndWord("E")<CR>', opts)

function DeleteEndWord(endKey)
  vim.cmd('call feedkeys("\\<Space>\\<Esc>v' .. endKey .. 'c")')
end

-- IMPROVED_PASTE:

-- Paste from the global register '*'.
-- If pasting a visual line selection of text, perform automatic indentation.

keymap('n', 'p', '<Cmd>call GlobalPaste("p")<CR>', opts)
keymap('n', 'P', '<Cmd>call GlobalPaste("P")<CR>', opts)
keymap('n', 'gp', '<Cmd>call GlobalPaste("gp")<CR>', opts)
keymap('n', 'gP', '<Cmd>call GlobalPaste("gP")<CR>', opts)
keymap('n', '<M-p>', '<Cmd>call GlobalPaste("p")<CR>a', opts)
keymap('n', '<M-P>', '<Cmd>call GlobalPaste("P")<CR>a', opts)
keymap('i', '<M-p>', '<Esc><Cmd>call GlobalPaste("p")<CR>a', opts)
keymap('i', '<M-P>', '<Esc><Cmd>call GlobalPaste("P")<CR>a', opts)
keymap('n', 'op', 'o<Esc><Cmd>call GlobalPaste("p")<CR>', opts)

vim.cmd [[
function! GlobalPaste(pasteMode)
    if getreg('*') != ""
        let l:pasteType = getregtype('*')
        if l:pasteType ==# 'V'
            silent exec "normal! \"*" . a:pasteMode . "`[v`]=`]$"
        else
            silent exec "normal! \"*" . a:pasteMode
        endif
    endif
endfunction
]]

-- APPEND_YANK:

-- Yank to the default register.
-- Append to the '*' register using the same type as the '*' register.

keymap('v', '<Leader>y', '<Cmd>call AppendYank("y")<CR>', opts)
keymap('n', '<Leader>Y', '<Cmd>call AppendYank("yg_")<CR>', opts)

vim.cmd [[
function! AppendYank(yankMode)
    silent exec "normal! \"0" . a:yankMode
    call setreg('*', getreg('*') . getreg('0'), getregtype('*'))
endfunction
]]

-- PREVIOUS_WINDOW:

-- Switch to previous vim window.
-- If no previous vim window exists, switch to last tmux pane.

keymap('n', '<Leader>;', '<Cmd>lua PreviousWindow()<CR>', opts)

function PreviousWindow()
  local win1 = vim.fn.winnr()
  vim.cmd 'wincmd p'
  local win2 = vim.fn.winnr()
  if win1 == win2 then
    os.execute 'tmux select-pane -l'
  end
end

-- CLOSE_OTHER_WINDOW:

-- Save and close the window in the direction selected.

keymap('n', 'ql', "<Cmd>lua CloseOtherWindow('l')<CR>", opts)
keymap('n', 'qh', "<Cmd>lua CloseOtherWindow('h')<CR>", opts)
keymap('n', 'qk', "<Cmd>lua CloseOtherWindow('k')<CR>", opts)
keymap('n', 'qj', "<Cmd>lua CloseOtherWindow('j')<CR>", opts)
keymap('n', 'q<Right>', "<Cmd>lua CloseOtherWindow('l')<CR>", opts)
keymap('n', 'q<Left>', "<Cmd>lua CloseOtherWindow('h')<CR>", opts)
keymap('n', 'q<Up>', "<Cmd>lua CloseOtherWindow('k')<CR>", opts)
keymap('n', 'q<Down>', "<Cmd>lua CloseOtherWindow('j')<CR>", opts)

function CloseOtherWindow(direction)
  local win1 = vim.fn.winnr()
  vim.cmd('wincmd ' .. direction)
  local win2 = vim.fn.winnr()
  if win1 == win2 then
    return
  end
  vim.cmd [[exec &modifiable ? 'wq' : 'q']]
end

-- CLEAR_BUFFERS:

-- Close all buffers but the current.

keymap('n', '<Leader>bd', '<Cmd>call ClearBuffers()<CR>', opts)

vim.cmd [[
function! ClearBuffers()
    let l:cursorPos = getcurpos()
    silent exec "wa | %bdelete | normal! \<C-^>"
    silent exec "call cursor(l:cursorPos[1], l:cursorPos[2])"
endfunction
]]

-- SEARCH:

-- Enter pattern to get a count for total matches in file.
-- Prepend a ' (single quotation mark) to the pattern for an exact match.
-- Use 'n' to go to the next match or 'N' to go to the previous.

keymap('n', '<Leader>/', '<Cmd>call Search()<CR>', opts)

vim.cmd [[
function! Search(cmd = '')
  let l:pattern = input("Enter the search pattern: ")
  echo "\n"
  if l:pattern[0] == "'"
    let l:pattern = trim(l:pattern, "'", 1)
    let l:pattern = "\\<" . l:pattern . "\\>"
  endif
  exec "%s/" . l:pattern . "//gn"
  silent exec "normal! /" . l:pattern
  silent exec "normal! n"
  let @/ = l:pattern
endfunction
]]

-- INDENT_MOVEMENT:

-- Jump to the next line with the same indent size.
-- Will only find a match after the indent has changed, stopping it from jumping
-- just one line at a time.

keymap('', '<Leader>iu', "<Cmd>lua FindSameIndent('Up')<CR>", opts)
keymap('', '<Leader>id', "<Cmd>lua FindSameIndent('Down')<CR>", opts)

function FindSameIndent(direction)
  local indentChanged = false
  local lineNum = vim.fn.getcurpos()[2]
  local wantedIndent = vim.fn.indent(lineNum)
  while true do
    if direction == 'Up' then
      lineNum = lineNum - 1
    elseif direction == 'Down' then
      lineNum = lineNum + 1
    else
      return
    end
    local indent = vim.fn.indent(lineNum)
    if indent ~= wantedIndent then
      indentChanged = true
    elseif indent == wantedIndent and indentChanged == true then
      vim.cmd('normal ' .. lineNum .. 'G')
      return
    end
    if lineNum <= 0 or lineNum >= vim.fn.line '$' then
      return
    end
  end
end
