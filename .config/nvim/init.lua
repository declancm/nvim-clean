local theme, completion

-- THEME:
theme = 'gruvbox'
-- theme = 'onedark'
-- theme = 'tokyonight'

-- COMPLETION:
-- completion = 'coq' -- faster completion
completion = 'cmp' -- lots of good sources

vim.g.__selected_theme = theme
vim.g.__selected_completion = completion

-- Starting Python.
vim.g.python3_host_prog = '/bin/python3'
vim.g.python_host_prog = '/bin/python2'

-- PRE-CONFIG_OPTIONS:
vim.opt.syntax = 'on'
vim.opt.termguicolors = true
vim.cmd 'let mapleader = "\\<BS>"'

-- Autocommands.
require 'configs.autocmds'

-- Packer.
require 'plugins'

-- PLUGIN_CONFIGS:
require 'configs.lsp'
require 'configs.telescope'
require 'configs.treesitter'
require 'configs.debugging'
require 'configs.visuals'
require 'configs.comments'
require 'configs.movements'
require 'configs.misc'
require 'configs.my-plugins'

-- CONFIGS:
require 'configs.functions'
require 'configs.keymaps'

-- Options.
require 'options'
