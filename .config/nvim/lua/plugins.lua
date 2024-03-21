-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Installing plugins.
require("lazy").setup({
  -- LSP:

  'neovim/nvim-lspconfig', -- collection of lsp configurations
  -- 'folke/trouble.nvim' -- pretty lists
  'windwp/nvim-autopairs', -- create pairs

  -- COMPLETION:

  {
    'ms-jpq/coq_nvim', -- auto-completion
    branch = 'coq',
    dependencies = { { 'ms-jpq/coq.artifacts', branch = 'artifacts' } }, -- snippets
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
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
  },

  -- TELESCOPE:

  {
    'nvim-telescope/telescope.nvim', -- fuzzy finder
    dependencies = {
      {
        'nvim-lua/plenary.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          build = 'make'
        }
      },
    },
  },

  -- TREESITTER:

  'nvim-treesitter/nvim-treesitter', -- treesitter in neovim
  {
    'nvim-treesitter/nvim-treesitter-textobjects', -- syntax aware text-objects
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'windwp/nvim-ts-autotag', -- create tags
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  },
  {
    'ThePrimeagen/refactoring.nvim', -- extract, inline and print debug
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    }
  },

  -- DEBUGGING:

  {
    'mfussenegger/nvim-dap', -- debugging
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { "nvim-neotest/nvim-nio" }
      },
    },
  },

  -- VISUALS:

  'folke/tokyonight.nvim', -- colorscheme
  'luisiacc/gruvbox-baby', -- colorscheme
  {
    'hoob3rt/lualine.nvim', -- better status line
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  { 'lewis6991/gitsigns.nvim', tag = 'release' }, -- git column icons
  'lukas-reineke/indent-blankline.nvim', -- indent guides
  'akinsho/bufferline.nvim', -- buffer line with tabpage integration.

  -- COMMENTS:

  'numToStr/Comment.nvim', -- comments

  -- MOVEMENTS:

  'unblevable/quick-scope', -- highlight for f, F, t, T movements
  'chaoren/vim-wordmotion', -- camel case, snake case etc. become separate words

  -- MISC:

  'tpope/vim-surround', -- change surrounding chars
  'tpope/vim-dadbod', -- database interaction
  'tpope/vim-fugitive', -- Git wrapper
  'tpope/vim-obsession', -- sessions
  'kwkarlwang/bufresize.nvim', -- better buffer resizing

  -- MY_PLUGINS:

  -- if vim.fn.getenv('USER') == 'declancm' then
  --   -- Local files.
  --   '~/plugins/cinnamon.nvim',
  --   '~/plugins/windex.nvim',
  --   '~/plugins/maximize.nvim',
  --   '~/plugins/vim2vscode',
  --   '~/plugins/git-scripts.nvim',
  -- else
  'declancm/cinnamon.nvim', -- neovim smooth scrolling
  'declancm/windex.nvim', -- cleaner window movements
  'declancm/maximize.nvim', -- window maximizing
  'declancm/vim2vscode', -- open current buffers in vscode
  'declancm/git-scripts.nvim' -- async git functions
  -- end
})
