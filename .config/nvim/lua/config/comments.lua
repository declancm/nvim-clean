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

keymap({ 'i', 'n' }, '<C-_>', "<Cmd>lua require('config.comments').save_pos_comment()<CR>")
keymap('x', '<C-_>', "<Esc><Cmd>lua require('config.comments').save_pos_comment('visual')<CR>")

local M = {}

M.save_pos_comment = function(mode)
  local row, column = unpack(vim.api.nvim_win_get_cursor(0))
  local width_before = vim.fn.strdisplaywidth(vim.fn.getline('.'))
  if mode == 'visual' then
    require('Comment.api').locked.toggle_linewise_op(vim.fn.visualmode())
  else
    require('Comment.api').locked.toggle_current_linewise()
  end
  local width_after = vim.fn.strdisplaywidth(vim.fn.getline('.'))
  if column >= vim.fn.indent('.') and column + width_after - width_before >= 0 then
    vim.api.nvim_win_set_cursor(0, { row, column + width_after - width_before })
  end
end

return M
