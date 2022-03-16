local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- VIM2VSCODE:

-- GIT-SCRIPTS:

-- require('git-scripts').setup {
--   default_keymaps = false,
--   commit_on_save = true,
--   warnings = false,
-- }

-- CINNAMON-SCROLL:

-- require('cinnamon').setup {
--   default_keymaps = false,
--   extra_keymaps = true,
-- }

vim.g.cinnamon_centered = 1

-- vim.g.cinnamon_no_defaults = 1

-- vim.g.cinnamon_extras = 1

-- keymap('n', 'gg', "<Cmd>lua Cinnamon.Scroll('gg', 0, 1, 3)<CR>", opts)
-- keymap('n', 'G', "<Cmd>lua Cinnamon.Scroll('G', 0, 1, 3)<CR>", opts)

keymap('n', 'n', "<Cmd>lua Cinnamon.Scroll('n', 1, 0, 3)<CR>", opts)
keymap('n', 'N', "<Cmd>lua Cinnamon.Scroll('N', 1, 0, 3)<CR>", opts)
keymap('n', '#', "<Cmd>lua Cinnamon.Scroll('#', 1, 0, 3)<CR>", opts)
keymap('n', '*', "<Cmd>lua Cinnamon.Scroll('*', 1, 0, 3)<CR>", opts)
