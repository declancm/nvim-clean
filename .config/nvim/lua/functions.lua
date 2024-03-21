local M = {}

-- CTRL-BS:

-- Delete the start of the word.
-- If at the start of the line, will delete all the whitespace.
-- Works with plugins that change what a word is such as wordmotion (recognizes
-- camelCase etc. as separate words).

M.delete_start_word = function(word)
  local cursor_pos = vim.fn.getcurpos()
  if cursor_pos[3] < 3 then
    local bs = vim.api.nvim_replace_termcodes('<BS>', true, false, true)
    vim.api.nvim_feedkeys(bs, 'n', false)
  else
    vim.cmd('normal! b')
    local cursor_new = vim.fn.getcurpos()
    vim.fn.cursor(cursor_pos[2], cursor_pos[3])
    if cursor_pos[2] - cursor_new[2] ~= 0 then
      vim.cmd('normal! d0i')
    else
      local keys
      if word == 'w' then
        keys = vim.api.nvim_replace_termcodes('<Space><Esc>vbc', true, false, true)
      elseif word == 'W' then
        keys = vim.api.nvim_replace_termcodes('<Space><Esc>vBc', true, false, true)
      end
      vim.api.nvim_feedkeys(keys, 'm', false)
    end
  end
end

-- CTRL-DEL:

-- Delete the end of the word.
-- Works with plugins that change what a word is such as wordmotion ( which
-- recognizes camelCase etc. as separate words).

M.delete_end_word = function(word)
  local keys
  if word == 'w' then
    keys = vim.api.nvim_replace_termcodes('<Space><Esc>vec', true, false, true)
  elseif word == 'W' then
    keys = vim.api.nvim_replace_termcodes('<Space><Esc>vEc', true, false, true)
  end
  vim.api.nvim_feedkeys(keys, 'm', false)
end

-- IMPROVED_PASTE:

-- Paste from the global register '*'.
-- If pasting a visual line selection of text, perform automatic indentation.

M.paste = function(paste_mode)
  if vim.fn.getreg('*') == '' then
    return
  end
  if vim.fn.getregtype('*') == 'V' then
    vim.cmd('normal! "*' .. paste_mode .. '`[v`]=`]$')
  else
    vim.cmd('normal! "*' .. paste_mode)
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
    echohl ErrorMsg | echom "Error: Pattern not found: " . l:pattern | echohl None
    return
  endif
  exe "%s/" . l:pattern . "//gn"
  silent exe "normal! /" . l:pattern
  silent exe "normal! n"
  let @/ = l:pattern
endfunction
]])

-- VIMGREP:

-- Enter pattern to grep within the current file.
-- Prepend a ' (single quotation mark) to the pattern for an exact match.
-- The results are added to the quickfix list.

vim.cmd([[
function! VimGrep()
  let l:pattern = input("Enter the grep pattern: ")
  if l:pattern == "" | return | endif
  if l:pattern[0] == "'"
    let l:pattern = "\\<" . trim(l:pattern, "'", 1) . "\\>"
  endif
  try
    exe "vimgrep /" . l:pattern . "/gj " . getreg('%')
  catch
    echohl ErrorMsg | echom "Error: The grep failed." | echohl None
    return
  endtry
  echom "The quickfix list was populated with the grep results."
  lua require('telescope.builtin').quickfix()
endfunction
]])

-- INDENT_MOVEMENT:

-- Jump to the next line with the same indent size.
-- Will only find a match after the indent has changed, stopping it from jumping
-- just one line at a time.

M.same_indent = function(direction)
  local indent_changed = false
  local line_num = vim.fn.getcurpos()[2]
  local wanted_indent = vim.fn.indent(line_num)
  vim.cmd('norm! ^')
  while true do
    if direction == 'Up' then
      line_num = line_num - 1
    elseif direction == 'Down' then
      line_num = line_num + 1
    else
      return
    end
    local indent = vim.fn.indent(line_num)
    if indent ~= wanted_indent then
      indent_changed = true
    elseif indent == wanted_indent and indent_changed == true then
      vim.cmd('normal ' .. line_num .. 'G')
      return
    end
    if line_num <= 0 or line_num >= vim.fn.line('$') then
      return
    end
  end
end

-- JUMP_LIST:

-- An autocmd runs the function when insert mode is left.
-- If the distance between this InsertLeave and the last InsertLeave is
-- greater than 15 lines, set this position in the jump list.
-- Use ctrl-o and ctrl-i to go back and forth on the jump list.

M.set_jump = function()
  local cursor = vim.fn.getcurpos()
  local buffer = vim.fn.bufnr()
  if
    vim.bo.buftype == ''
    and vim.b.__jump_text_changed == 1
    and (
      vim.b.__jump_prev_cursor == nil
      or vim.b.__jump_prev_buffer == nil
      or buffer ~= vim.b.__jump_prev_buffer
      or cursor[2] < vim.b.__jump_prev_cursor[2] - 15
      or cursor[2] > vim.b.__jump_prev_cursor[2] + 15
    )
  then
    -- print 'Setting jump.'
    vim.b.__jump_prev_cursor = cursor
    vim.b.__jump_prev_buffer = buffer
    vim.b.__jump_text_changed = 0
    vim.cmd("normal! m'") -- only save the line number
    -- vim.cmd 'normal! m`' -- save the column position too
  end
end

return M
