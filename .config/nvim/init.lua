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
-- require 'configs.debugging'
require 'configs.visuals'
require 'configs.speed'
require 'configs.misc'
require 'configs.my-plugins'

-- CONFIGS:
require 'configs.functions'
require 'configs.keymaps'

-- OPTIONS:
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath 'config' .. '/undodir'
vim.opt.undofile = true
-- vim.opt.hidden = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.showmode = true
-- vim.opt.errorbells = false
vim.opt.cmdheight = 2
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.smartcase = true
vim.opt.wrap = false
-- vim.opt.textwidth = 0
-- vim.opt.wrapmargin = 0
vim.opt.expandtab = true
vim.opt.autoindent = true
-- vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.scrolloff = 8
vim.opt.iskeyword = vim.opt.iskeyword - '_'
vim.opt.backspace = { 'indent', 'eol', 'start', 'nostop' }
vim.opt.updatetime = 100
vim.opt.shortmess = vim.opt.shortmess + 'ac'
-- vim.opt.modifiable = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 500
vim.opt.mouse = 'a'
vim.opt.path = vim.opt.path + '**'
vim.opt.textwidth = 80
vim.opt.pastetoggle = '<F9>'

-- NOTE: Unmapping the arrow keys for practice.
local keymap = vim.api.nvim_set_keymap
keymap('', '<Up>', '', { noremap = true })
keymap('', '<Down>', '', { noremap = true })
keymap('', '<Left>', '', { noremap = true })
keymap('', '<Right>', '', { noremap = true })
keymap('i', '<Up>', '', { noremap = true })
keymap('i', '<Down>', '', { noremap = true })
keymap('i', '<Left>', '', { noremap = true })
keymap('i', '<Right>', '', { noremap = true })
