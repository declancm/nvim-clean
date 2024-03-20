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
  -- DEPENDENCIES:

  'nvim-lua/plenary.nvim', -- lua functions
  'kyazdani42/nvim-web-devicons', -- icons library

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
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
    },
  },
  -- 'nvim-telescope/telescope-file-browser.nvim',
  -- 'jvgrootveld/telescope-zoxide',

  -- TREESITTER:

  {
    'nvim-treesitter/nvim-treesitter', -- treesitter in neovim
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      -- 'nvim-treesitter/playground',
    },
  },
  'windwp/nvim-ts-autotag', -- create tags
  'lewis6991/spellsitter.nvim', -- spellchecker
  'simrat39/symbols-outline.nvim',
  'ThePrimeagen/refactoring.nvim', -- extract, inline and print debug

  -- DEBUGGING:

  {
    'mfussenegger/nvim-dap', -- debugging
    dependencies = {
      'theHamsta/nvim-dap-virtual-text',
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { "nvim-neotest/nvim-nio" }
      },
    },
  },

  -- LANGUAGE_SPECIFIC:

  {
    'tpope/vim-dadbod', -- database interaction
    dependencies = {
      'kristijanhusak/vim-dadbod-completion',
      'kristijanhusak/vim-dadbod-ui',
    },
  },
  {
    'iamcco/markdown-preview.nvim', -- preview markdown in browser
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  -- VISUALS:

  'folke/tokyonight.nvim', -- colorscheme
  'luisiacc/gruvbox-baby', -- colorscheme
  {
    'hoob3rt/lualine.nvim', -- better status line
    dependencies = { 'SmiteshP/nvim-navic' }, -- show current scope
  },
  { 'lewis6991/gitsigns.nvim', tag = 'release' }, -- git column icons
  'folke/todo-comments.nvim', -- better todo comments
  'norcalli/nvim-colorizer.lua', -- preview colors for color codes
  'lukas-reineke/indent-blankline.nvim', -- indent guides
  'b0o/incline.nvim', -- floating statuslines
  'akinsho/bufferline.nvim', -- buffer line with tabpage integration.

  -- COMMENTS:

  { 'numToStr/Comment.nvim', tag = 'v0.6.1' }, -- comments

  -- MOVEMENTS:

  'unblevable/quick-scope', -- highlight for f, F, t, T movements
  'machakann/vim-sandwich', -- change surrounding chars
  'arthurxavierx/vim-caser', -- word coercion
  'chaoren/vim-wordmotion', -- camel case, snake case etc. become separate words
  'mizlan/iswap.nvim', -- interactive swap

  -- MISC:

  'mbbill/undotree', -- tree view of undo history
  {
    'tpope/vim-fugitive', -- Git
    dependencies = { 'junegunn/gv.vim' },
  },
  {
    'dkarter/bullets.vim', -- bullets
    ft = { 'markdown', 'text' },
  },
  'tpope/vim-obsession', -- sessions
  'tpope/vim-capslock', -- software capslock
  'kwkarlwang/bufresize.nvim', -- better buffer resizing
  {
    'ms-jpq/chadtree', -- better filetree
    branch = 'chad',
    run = 'python3 -m chadtree deps',
  },

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
