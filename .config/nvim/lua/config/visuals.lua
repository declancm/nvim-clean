local keymap = vim.keymap.set

-- THEME:

local theme = vim.g.__selected_theme

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

local gps_status, gps = pcall(require, 'nvim-gps')
if not gps_status then
  print("'gps'executed with errors.")
  return
end

gps.setup { disable_icons = true }

lualine.setup {
  options = {
    theme = theme,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = {
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
    lualine_x = {
      { gps.get_location, cond = gps.is_available },
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

keymap({ 'n', 'x' }, '<Leader>tb', gs.toggle_current_line_blame)

-- TODO-COMMENTS:

local todo_status, todo = pcall(require, 'todo-comments')
if not todo_status then
  print("'todo-comments' executed with errors.")
  return
end

todo.setup {
  -- signs = false,
}

keymap('n', '<Leader>ft', '<Cmd>TodoTelescope<CR>')

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

local function maximize_status()
  return vim.t.maximized and ' ' or ''
end

incline.setup {
  -- hide = {
  --   only_win = true,
  -- },
  ignore = {
    filetypes = { 'CHADTree' },
    floating_wins = true,
  },
  render = function(props)
    local color = 'none'
    local color2 = 'none'
    if theme == 'gruvbox' then
      color = '#504945'
      color2 = '#a89984'
    elseif theme == 'tokyonight' then
      color = '#3b4261'
      color2 = '#7aa2f7'
    end
    local bufname = vim.api.nvim_buf_get_name(props.buf)
    if bufname ~= '' and maximize_status() ~= '' then
      return {
        { '', guibg = 'none', guifg = color },
        { ' ' .. vim.fn.fnamemodify(bufname, ':t') .. ' ', guibg = color },
        { '', guibg = color2, guifg = color },
        { ' ' .. maximize_status() .. ' ', guibg = color2, guifg = color },
        { '', guibg = 'none', guifg = color2 },
      }
    elseif bufname ~= '' then
      return {
        { '', guibg = 'none', guifg = color },
        { ' ' .. vim.fn.fnamemodify(bufname, ':t') .. ' ', guibg = color },
        { '', guibg = 'none', guifg = color },
      }
    end
    return {
      { '' },
    }
  end,
  window = {
    margin = {
      horizontal = 0,
    },
  },
}

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
    offsets = {
      { filetype = 'netrw', text_align = 'left' },
    },
    always_show_bufferline = false,
  },
}

-- CHADTREE:

vim.api.nvim_set_var('chadtree_settings', {
  ['options.close_on_open'] = true,
  ['theme.text_colour_set'] = 'solarized_light',
  ['options.session'] = false,
  ['view.open_direction'] = 'right',
})

keymap('n', '<Leader>ct', '<Cmd>CHADopen<CR>')
keymap('n', '<Leader>cl', '<Cmd>CHADopen --version-ctl<CR>')
keymap('n', '<Leader>cq', '<Cmd>call setqflist([])<CR>')
