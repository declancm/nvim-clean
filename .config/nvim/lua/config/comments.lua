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

keymap({ 'i', 'n' }, '<C-_>', function()
  require('config.comments').save_pos_comment('line')
end)
keymap('x', '<C-_>', function()
  require('config.comments').save_pos_comment('visual')
end)

local M = {}

M.save_pos_comment = function(mode)
  local _, row, column = unpack(vim.fn.getcurpos())
  local width_before = vim.fn.strdisplaywidth(vim.fn.getline('.'))
  if mode == 'line' then
    require('Comment.api').locked.toggle_current_linewise()
  elseif mode == 'visual' then
    require('Comment.api').locked.toggle_linewise_op(vim.fn.visualmode())
  end
  local width_after = vim.fn.strdisplaywidth(vim.fn.getline('.'))
  if column > vim.fn.indent('.') then
    vim.fn.cursor(row, column + (width_after - width_before))
  end
end

return M
