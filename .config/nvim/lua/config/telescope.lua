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

local keymap = vim.keymap.set

local function close_buffer()
  local ft = vim.bo.filetype
  if ft == 'CHADTree' or ft == 'netrw' then
    vim.cmd('bd')
  end
end

-- File pickers.
keymap('n', '<Leader>ff', function()
  close_buffer()
  require('telescope.builtin').find_files()
end)
keymap('n', '<Leader>fg', function()
  close_buffer()
  require('telescope.builtin').live_grep()
end)

-- Vim pickers.
keymap('n', '<Leader>fb', function()
  close_buffer()
  require('telescope.builtin').buffers()
end)
keymap('n', '<Leader>fh', function()
  close_buffer()
  require('telescope.builtin').command_history()
end)
keymap('n', '<Leader>fq', function()
  close_buffer()
  require('telescope.builtin').quickfix()
end)
keymap('n', '<Leader>fl', function()
  close_buffer()
  require('telescope.builtin').loclist()
end)

-- LSP pickers.
keymap('n', '<Leader>fd', function()
  close_buffer()
  require('telescope.builtin').diagnostics()
end)
keymap('n', '<Leader>fr', function()
  close_buffer()
  require('telescope.builtin').lsp_references()
end)
keymap('n', '<Leader>fi', function()
  close_buffer()
  require('telescope.builtin').lsp_implementations()
end)
keymap('n', '<Leader>fa', function()
  close_buffer()
  require('telescope.builtin').lsp_code_actions()
end)

-- Git:
keymap('n', '<Leader>fs', function()
  close_buffer()
  require('telescope.builtin').git_status()
end)

-- List pickers.
keymap('n', '<Leader>fp', function()
  close_buffer()
  require('telescope.builtin').builtin()
end)

-- Custom pickers:
keymap('n', '<Leader>fn', function()
  close_buffer()
  require('config.telescope').grep_notes()
end)
keymap('n', '<Leader>fc', function()
  close_buffer()
  require('config.telescope').grep_config()
end)
keymap('n', '<Leader>fv', function()
  close_buffer()
  require('config.telescope').grep_neovim()
end)

-- PLUGIN_KEYMAPS:

-- Zoxide.
keymap('n', '<Leader>fz', function()
  close_buffer()
  require('telescope').extensions.zoxide.list()
end)

-- Refactoring.
keymap('v', '<Leader>fr', function()
  close_buffer()
  require('telescope').extensions.refactoring.refactors()
end)

-- CUSTOM_PICKERS:

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
