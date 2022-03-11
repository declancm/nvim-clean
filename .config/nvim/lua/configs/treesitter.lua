-- TREESITTER:

local treesitter_status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not treesitter_status then
  print "'treesitter' executed with errors."
  return
end

--[[

~ INSTALLATION ~

treesitter:         npm install treesitter

]]

treesitter.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = {},
    -- To use treesitter with 'syntax on':
    -- additional_vim_regex_highlighting = true,
  },

  -- TREESITTER_TEXTOBJECTS:
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['a/'] = '@comment.outer',
      },
    },
  },
}

-- REFACTORING:

local refactoring_status, refactoring = pcall(require, 'refactoring')
if not refactoring_status then
  print "'refactoring' executed with errors."
  return
end

local keymap = vim.api.nvim_set_keymap

-- Refactoring operations:

-- NOTE: Use the telescope extension for these commands (visual mode: <Leader>fr).

-- local opts = { noremap = true, silent = true, expr = false }
-- local refactor = " <Esc><Cmd>lua require('refactoring').refactor"

-- keymap('v', '<Leader>re', refactor .. "('Extract Function')<CR>", opts)
-- keymap('v', '<Leader>rf', refactor .. "('Extract Function To File')<CR>", opts)
-- keymap('v', '<Leader>rv', refactor .. "('Extract Variable')<CR>", opts)
-- keymap('v', '<Leader>ri', refactor .. "('Inline Variable')<CR>", opts)
-- keymap('n', '<Leader>ri', refactor .. "('Inline Variable')<CR>", opts)

-- Debug operations:

local opts = { noremap = true }
local debug = ":lua require('refactoring').debug"

keymap('n', '<Leader>rf', debug .. '.printf({below = false})<CR>', opts)
keymap('v', '<Leader>rv', debug .. '.print_var({})<CR>', opts)
keymap('n', '<Leader>rc', debug .. '.cleanup({})<CR>', opts)

-- Prompt type operations:
refactoring.setup {
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

-- SYMBOLS-OUTLINE:

keymap('n', '<Leader>so', '<Cmd>SymbolsOutline<CR>', opts)
