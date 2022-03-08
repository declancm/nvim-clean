-- Clone packer if it doesn't already exist.
local path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(path)) > 0 then
  local remote = 'https://github.com/wbthomason/packer.nvim'
  local command = { 'git', 'clone', '--depth', '1', remote, path }
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
  use 'wbthomason/packer.nvim'

  -- DEPENDENCIES:

  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- LSP:

  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    requires = { { 'ms-jpq/coq.artifacts', branch = 'artifacts' } },
  }
  -- use 'tami5/lspsaga.nvim'
  -- use 'folke/trouble.nvim
  -- use 'folke/lsp-colors.nvim'
  -- use 'L3MON4D3/LuaSnip

  -- TELESCOPE:

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      'jvgrootveld/telescope-zoxide',
    },
  }

  -- TREESITTER:

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- use 'nvim-treesitter/playground'
  use 'ThePrimeagen/refactoring.nvim'
  use 'simrat39/symbols-outline.nvim'

  -- DEBUGGING:

  -- use 'mfussenegger/nvim-dap'

  -- VISUALS:

  use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'
  use 'luisiacc/gruvbox-baby'
  use 'hoob3rt/lualine.nvim'
  use { 'lewis6991/gitsigns.nvim', tag = 'release' }
  use 'folke/todo-comments.nvim'
  use 'norcalli/nvim-colorizer.lua'

  -- SPEED:

  use 'unblevable/quick-scope'
  use 'machakann/vim-sandwich'
  use 'b3nj5m1n/kommentary'
  use 'dkarter/bullets.vim'
  use 'arthurxavierx/vim-caser'
  -- use 'ggandor/lightspeed.nvim'

  -- MISC:

  use 'chaoren/vim-wordmotion'
  use 'mbbill/undotree'
  use { 'ms-jpq/chadtree', branch = 'chad', run = 'python3 -m chadtree deps' }
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }
  use {
    'tpope/vim-fugitive',
    requires = { 'tpope/git-bump', 'junegunn/gv.vim' },
  }
  use 'tpope/vim-obsession'
  use 'tpope/vim-capslock'

  -- MY_PLUGINS:

  -- Remote repository files.
  -- use 'declancm/cinnamon.nvim'
  -- use 'declancm/vim-cinnamon'
  -- use 'declancm/vim2vscode'
  -- use 'declancm/git-scripts.nvim'

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
