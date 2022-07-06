-- Clone packer if it doesn't already exist.
local path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
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
  use('wbthomason/packer.nvim') -- plugin manager

  -- DEPENDENCIES:

  use('nvim-lua/plenary.nvim') -- lua functions
  use('kyazdani42/nvim-web-devicons') -- icons library

  -- LSP:

  use('neovim/nvim-lspconfig') -- collection of lsp configurations
  use('jose-elias-alvarez/null-ls.nvim') -- use neovim as a language server
  -- use 'glepnir/lspsaga.nvim' -- lsp functions
  -- use 'folke/trouble.nvim' -- pretty lists
  use('windwp/nvim-autopairs') -- create pairs

  -- COMPLETION:

  use {
    'ms-jpq/coq_nvim', -- auto-completion
    branch = 'coq',
    requires = { { 'ms-jpq/coq.artifacts', branch = 'artifacts' } }, -- snippets
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip', -- snippets
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'andersevenrud/cmp-tmux',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
      -- { 'tzachar/cmp-tabnine', run = './install.sh' },
      'hrsh7th/cmp-calc',
    },
  }

  -- TELESCOPE:

  use {
    'nvim-telescope/telescope.nvim', -- fuzzy finder
    tag = 'nvim-0.6',
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
      -- 'nvim-treesitter/playground',
      'windwp/nvim-ts-autotag',
    },
  }
  use('lewis6991/spellsitter.nvim') -- spellchecker
  use('simrat39/symbols-outline.nvim')
  use('ThePrimeagen/refactoring.nvim') -- extract, inline and print debug

  -- DEBUGGING:

  use {
    'mfussenegger/nvim-dap', -- debugging
    requires = {
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
    },
  }

  -- LANGUAGE_SPECIFIC:

  -- use {
  --   'tpope/vim-dadbod', -- database interaction
  --   requires = {
  --     'kristijanhusak/vim-dadbod-completion',
  --     'kristijanhusak/vim-dadbod-ui',
  --   },
  -- }
  use {
    'iamcco/markdown-preview.nvim', -- preview markdown in browser
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  }

  -- VISUALS:

  use('folke/tokyonight.nvim') -- colorscheme
  use('luisiacc/gruvbox-baby') -- colorscheme
  use {
    'hoob3rt/lualine.nvim', -- better status line
    requires = { 'SmiteshP/nvim-navic' }, -- show current scope
  }
  use {
    'lewis6991/gitsigns.nvim', -- git column icons
    tag = 'release',
  }
  use('folke/todo-comments.nvim') -- better todo comments
  use('norcalli/nvim-colorizer.lua') -- preview colors for color codes
  use('lukas-reineke/indent-blankline.nvim') -- indent guides
  use('b0o/incline.nvim') -- floating statuslines
  use('akinsho/bufferline.nvim') -- buffer line with tabpage integration.
  use {
    'ms-jpq/chadtree', -- better filetree
    branch = 'chad',
    run = 'python3 -m chadtree deps',
  }

  -- COMMENTS:

  use('numToStr/Comment.nvim') -- comments

  -- MOVEMENTS:

  use('unblevable/quick-scope') -- highlight for f, F, t, T movements
  use('machakann/vim-sandwich') -- change surrounding chars
  use('arthurxavierx/vim-caser') -- word coercion
  use('chaoren/vim-wordmotion') -- camel case, snake case etc. become separate words
  use('mizlan/iswap.nvim') -- interactive swap

  -- MISC:

  use('mbbill/undotree') -- tree view of undo history
  use {
    'tpope/vim-fugitive', -- Git
    requires = { 'junegunn/gv.vim' },
  }
  use {
    'dkarter/bullets.vim', -- bullets
    ft = { 'markdown', 'text' },
  }
  use('tpope/vim-obsession') -- sessions
  use('tpope/vim-capslock') -- software capslock
  use('kwkarlwang/bufresize.nvim') -- better buffer resizing
  -- use('luukvbaal/stabilize.nvim') -- stabile window events
  use('antoinemadec/FixCursorHold.nvim') -- fix a bug with neovim autocmds

  -- MY_PLUGINS:

  if vim.fn.getenv('USER') == 'declancm' then
    -- Local files.
    use('~/plugins/cinnamon.nvim')
    use('~/plugins/windex.nvim')
    use('~/plugins/maximize.nvim')
    use('~/plugins/vim2vscode')
    use('~/plugins/git-scripts.nvim')
  else
    use('declancm/cinnamon.nvim') -- neovim smooth scrolling
    use('declancm/windex.nvim') -- cleaner window movements
    use('declancm/maximize.nvim') -- window maximizing
    use('declancm/vim2vscode') -- open current buffers in vscode
    use('declancm/git-scripts.nvim') -- async git functions
  end

  -- Install packer if it was just git cloned.
  if PackerBootstrap then
    require('packer').sync()
  end
end)
