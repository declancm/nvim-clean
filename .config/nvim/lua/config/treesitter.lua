local keymap = vim.keymap.set

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

  -- AUTOTAG:
  autotag = {
    enable = true,
  },
}

-- SPELLSITTER:

local spellsitter_status, spellsitter = pcall(require, 'spellsitter')
if not spellsitter_status then
  print("'spellsitter' executed with errors.")
  return
end

spellsitter.setup()

if vim.g.__enable_spellchecker then
  vim.opt.spell = true -- Enable spellchecker.
  vim.opt.spelllang = 'en_us' -- Set spellchecker language to English US.
end

-- SYMBOLS-OUTLINE:

vim.g.symbols_outline = {
  auto_close = true,
  preview_bg_highlight = '',
}

keymap('n', '<Leader>so', '<Cmd>SymbolsOutline<CR>')

-- REFACTORING:

local refactoring_status, refactoring = pcall(require, 'refactoring')
if not refactoring_status then
  print("'refactoring' executed with errors.")
  return
end

-- Refactoring operations:

-- NOTE: Use the telescope extension for refactoring (visual mode: <Leader>fr).

-- Debug operations:

keymap('n', '<Leader>rf', function()
  require('refactoring').debug.printf { below = false }
end)
keymap('v', '<Leader>rv', function()
  require('refactoring').debug.print_var {}
end)
keymap('n', '<Leader>rc', function()
  require('refactoring').debug.cleanup {}
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
