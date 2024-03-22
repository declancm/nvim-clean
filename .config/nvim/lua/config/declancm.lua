local keymap = vim.keymap.set

-- VIM2VSCODE:

-- vim.g.vim2vscode_no_defaults = 1

-- CINNAMON-SCROLL:

require('cinnamon').setup {
  extra_keymaps = true,
  extended_keymaps = true,
  override_keymaps = true,
  -- hide_cursor = true,
  max_length = 500,
  scroll_limit = 500,
}

keymap({ 'n', 'x' }, 'gg', "<Cmd>lua Scroll('gg', 0, 0, 3)<CR>")
keymap({ 'n', 'x' }, 'G', "<Cmd>lua Scroll('G', 0, 1, 3)<CR>")
-- keymap('n', 'gd', "<Cmd>lua Cinnamon.Scroll('definition')<CR>")

-- WINDEX:

require('windex').setup {
  extra_keymaps = true,
  save_buffers = true,
}

-- Open lazygit:
keymap('n', '<C-g>', "<Cmd>lua require('windex').toggle_terminal('all', 'lazygit')<CR>")

