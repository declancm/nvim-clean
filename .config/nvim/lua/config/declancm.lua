local opts = { silent = true }
local keymap = vim.keymap.set

-- VIM2VSCODE:

-- GIT-SCRIPTS:

-- require('git-scripts').setup {
--   -- default_keymaps = false,
--   -- commit_on_save = true,
--   -- warnings = false,
-- }

-- CINNAMON-SCROLL:

require('cinnamon').setup {
  -- default_keymaps = false,
  extra_keymaps = true,
  -- centered = false,
  -- disable = true,
  scroll_limit = 100,
}

-- keymap('n', 'gd', "<Cmd>lua Cinnamon.Scroll('definition')<CR>", opts)

-- WINDEX:

-- require('windex').setup {
--   -- arrow_keys = true,
--   numbered_term = true,
--   -- save_buffers = true,
-- }

-- Open lazygit:
keymap('n', '<C-g>', "<Cmd>lua require('windex').toggle_terminal('all', 'lazygit')<CR>", opts)
