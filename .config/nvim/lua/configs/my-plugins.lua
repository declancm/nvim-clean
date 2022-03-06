local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- VIM2VSCODE:

-- GIT-SCRIPTS-VIM:

-- vim.g.commit_on_save = 1
-- vim.g.commit_no_warnings = 1

-- CINNAMON-SCROLL:

vim.g.cinnamon_centered = 1

-- vim.g.cinnamon_no_defaults = 1

-- vim.g.cinnamon_extras = 1
keymap('n', 'gg', '<Cmd>Cinnamon gg 0 1 3 <CR>', opts)
keymap('n', 'G', '<Cmd>Cinnamon G 0 1 3 <CR>', opts)
keymap('n', 'G', '<Cmd>Cinnamon G 0 1 3 <CR>', opts)

keymap('n', 'n', '<Cmd>Cinnamon n 1 0 3 <CR>zv', opts)
keymap('n', 'N', '<Cmd>Cinnamon N 1 0 3 <CR>zv', opts)
keymap('n', '*', '<Cmd>Cinnamon * 1 0 3 <CR>zv', opts)
keymap('n', '#', '<Cmd>Cinnamon # 1 0 3 <CR>zv', opts)
