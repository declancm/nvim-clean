local keymap = vim.api.nvim_set_keymap
local opts = { silent = true }

-- TREESITTER:

local treesitter_status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not treesitter_status then
  print("'treesitter' executed with errors.")
  return
end

treesitter.setup {
  ensure_installed = 'all',
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

-- SYMBOLS-OUTLINE:

vim.g.symbols_outline = {
  auto_close = true,
  preview_bg_highlight = '',
}

keymap('n', '<Leader>so', '<Cmd>SymbolsOutline<CR>', opts)

-- REFACTORING:

local refactoring_status, refactoring = pcall(require, 'refactoring')
if not refactoring_status then
  print("'refactoring' executed with errors.")
  return
end

-- Refactoring operations:

-- NOTE: Use the telescope extension for refactoring (visual mode: <Leader>fr).

-- Debug operations:

local debug = ":lua require('refactoring').debug"

keymap('n', '<Leader>rf', debug .. '.printf({below = false})<CR>', {})
keymap('v', '<Leader>rv', debug .. '.print_var({})<CR>', {})
keymap('n', '<Leader>rc', debug .. '.cleanup({})<CR>', {})

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
