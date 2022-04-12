local opts = { silent = true }
local keymap = vim.keymap.set

-- THEME:

local theme = vim.g.__selected_theme

vim.opt.background = 'dark'
vim.opt.colorcolumn = '80'

-- GRUVBOX:

if theme == 'gruvbox' then
  vim.g.gruvbox_baby_transparent_mode = 1
  -- vim.g.gruvbox_baby_comment_style = 'NONE'
  vim.cmd([[colorscheme gruvbox-baby]])
  vim.cmd([[highlight ColorColumn ctermbg=0 guibg=#3c3836]])
  vim.cmd([[highlight LineNr guifg=#458588]])
  vim.cmd([[highlight Pmenu ctermbg=0 guibg=#3c3836]])
end

-- ONEDARK:

if theme == 'onedark' then
  local onedark_status, onedark = pcall(require, 'onedark')
  if not onedark_status then
    print("'onedark' executed with errors.")
    return
  end
  onedark.setup {
    style = 'dark',
    transparent = true,
    -- code_style = { comments = 'none' },
  }
  vim.cmd([[colorscheme onedark]])
  vim.cmd([[highlight ColorColumn ctermbg=0 guibg=#31353f]])
  vim.cmd([[highlight LineNr guifg=#61AFEF]])
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
    icons_enabled = true,
    theme = theme,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = {
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
      'encoding',
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { 'fugitive' },
}

-- GITSIGNS:

local gitsigns_status, gitsigns = pcall(require, 'gitsigns')
if not gitsigns_status then
  print("'gitsigns' executed with errors.")
  return
end

gitsigns.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    changedelete = {
      hl = 'GitSignsDelete',
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
  },
  current_line_blame_opts = {
    delay = 0,
    ignore_whitespace = true,
  },
  keymaps = {},
}

local gs = package.loaded.gitsigns

keymap({ 'n', 'x' }, '<Leader>tb', gs.toggle_current_line_blame, opts)

-- TODO-COMMENTS:

local todo_status, todo = pcall(require, 'todo-comments')
if not todo_status then
  print("'todo-comments' executed with errors.")
  return
end

todo.setup {
  -- signs = false,
}

keymap('n', '<Leader>ft', '<Cmd>TodoTelescope<CR>', opts)

-- COLORIZER:

local colorizer_status, colorizer = pcall(require, 'colorizer')
if not colorizer_status then
  print("'colorizer' executed with errors.")
  return
end

colorizer.setup()

-- INDENT_BLANKLINE:

local indent_status, indent = pcall(require, 'indent_blankline')
if not indent_status then
  print("'indent_blankline' executed with errors.")
  return
end

indent.setup {
  char = '▏', -- faint line
  -- char = '▎', -- thick line
  show_trailing_blankline_indent = false,
  max_indent_increase = 1,
  use_treesittter = true,
  -- show_current_context = true,
  -- show_current_context_start = true,
}

-- INCLINE:
local incline_status, incline = pcall(require, 'incline')
if not incline_status then
  print("'incline' executed with errors.")
  return
end

-- incline.setup()
