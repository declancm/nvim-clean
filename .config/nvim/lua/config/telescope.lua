-- TELESCOPE:

local telescope_status, telescope = pcall(require, 'telescope')
if not telescope_status then
  print("'telescope' executed with errors.")
  return
end

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
      find_command = { 'rg', '--ignore', '--follow', '--hidden', '--files' },
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

telescope.load_extension('fzf')
telescope.load_extension('zoxide')
telescope.load_extension('refactoring')

-- KEYMAPS:

local opts = { silent = true }
local keymap = vim.keymap.set

-- File pickers.
keymap('n', '<Leader>ff', function()
  require('telescope.builtin').find_files()
end, opts)
keymap('n', '<Leader>fg', function()
  require('telescope.builtin').live_grep()
end, opts)

-- Vim pickers.
keymap('n', '<Leader>fb', function()
  require('telescope.builtin').buffers()
end, opts)
keymap('n', '<Leader>fh', function()
  require('telescope.builtin').command_history()
end, opts)
keymap('n', '<Leader>fq', function()
  require('telescope.builtin').quickfix()
end, opts)
keymap('n', '<Leader>fl', function()
  require('telescope.builtin').loclist()
end, opts)

-- LSP pickers.
keymap('n', '<Leader>fd', function()
  require('telescope.builtin').diagnostics()
end, opts)
keymap('n', '<Leader>fr', function()
  require('telescope.builtin').lsp_references()
end, opts)
keymap('n', '<Leader>fi', function()
  require('telescope.builtin').lsp_implementations()
end, opts)
keymap('n', '<Leader>fa', function()
  require('telescope.builtin').lsp_code_actions()
end, opts)

-- Git:
keymap('n', '<Leader>fs', function()
  require('telescope.builtin').git_status()
end, opts)

-- List pickers.
keymap('n', '<Leader>fp', function()
  require('telescope.builtin').builtin()
end, opts)

-- Custom pickers:
keymap('n', '<Leader>fn', function()
  require('config.telescope').grep_notes()
end, opts)
keymap('n', '<Leader>fc', function()
  require('config.telescope').grep_config()
end, opts)
keymap('n', '<Leader>fv', function()
  require('config.telescope').grep_neovim()
end, opts)

-- PLUGIN_KEYMAPS:

-- Zoxide.
keymap('n', '<Leader>fz', function()
  require('telescope').extensions.zoxide.list()
end, opts)

-- Refactoring.
keymap('v', '<Leader>fr', function()
  require('telescope').extensions.refactoring.refactors()
end, opts)

-- BUFFER_KEYMAPS:

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Telescope keymaps will close Explore window.
autocmd('FileType', {
  callback = function()
    keymap('n', '<Leader>ff', function()
      require('telescope.builtin').find_files()
    end, { buffer = 0 })
    keymap('n', '<Leader>fg', function()
      require('telescope.builtin').live_grep()
    end, { buffer = 0 })
    keymap('n', '<Leader>fb', function()
      require('telescope.builtin').buffers()
    end, { buffer = 0 })
    keymap('n', '<Leader>fz', function()
      require('telescope').extensions.zoxide.list()
    end, { buffer = 0 })
  end,
  pattern = 'netrw',
  group = augroup('explore_telescope', {}),
})

local M = {}

M.grep_notes = function()
  local options = {}
  -- options.search_dirs = { '~/notes/' }
  options.cwd = '~/notes/'
  options.prompt_title = 'Search Notes'
  options.shorten_path = true
  require('telescope.builtin').live_grep(options)
end

M.grep_config = function()
  local options = {}
  -- options.search_dirs = { '~/.config/nvim/' }
  options.opts = { file_ignore_patterns = { '^runtime/' } }
  options.cwd = '~/.config/nvim/'
  options.prompt_title = 'Config Files'
  options.shorten_path = true
  require('telescope.builtin').find_files(options)
end

M.grep_neovim = function()
  local options = {}
  -- options.search_dirs = { '~/neovim/' }
  options.cwd = '~/neovim/'
  options.shorten_path = true
  options.prompt_title = 'Search Neovim'
  require('telescope.builtin').live_grep(options)
end

return M
