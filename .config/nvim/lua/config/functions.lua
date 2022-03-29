local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- NOTES:

-- Toggle your notes file and keep it synced with the github remote.
-- Requires 'declancm/git-scripts.nvim'.

function ToggleNotes(notesPath)
  notesPath = vim.fn.expand(notesPath)
  local notesDirectory = vim.fn.fnamemodify(notesPath, ':h')
  if notesPath == vim.fn.expand('%') then
    -- if vim.bo.modified or vim.b.notes_modified == 1 then
    --   vim.cmd 'write'
    --   local notesTail = vim.fn.fnamemodify(notesPath, ':t')
    --   print("Your changes to '" .. notesTail .. "' are being committed.")
    --   require('git-scripts').async_commit('', notesDirectory)
    --   vim.b.notes_modified = 0
    -- end
    vim.cmd('edit #')
  else
    require('git-scripts').async_pull(notesDirectory)
    vim.b.notes_modified = 0
    vim.cmd('edit ' .. notesPath)
    -- autocmd('BufWritePre', {
    --   command = 'if &modified | let b:notes_modified = 1 | endif',
    --   pattern = notesPath,
    --   group = augroup('toggle_notes', {}),
    -- })
  end
end

-- CTRL-BS:

-- Delete the start of the word.
-- If at the start of the line, will delete all the whitespace.
-- Works with plugins that change what a word is such as wordmotion (recognizes
-- camelCase etc. as separate words).

function DeleteStartWord(word)
  local cursorPos = vim.fn.getcurpos()
  if cursorPos[3] < 3 then
    local bs = vim.api.nvim_replace_termcodes('<BS>', true, false, true)
    vim.api.nvim_feedkeys(bs, 'n', true)
  else
    vim.cmd('normal! b')
    local cursorNew = vim.fn.getcurpos()
    vim.fn.cursor(cursorPos[2], cursorPos[3])
    if cursorPos[2] - cursorNew[2] ~= 0 then
      vim.cmd('normal! d0i')
    else
      local keys
      if word == 'w' then
        keys = vim.api.nvim_replace_termcodes('<Space><Esc>vbc', true, false, true)
      elseif word == 'W' then
        keys = vim.api.nvim_replace_termcodes('<Space><Esc>vBc', true, false, true)
      end
      vim.api.nvim_feedkeys(keys, 'm', true)
    end
  end
end

-- CTRL-DEL:

-- Delete the end of the word.
-- Works with plugins that change what a word is such as wordmotion ( which
-- recognizes camelCase etc. as separate words).

function DeleteEndWord(word)
  local keys
  if word == 'w' then
    keys = vim.api.nvim_replace_termcodes('<Space><Esc>vec', true, false, true)
  elseif word == 'W' then
    keys = vim.api.nvim_replace_termcodes('<Space><Esc>vEc', true, false, true)
  end
  vim.api.nvim_feedkeys(keys, 'm', true)
end

-- IMPROVED_PASTE:

-- Paste from the global register '*'.
-- If pasting a visual line selection of text, perform automatic indentation.

function GlobalPaste(pasteMode)
  if vim.fn.getreg('*') == '' then
    return
  end
  if vim.fn.getregtype('*') == 'V' then
    vim.cmd('normal! "*' .. pasteMode .. '`[v`]=`]$')
  else
    vim.cmd('normal! "*' .. pasteMode)
  end
end

-- SEARCH:

-- Enter pattern to get a count for total matches in file.
-- Prepend a ' (single quotation mark) to the pattern for an exact match.
-- Use 'n' to go to the next match or 'N' to go to the previous.

vim.cmd([[
function! Search(cmd = '')
  let l:pattern = input("Enter the search pattern: ")
  if l:pattern == "" | return | endif
  echo "\n"
  if l:pattern[0] == "'"
    let l:pattern = "\\<" . trim(l:pattern, "'", 1) . "\\>"
  endif
  if search(l:pattern, 'nw') == 0
    echohl ErrorMsg | echo "Error: Pattern not found: " . l:pattern | echohl None
    return
  endif
  exec "%s/" . l:pattern . "//gn"
  silent exec "normal! /" . l:pattern
  silent exec "normal! n"
  let @/ = l:pattern
endfunction
]])

-- INDENT_MOVEMENT:

-- Jump to the next line with the same indent size.
-- Will only find a match after the indent has changed, stopping it from jumping
-- just one line at a time.

function FindSameIndent(direction)
  local indentChanged = false
  local lineNum = vim.fn.getcurpos()[2]
  local wantedIndent = vim.fn.indent(lineNum)
  vim.cmd('norm! ^')
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
    if lineNum <= 0 or lineNum >= vim.fn.line('$') then
      return
    end
  end
end

-- JUMP_LIST:

-- An autocmd runs the function when insert mode is left.
-- If the distance between this InsertLeave and the last InsertLeave is
-- greater than 15 lines, set this position in the jump list.
-- Use ctrl-o and ctrl-i to go back and forth on the jump list.

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
    vim.cmd("normal! m'") -- only save the line number
    -- vim.cmd 'normal! m`' -- save the column position too
  end
end

autocmd('InsertEnter', { command = 'let b:jumpTextChanged = 0', group = augroup('set_jump', { clear = false }) })
autocmd('TextChangedI', { command = 'let b:jumpTextChanged = 1', group = augroup('set_jump', { clear = false }) })
autocmd('InsertLeave', { command = 'lua SetJump()', group = augroup('set_jump', { clear = false }) })
