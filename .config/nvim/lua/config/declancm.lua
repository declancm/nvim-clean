local keymap = vim.keymap.set

-- VIM2VSCODE:

-- vim.g.vim2vscode_no_defaults = 1

-- GIT-SCRIPTS:

-- require('git-scripts').setup {
--   default_keymaps = false,
-- }

-- CINNAMON-SCROLL:

require('cinnamon').setup {
  extra_keymaps = true,
  scroll_limit = 100,
  extended_keymaps = true,
}

-- keymap('n', 'gd', "<Cmd>lua Cinnamon.Scroll('definition')<CR>")

-- WINDEX:

require('windex').setup {
  extra_keymaps = true,
  save_buffers = true,
}

-- Open lazygit:
keymap('n', '<C-g>', "<Cmd>lua require('windex').toggle_terminal('all', 'lazygit')<CR>")

-- MAXIMIZE:

require('maximize').setup { default_keymaps = false }
