local opts = { silent = true }
local keymap = vim.keymap.set

-- VIM2VSCODE:

-- GIT-SCRIPTS:

-- require('git-scripts').setup {
--   default_keymaps = false,
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

-- WINDEX:

require('windex').setup()
