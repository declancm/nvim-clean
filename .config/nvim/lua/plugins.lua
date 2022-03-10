-- Clone packer if it doesn't already exist.
local path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(path)) > 0 then
  local command = { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', path }
  PackerBootstrap = vim.fn.system(command)
end

-- Packer outputs to a floating window.
require('packer').init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

-- Installing plugins.
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- plugin manager

  -- DEPENDENCIES:

  use 'nvim-lua/plenary.nvim' -- lua functions
  use 'kyazdani42/nvim-web-devicons' -- icons library

  -- LSP:

  use 'neovim/nvim-lspconfig' -- collection of lsp configurations
  use 'jose-elias-alvarez/null-ls.nvim' -- use neovim as a language server
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    requires = { { 'ms-jpq/coq.artifacts', branch = 'artifacts' } },
  } -- completion
  -- use 'tami5/lspsaga.nvim' -- lsp functions
  -- use 'folke/trouble.nvim' -- pretty lists
  -- use 'folke/lsp-colors.nvim' -- add lsp colors to unsupported colorschemes
  -- use 'L3MON4D3/LuaSnip -- snippets

  -- TELESCOPE:

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      'jvgrootveld/telescope-zoxide',
    },
  } -- fuzzy finder

  -- TREESITTER:

  use {
    'nvim-treesitter/nvim-treesitter', -- treesitter in neovim
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    },
  }
  use 'ThePrimeagen/refactoring.nvim' -- extract, inline and print debug
  use 'simrat39/symbols-outline.nvim'

  -- DEBUGGING:

  -- use 'mfussenegger/nvim-dap' -- debugging

  -- VISUALS:

  use 'folke/tokyonight.nvim' -- colorscheme
  use 'navarasu/onedark.nvim' -- colorscheme
  use 'luisiacc/gruvbox-baby' -- colorscheme
  use 'hoob3rt/lualine.nvim' -- better status line
  use { 'lewis6991/gitsigns.nvim', tag = 'release' } -- git column icons
  use 'folke/todo-comments.nvim' -- better todo comments
  use 'norcalli/nvim-colorizer.lua' -- preview colors for color codes

  -- SPEED:

  use 'unblevable/quick-scope' -- highlight for f, F, t, T movements
  use 'machakann/vim-sandwich' -- change surrounding chars
  use 'b3nj5m1n/kommentary' -- comments
  use 'dkarter/bullets.vim' -- bullets
  use 'arthurxavierx/vim-caser' -- word coercion
  -- use 'ggandor/lightspeed.nvim' -- added movement

  -- MISC:

  use 'chaoren/vim-wordmotion' -- change what a word is
  use 'mbbill/undotree' -- tree view of undo history
  use {
    'ms-jpq/chadtree',
    branch = 'chad',
    run = 'python3 -m chadtree deps',
  } -- filetree
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
  use {
    'tpope/vim-fugitive',
    requires = { 'tpope/git-bump', 'junegunn/gv.vim' },
  } -- Git
  use 'tpope/vim-obsession' -- sessions
  use 'tpope/vim-capslock' -- software capslock

  -- MY_PLUGINS:

  -- Remote repository files.
  -- use 'declancm/cinnamon.nvim' -- smooth scrolling
  -- use 'declancm/vim-cinnamon' -- smoothe scrolling
  -- use 'declancm/vim2vscode' -- open current buffers in vscode
  -- use 'declancm/git-scripts.nvim' -- async git functions

  -- Local files.
  use '~/Git/cinnamon.nvim'
  -- use '~/Git/vim-cinnamon'
  use '~/Git/vim2vscode'
  use '~/Git/git-scripts.nvim'

  -- Install packer if it was just git cloned.
  if PackerBootstrap then
    require('packer').sync()
  end
end)
