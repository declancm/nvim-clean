local opts = { silent = true }
local keymap = vim.keymap.set

-- COMMENT:

local comment_status, comment = pcall(require, 'Comment')
if not comment_status then
  print("'kommentary' executed with errors.")
  return
end

comment.setup {
  ignore = '^$',
  opleader = {
    line = 'gc',
    block = 'gb',
  },
  mappings = {
    basic = true,
    extra = true,
    extended = false,
  },
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },
  pre_hook = nil,
  post_hook = nil,
}

-- local comment_ft = require 'Comment.ft'
-- comment_ft.set('lua', { '--%s', '--[[%s]]' })

keymap({ 'i', 'n' }, '<C-_>', "<Cmd>lua SavePosComment('line')<CR>", opts)
keymap('x', '<C-_>', "<Esc><Cmd>lua SavePosComment('visual')<CR>", opts)

local M = {}

M.SavePosComment = function(mode)
  local column = vim.fn.getcurpos()[3]
  local lengthBefore = vim.fn.strdisplaywidth(vim.fn.getline('.'))
  if mode == 'line' then
    require('Comment.api').toggle_current_linewise()
  elseif mode == 'visual' then
    require('Comment.api').locked.toggle_linewise_op(vim.fn.visualmode())
  end
  local lengthAfter = vim.fn.strdisplaywidth(vim.fn.getline('.'))
  if column > vim.fn.indent('.') then
    vim.fn.cursor(vim.fn.line('.'), column + (lengthAfter - lengthBefore))
  end
end

return M

-- KOMMENTARY:

-- local kommentary_status, kommentary = pcall(require, 'kommentary.config')
-- if not kommentary_status then
--   print "'kommentary' executed with errors."
--   return
-- end

-- vim.g.kommentary_create_default_mappings = false

-- -- Set <C-/> keymaps.
-- keymap('i', '<C-_>', "<Cmd>lua SavePosComment('line')<CR>", opts)
-- keymap('n', '<C-_>', "<Cmd>lua SavePosComment('line')<CR>", opts)
-- keymap('x', '<C-_>', "<Cmd>lua SavePosComment('selection')<CR><Esc>", opts)
-- -- keymap('n', '<C-_>', '<Plug>kommentary_line_default', {})
-- -- keymap('x', '<C-_>', '<Plug>kommentary_visual_default<Esc>', {})

-- -- Keymaps to increase or decrease the comment depth level.
-- keymap('n', '<Leader>cic', '<Plug>kommentary_line_increase', {})
-- keymap('n', '<Leader>cdc', '<Plug>kommentary_line_decrease', {})
-- keymap('n', '<Leader>ci', '<Plug>kommentary_motion_increase', {})
-- keymap('n', '<Leader>cd', '<Plug>kommentary_motion_decrease', {})
-- keymap('x', '<Leader>ci', '<Plug>kommentary_visual_increase', {})
-- keymap('x', '<Leader>cd', '<Plug>kommentary_visual_decrease', {})

-- -- Configure the languages.
-- kommentary.configure_language('default', {
--   prefer_single_line_comments = true,
--   use_consistent_indentation = true,
--   ignore_whitespace = true,
-- })
-- kommentary.configure_language('lua', {
--   single_line_comment_string = '--',
-- })
-- kommentary.configure_language('vim', {
--   single_line_comment_string = '"',
-- })
-- kommentary.configure_language('cpp', {
--   single_line_comment_string = '//',
-- })
-- kommentary.configure_language('python', {
--   single_line_comment_string = '#',
-- })

-- function SavePosComment(mode)
--   local column = vim.fn.getcurpos()[3]
--   local lengthBefore = vim.fn.strdisplaywidth(vim.fn.getline '.')
--   local start
--   if mode == 'line' then
--     start = vim.fn.line '.'
--   elseif mode == 'selection' then
--     start = vim.fn.line 'v'
--   else
--     return
--   end
--   require('kommentary').toggle_comment(start, vim.fn.line '.')
--   local lengthAfter = vim.fn.strdisplaywidth(vim.fn.getline '.')
--   if column > vim.fn.indent '.' then
--     vim.fn.cursor(vim.fn.line '.', column + lengthAfter - lengthBefore)
--   end
-- end
