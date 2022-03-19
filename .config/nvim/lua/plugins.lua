-- Clone packer if it doesn't already exist.
local path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(path)) > 0 then
  local command = { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', path }
  PackerBootstrap = vim.fn.system(command)
end

-- Packer uses a floating window.
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
    'ms-jpq/coq_nvim', -- auto-completion
    branch = 'coq',
    requires = { { 'ms-jpq/coq.artifacts', branch = 'artifacts' } },
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip', -- snippets
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
      -- { 'tzachar/cmp-tabnine', run = './install.sh' },
    },
  }
  -- use 'tami5/lspsaga.nvim' -- lsp functions
  -- use 'folke/trouble.nvim' -- pretty lists

  -- TELESCOPE:

  use {
    'nvim-telescope/telescope.nvim', -- fuzzy finder
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      'jvgrootveld/telescope-zoxide',
    },
  }

  -- TREESITTER:

  use {
    'nvim-treesitter/nvim-treesitter', -- treesitter in neovim
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    },
  }
  use 'simrat39/symbols-outline.nvim'
  use 'ThePrimeagen/refactoring.nvim' -- extract, inline and print debug

  -- DEBUGGING:

  use 'mfussenegger/nvim-dap' -- debugging
  use 'theHamsta/nvim-dap-virtual-text'
  use 'rcarriga/nvim-dap-ui' -- debugging ui

  -- VISUALS:

  use 'folke/tokyonight.nvim' -- colorscheme
  use 'navarasu/onedark.nvim' -- colorscheme
  use 'luisiacc/gruvbox-baby' -- colorscheme
  use 'hoob3rt/lualine.nvim' -- better status line
  use {
    'lewis6991/gitsigns.nvim', -- git column icons
    tag = 'release',
  }
  use 'folke/todo-comments.nvim' -- better todo comments
  use 'norcalli/nvim-colorizer.lua' -- preview colors for color codes
  use 'lukas-reineke/indent-blankline.nvim' -- indent guides

  -- SPEED:

  use 'unblevable/quick-scope' -- highlight for f, F, t, T movements
  use 'machakann/vim-sandwich' -- change surrounding chars
  use 'b3nj5m1n/kommentary' -- comments
  use 'dkarter/bullets.vim' -- bullets
  use 'arthurxavierx/vim-caser' -- word coercion
  -- use 'ggandor/lightspeed.nvim' -- another movement

  -- MISC:

  use 'chaoren/vim-wordmotion' -- camel case, snake case etc. become separate words
  use 'mbbill/undotree' -- tree view of undo history
  use {
    'ms-jpq/chadtree', -- filetree
    branch = 'chad',
    run = 'python3 -m chadtree deps',
  }
  use {
    'iamcco/markdown-preview.nvim', -- preview markdown in browser
    run = 'cd app && yarn install',
  }
  use {
    'tpope/vim-fugitive', -- Git
    requires = { 'junegunn/gv.vim' },
  }
  use 'tpope/vim-obsession' -- sessions
  use 'tpope/vim-capslock' -- software capslock
  -- use {
  --   'tpope/vim-dadbod',
  --   requires = {
  --     'kristijanhusak/vim-dadbod-completion',
  --     'kristijanhusak/vim-dadbod-ui',
  --   },
  -- }

  -- MY_PLUGINS:

  if vim.fn.getenv 'USER' == 'declancm' then
    -- Local files.
    use '~/plugins/cinnamon.nvim'
    -- use '~/plugins/vim-cinnamon'
    use '~/plugins/vim2vscode'
    use '~/plugins/git-scripts.nvim'
  else
    use 'declancm/cinnamon.nvim' -- neovim smooth scrolling
    use 'declancm/vim2vscode' -- open current buffers in vscode
    use 'declancm/git-scripts.nvim' -- async git functions
  end

  -- Install packer if it was just git cloned.
  if PackerBootstrap then
    require('packer').sync()
  end
end)
