local opts = { silent = true }
local keymap = vim.keymap.set

-- COMMENT:

local comment_status, comment = pcall(require, 'Comment')
if not comment_status then
  print("'comment' executed with errors.")
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

keymap({ 'i', 'n' }, '<C-_>', "<Cmd>lua require('config.comments').SavePosComment('line')<CR>", opts)
keymap('x', '<C-_>', "<Esc><Cmd>lua require('config.comments').SavePosComment('visual')<CR>", opts)

local M = {}

M.SavePosComment = function(mode)
  local _, row, column = unpack(vim.fn.getcurpos())
  local widthBefore = vim.fn.strdisplaywidth(vim.fn.getline('.'))
  if mode == 'line' then
    require('Comment.api').locked.toggle_current_linewise()
  elseif mode == 'visual' then
    require('Comment.api').locked.toggle_linewise_op(vim.fn.visualmode())
  end
  local widthAfter = vim.fn.strdisplaywidth(vim.fn.getline('.'))
  if column > vim.fn.indent('.') then
    vim.fn.cursor(row, column + (widthAfter - widthBefore))
  end
end

return M
