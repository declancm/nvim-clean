local keymap = vim.keymap.set

-- COMMENT:

local comment_status, comment = pcall(require, 'Comment')
if not comment_status then
  print("'comment' executed with errors.")
  return
end

comment.setup {
  mappings = {
    default = false,
    extra = false
  }
}

keymap({ 'i', 'n' }, '<C-_>', '<Plug>(comment_toggle_linewise_current)')
keymap('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)')
