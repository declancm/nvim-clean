local keymap = vim.keymap.set

-- COMMENT:

require('Comment').setup {
  mappings = {
    default = false,
    extra = false
  }
}

keymap({ 'i', 'n' }, '<C-_>', '<Plug>(comment_toggle_linewise_current)')
keymap('x', '<C-_>', '<Plug>(comment_toggle_linewise_visual)')
