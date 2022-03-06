-- TELESCOPE:

local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    layout_config = {
      horizontal = { prompt_position = 'top' },
    },
    -- List results starting from the top.
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        -- Delete the start of the word.
        ['<C-H>'] = function()
          vim.cmd 'normal! cB'
        end,
        ['<Tab>'] = actions.move_selection_next,
        ['<S-Tab>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<C-p>'] = actions.toggle_selection + actions.move_selection_better,
      },
      n = {
        ['<Tab>'] = actions.move_selection_next,
        ['<S-Tab>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.toggle_selection + actions.move_selection_worse,
        ['<C-p>'] = actions.toggle_selection + actions.move_selection_better,
      },
    },
    prompt_prefix = '🔭 ',
    selection_caret = '▶ ',
  },
  pickers = {
    find_files = {
      find_command = { 'rg', '--ignore', '-L', '--hidden', '--files' },
      -- hidden = true,
      file_ignore_patterns = { '^.git/' },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
}
require('telescope').load_extension 'fzf'
require('telescope').load_extension 'zoxide'
require('telescope').load_extension 'refactoring'

-- KEYMAPS:

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local builtin = "<Cmd>lua require('telescope.builtin')"

-- File pickers.
keymap('n', '<Leader>ff', builtin .. '.find_files()<CR>', opts)
keymap('n', '<Leader>fg', builtin .. '.live_grep()<CR>', opts)

-- Vim pickers.
keymap('n', '<Leader>fb', builtin .. '.buffers()<CR>', opts)
keymap('n', '<Leader>fh', builtin .. '.help_tags()<CR>', opts)
keymap('n', '<Leader>fc', builtin .. '.command_history()<CR>', opts)
keymap('n', '<Leader>fq', builtin .. '.quickfix()<CR>', opts)

-- LSP pickers.
keymap('n', '<Leader>fd', builtin .. '.diagnostics()<CR>', opts)
keymap('n', '<Leader>fr', builtin .. '.lsp_references()<CR>', opts)
keymap('n', '<Leader>fi', builtin .. '.lsp_implementations()<CR>', opts)
keymap('n', '<Leader>fa', builtin .. '.lsp_code_actions()<CR>', opts)

-- List pickers.
keymap('n', '<Leader>fp', builtin .. '.builtin()<CR>', opts)

-- PLUGIN_KEYMAPS:

-- Zoxide.
keymap('n', '<Leader>fz', '<Cmd>Telescope zoxide list<CR>', opts)

-- Refactoring.
keymap(
  'v',
  '<Leader>fr',
  "<Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
  opts
)
