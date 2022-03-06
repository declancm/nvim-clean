-- TREESITTER:

require('nvim-treesitter.configs').setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = {},
    -- Use treesitter with 'syntax on'.
    -- additional_vim_regex_highlighting = true,
  },
}

-- REFACTORING:

require('refactoring').setup {}

local keymap = vim.api.nvim_set_keymap

-- Keymaps for refactoring operations.

-- NOTE: Use the telescope extension for these commands (visual mode: <Leader>fr).

-- local opts = { noremap = true, silent = true, expr = false }
-- local refactor = " <Esc><Cmd>lua require('refactoring').refactor"

-- keymap('v', '<Leader>re', refactor .. "('Extract Function')<CR>", opts)
-- keymap('v', '<Leader>rf', refactor .. "('Extract Function To File')<CR>", opts)
-- keymap('v', '<Leader>rev', refactor .. "('Extract Variable')<CR>", opts)
-- keymap('v', '<Leader>ri', refactor .. "('Inline Variable')<CR>", opts)
-- keymap('n', '<Leader>ri', refactor .. "('Inline Variable')<CR>", opts)

-- Keymaps for debug operations.

local opts = { noremap = true }
local debug = ":lua require('refactoring').debug"

keymap('n', '<Leader>rp', debug .. '.printf({below = false})<CR>', opts)
keymap('v', '<Leader>rv', debug .. '.print_var({})<CR>', opts)
keymap('n', '<Leader>rc', debug .. '.cleanup({})<CR>', opts)

-- Prompt type operations.
require('refactoring').setup {
  prompt_func_return_type = {
    go = true,
    cpp = true,
    c = true,
    java = true,
  },
  prompt_func_param_type = {
    go = true,
    cpp = true,
    c = true,
    java = true,
  },
}
