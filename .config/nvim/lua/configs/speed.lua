local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- QUICKSCOPE:

vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
vim.g.qs_max_chars = 160

-- BULLETS:

vim.g.bullets_enabled_file_types = { 'markdown', 'text' }
vim.g.bullets_enable_in_empty_buffers = 0

-- KOMMENTARY:

local kommentary_status, kommentary = pcall(require, 'kommentary.config')
if not kommentary_status then
  print "'kommentary' executed with errors."
  return
end

vim.g.kommentary_create_default_mappings = false

-- Set <C-/> keymaps.
keymap('i', '<C-_>', "<Cmd>lua SavePosComment('line')<CR>", opts)
keymap('n', '<C-_>', "<Cmd>lua SavePosComment('line')<CR>", opts)
keymap('x', '<C-_>', "<Cmd>lua SavePosComment('selection')<CR><Esc>", opts)
-- keymap('n', '<C-_>', '<Plug>kommentary_line_default', {})
-- keymap('x', '<C-_>', '<Plug>kommentary_visual_default<Esc>', {})

-- Keymaps to increase or decrease the comment depth level.
keymap('n', '<Leader>cic', '<Plug>kommentary_line_increase', {})
keymap('n', '<Leader>cdc', '<Plug>kommentary_line_decrease', {})
keymap('n', '<Leader>ci', '<Plug>kommentary_motion_increase', {})
keymap('n', '<Leader>cd', '<Plug>kommentary_motion_decrease', {})
keymap('x', '<Leader>ci', '<Plug>kommentary_visual_increase', {})
keymap('x', '<Leader>cd', '<Plug>kommentary_visual_decrease', {})

-- Configure the languages.
kommentary.configure_language('default', {
  prefer_single_line_comments = true,
  use_consistent_indentation = true,
  ignore_whitespace = true,
})
kommentary.configure_language('lua', {
  single_line_comment_string = '--',
})
kommentary.configure_language('vim', {
  single_line_comment_string = '"',
})
kommentary.configure_language('cpp', {
  single_line_comment_string = '//',
})
kommentary.configure_language('python', {
  single_line_comment_string = '#',
})

function SavePosComment(mode)
  local column = vim.fn.getcurpos()[3]
  local lengthBefore = vim.fn.strdisplaywidth(vim.fn.getline '.')
  local start
  if mode == 'line' then
    start = vim.fn.line '.'
  elseif mode == 'selection' then
    start = vim.fn.line 'v'
  else
    return
  end
  require('kommentary').toggle_comment(start, vim.fn.line '.')
  local lengthAfter = vim.fn.strdisplaywidth(vim.fn.getline '.')
  if column > vim.fn.indent '.' then
    vim.fn.cursor(vim.fn.line '.', column + lengthAfter - lengthBefore)
  end
end
