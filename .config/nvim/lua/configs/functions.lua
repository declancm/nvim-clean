local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- MAXIMIZE_WINDOW:

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

function TerminalToggle(command)
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
    if command ~= nil then
      vim.cmd('keepalt terminal ' .. command)
    elseif vim.g.term_bufnr == nil or vim.fn.bufname(vim.g.term_bufnr) == '' then
      vim.cmd 'keepalt terminal'
    else
      vim.cmd('keepalt buffer ' .. vim.g.term_bufnr)
    end
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.signcolumn = 'no'
    vim.cmd 'startinsert'
    MaximizeWindow()
  end
end

-- NOTES:

-- Toggle your notes file and keep it synced with the github remote.
-- Requires 'declancm/git-scripts.nvim'.

function ToggleNotes(notesPath)
  notesPath = vim.fn.expand(notesPath)
  local notesDirectory = vim.fn.fnamemodify(notesPath, ':h')
  if notesPath == vim.fn.expand '%' then
    -- if vim.bo.modified or vim.b.notes_modified == 1 then
    --   vim.cmd 'write'
    --   local notesTail = vim.fn.fnamemodify(notesPath, ':t')
    --   print("Your changes to '" .. notesTail .. "' are being committed.")
    --   require('git-scripts').async_commit('', notesDirectory)
    --   vim.b.notes_modified = 0
    -- end
    vim.cmd 'edit #'
  else
    require('git-scripts').async_pull(notesDirectory)
    vim.b.notes_modified = 0
    vim.cmd('edit ' .. notesPath)
    vim.cmd('au BufWritePre ' .. notesPath .. ' if &modified | let b:notes_modified = 1 | endif')
  end
end

-- CTRL-BS:

-- Delete the start of the word.
-- If at the start of the line, will delete all the whitespace.
-- Works with plugins that change what a word is such as wordmotion (recognizes
-- camelCase etc. as separate words).

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
-- Works with plugins that change what a word is such as wordmotion ( which
-- recognizes camelCase etc. as separate words).

function DeleteEndWord(endKey)
  vim.cmd('call feedkeys("\\<Space>\\<Esc>v' .. endKey .. 'c")')
end

-- IMPROVED_PASTE:

-- Paste from the global register '*'.
-- If pasting a visual line selection of text, perform automatic indentation.

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

-- PREVIOUS_WINDOW:

-- Switch to previous vim window.
-- If no previous vim window exists, switch to last tmux pane.

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

function CloseOtherWindow(direction)
  local win1 = vim.fn.winnr()
  vim.cmd('wincmd ' .. direction)
  local win2 = vim.fn.winnr()
  if win1 == win2 then
    return
  end
  vim.cmd [[exec (&modifiable && &modified) ? 'wq' : 'q']]
end

-- CLEAR_BUFFERS:

-- Close all buffers but the current.

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

vim.cmd [[
function! Search(cmd = '')
  let l:pattern = input("Enter the search pattern: ")
  if l:pattern == "" | return | endif
  echo "\n"
  if l:pattern[0] == "'"
    let l:pattern = "\\<" . trim(l:pattern, "'", 1) . "\\>"
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

-- JUMP_LIST:

-- An autocmd runs the function when insert mode is left.
-- If the distance between this InsertLeave and the last InsertLeave is
-- greater than 15 lines, set this position in the jump list.
-- Use ctrl-o and ctrl-i to go back and forth on the jump list.

-- FIX: stop setting jumps in terminal.

function SetJump()
  local cursor = vim.fn.getcurpos()
  local buffer = vim.fn.bufnr()
  if
    vim.bo.buftype == ''
    and vim.b.jumpTextChanged == 1
    and (
      vim.b.prevJumpCursor == nil
      or vim.b.prevJumpBuffer == nil
      or buffer ~= vim.b.prevJumpBuffer
      or cursor[2] < vim.b.prevJumpCursor[2] - 15
      or cursor[2] > vim.b.prevJumpCursor[2] + 15
    )
  then
    -- print 'Setting jump.'
    vim.b.prevJumpCursor = cursor
    vim.b.prevJumpBuffer = buffer
    vim.b.jumpTextChanged = 0
    -- vim.cmd "normal! m'" -- only save the line number
    vim.cmd 'normal! m`' -- save the column position too
  end
end

autocmd('InsertEnter', { command = 'let b:jumpTextChanged = 0', group = augroup('set_jump', {}) })
autocmd('TextChangedI', { command = 'let b:jumpTextChanged = 1', group = augroup('set_jump', {}) })
autocmd('InsertLeave', { command = 'lua SetJump()', group = augroup('set_jump', {}) })

-- CLANG_FORMAT:

vim.cmd [[
function! ClangFormat()
  let l:savedView = winsaveview()
  let l:file = fnamemodify(bufname(), ":p")
  silent exec "!clang-format -i -style=file " . l:file
  silent exec "e"
  call winrestview(l:savedView)
endfunction
]]

autocmd('BufWritePost', {
  command = 'call ClangFormat()',
  pattern = { '*.h', '*.hpp', '*.c', '*.cpp' },
  group = augroup('format_on_save', {}),
})
