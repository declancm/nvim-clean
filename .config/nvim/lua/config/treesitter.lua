local keymap = vim.keymap.set

-- TREESITTER:

---@diagnostic disable: missing-fields
require('nvim-treesitter.configs').setup {
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

  -- AUTOTAG:
  autotag = {
    enable = true,
  },
}
---@diagnostic enable: missing-fields

-- REFACTORING:

local refactoring = require('refactoring')

-- Refactoring operations:

-- NOTE: Use the telescope extension for refactoring (visual mode: <Leader>fr).

-- Debug operations:

keymap('n', '<Leader>rp', function()
  refactoring.debug.printf { below = false }
end)
keymap({'x', 'n'}, '<Leader>rv', function()
  refactoring.debug.print_var {}
end)
keymap('n', '<Leader>rc', function()
  refactoring.debug.cleanup {}
end)

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
