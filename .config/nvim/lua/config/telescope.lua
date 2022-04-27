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
keymap('n', '<Leader>ff', "<Cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap('n', '<Leader>fg', "<Cmd>lua require('telescope.builtin').live_grep()<CR>", opts)

-- Vim pickers.
keymap('n', '<Leader>fb', "<Cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap('n', '<Leader>fh', "<Cmd>lua require('telescope.builtin').command_history()<CR>", opts)
keymap('n', '<Leader>fq', "<Cmd>lua require('telescope.builtin').quickfix()<CR>", opts)
keymap('n', '<Leader>fl', "<Cmd>lua require('telescope.builtin').loclist()<CR>", opts)

-- LSP pickers.
keymap('n', '<Leader>fd', "<Cmd>lua require('telescope.builtin').diagnostics()<CR>", opts)
keymap('n', '<Leader>fr', "<Cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
keymap('n', '<Leader>fi', "<Cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
keymap('n', '<Leader>fa', "<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", opts)

-- Git:
keymap('n', '<Leader>fs', "<Cmd>lua require('telescope.builtin').git_status()<CR>", opts)

-- List pickers.
keymap('n', '<Leader>fp', "<Cmd>lua require('telescope.builtin').builtin()<CR>", opts)

-- Custom pickers:
keymap('n', '<Leader>fn', "<Cmd>lua require('config.telescope').grep_notes()<CR>", opts)
keymap('n', '<Leader>fc', "<Cmd>lua require('config.telescope').grep_config()<CR>", opts)
keymap('n', '<Leader>fv', "<Cmd>lua require('config.telescope').grep_neovim()<CR>", opts)

-- PLUGIN_KEYMAPS:

-- Zoxide.
keymap('n', '<Leader>fz', "<Cmd>lua require('telescope').extensions.zoxide.list()<CR>", opts)

-- Refactoring.
keymap('v', '<Leader>fr', "<Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", opts)

-- BUFFER_KEYMAPS:

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Telescope keymaps will close Explore window.
autocmd('FileType', {
  callback = function()
    keymap('n', '<Leader>ff', "<Cmd>bd<CR><Cmd>lua require('telescope.builtin').find_files()<CR>", { buffer = 0 })
    keymap('n', '<Leader>fg', "<Cmd>bd<CR><Cmd>lua require('telescope.builtin').live_grep()<CR>", { buffer = 0 })
    keymap('n', '<Leader>fb', "<Cmd>bd<CR><Cmd>lua require('telescope.builtin').buffers()<CR>", { buffer = 0 })
    keymap('n', '<Leader>fz', "<Cmd>bd<CR><Cmd>lua require('telescope').extensions.zoxide.list()<CR>", { buffer = 0 })
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
