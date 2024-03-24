-- TELESCOPE:

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
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
          vim.cmd('normal! cB')
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
    -- selection_caret = '▶ ',
  },
  pickers = {
    find_files = {
      file_ignore_patterns = { 'node_modules', '.git', '.venv' },
      find_command = { 'rg', '--ignore', '--follow', '--hidden', '--files' },
    },
    live_grep = {
      file_ignore_patterns = { 'node_modules', '.git', '.venv' },
      additional_args = function(opts)
        return { '--hidden' }
      end
    }
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

telescope.load_extension('fzf')
telescope.load_extension('refactoring')

-- KEYMAPS:

local keymap = vim.keymap.set
local builtin = require('telescope.builtin')

-- File pickers.
keymap('n', '<Leader>ff', builtin.find_files, {})
keymap('n', '<Leader>fg', builtin.live_grep, {})

-- Vim pickers.
keymap('n', '<Leader>fb', builtin.buffers, {})
keymap('n', '<Leader>fh', builtin.command_history, {})
keymap('n', '<Leader>fq', builtin.quickfix, {})
keymap('n', '<Leader>fl', builtin.loclist, {})

-- -- LSP pickers.
keymap('n', 'gd', builtin.lsp_definitions, {})
keymap('n', 'gr', builtin.lsp_references, {})
keymap('n', 'gi', builtin.lsp_implementations, {})
keymap('n', 'gt', builtin.lsp_type_definitions, {})
keymap('n', '<Leader>fd', builtin.diagnostics, {})

-- Git:
keymap('n', '<Leader>fs', builtin.git_status, {})

-- List pickers.
keymap('n', '<Leader>fp', builtin.builtin, {})

-- PLUGIN_KEYMAPS:

-- Refactoring.
keymap('v', '<Leader>fr', require('telescope').extensions.refactoring.refactors, {})
