local keymap = vim.keymap.set

-- THEME:

local theme = require('user-config').theme

vim.opt.background = 'dark'
-- vim.opt.colorcolumn = '80'

-- GRUVBOX:

if theme == 'gruvbox' then
  vim.g.gruvbox_baby_transparent_mode = 1
  -- vim.g.gruvbox_baby_comment_style = 'NONE'
  vim.cmd([[colorscheme gruvbox-baby]])
  vim.cmd([[highlight ColorColumn ctermbg=0 guibg=#3c3836]])
  vim.cmd([[highlight LineNr guifg=#458588]])
  vim.cmd([[highlight Pmenu ctermbg=0 guibg=#3c3836]])
end

-- TOKYONIGHT:

if theme == 'tokyonight' then
  vim.g.tokyonight_style = 'storm'
  vim.g.tokyonight_transparent = true
  vim.g.tokyonight_transparent_sidebar = true
  -- vim.g.tokyonight_italic_comments = false
  vim.g.tokyonight_colors = { bg_float = 'NONE' }
  vim.cmd([[colorscheme tokyonight]])
  vim.cmd([[highlight ColorColumn ctermbg=0 guibg=#1f2335]])
  vim.cmd([[highlight LineNr guifg=#3D59A1]])
end

-- Highlight the line number.
vim.cmd([[highlight CursorLineNr guifg=white]])
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- End of buffer:
-- vim.cmd([[highlight EndOfBuffer guifg=NONE]])

-- Transparent popup menus.
-- vim.cmd [[highlight Pmenu ctermbg=0 guibg=NONE]]

-- End-of-line character.
-- vim.opt.list = true
-- vim.opt.listchars:append 'eol:↴'

-- LUALINE:

local lualine_status, lualine = pcall(require, 'lualine')
if not lualine_status then
  print("'lualine' executed with errors.")
  return
end

lualine.setup {
  options = {
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' ',
        },
      },
    },
  },

  extensions = { 'fugitive' },
}

-- GITSIGNS:

local gitsigns_status, gitsigns = pcall(require, 'gitsigns')
if not gitsigns_status then
  print("'gitsigns' executed with errors.")
  return
end

gitsigns.setup {
  current_line_blame_opts = {
    delay = 0
  }
}

local gs = package.loaded.gitsigns
keymap({ 'n', 'x' }, '<Leader>tb', gs.toggle_current_line_blame)

-- INDENT_BLANKLINE:

local indent_status, ibl = pcall(require, 'ibl')
if not indent_status then
  print("'indent_blankline' executed with errors.")
  return
end

ibl.setup {
  indent = {
    char = '▏', -- faint line
    -- char = '▎', -- thick line
    -- char = '╎', -- dotted line
  }
}

-- INCLINE:

local incline_status, incline = pcall(require, 'incline')
if not incline_status then
  print("'incline' executed with errors.")
  return
end

incline.setup()

-- BUFFERLINE:

local bufferline_status, bufferline = pcall(require, 'bufferline')
if not bufferline_status then
  print("'bufferline' executed with errors.")
  return
end

bufferline.setup {
  options = {
    mode = 'tabs',
    diagnostics = 'nvim_lsp',
    always_show_bufferline = false,
  },
}
