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

-- NAVIC:

local navic_status, navic = pcall(require, 'nvim-navic')
if not navic_status then
  print("'navic'executed with errors.")
  return
end

navic.setup()

-- LUALINE:

local lualine_status, lualine = pcall(require, 'lualine')
if not lualine_status then
  print("'lualine' executed with errors.")
  return
end

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
      { navic.get_location, cond = navic.is_available },
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

gitsigns.setup()

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

local function maximize_status()
  return vim.t.maximized and ' ' or ''
end

incline.setup {
  ignore = {
    floating_wins = true,
  },
  render = function(props)
    local color = 'none'
    local color2 = 'none'
    local color3 = 'none'
    if theme == 'gruvbox' then
      color = '#3c3836'
      color2 = '#a89984'
      color3 = '#7c6f64'
    elseif theme == 'tokyonight' then
      color = '#3b4261'
      color2 = '#7aa2f7'
      color3 = '#737aa2'
    end

    local bufname = vim.api.nvim_buf_get_name(props.buf)
    if bufname ~= '' then
      bufname = vim.fn.fnamemodify(bufname, ':.')
      local tail = vim.fn.fnamemodify(bufname, ':t')
      local head = ''
      if #tail > 37 then
        tail = '...' .. bufname:sub(-37)
      elseif #bufname > 40 then
        bufname = '...' .. bufname:sub(-37)
        head = bufname:sub(0, #bufname - #tail)
      else
        head = bufname:sub(0, #bufname - #tail)
      end

      if maximize_status() ~= '' then
        return {
          { '', guibg = 'none', guifg = color },
          { ' ' .. head, guibg = color, guifg = color3 },
          { tail .. ' ', guibg = color },
          { '', guibg = color2, guifg = color },
          { ' ' .. maximize_status() .. ' ', guibg = color2, guifg = color },
          { '', guibg = 'none', guifg = color2 },
        }
      end

      return {
        { '', guibg = 'none', guifg = color },
        { ' ' .. head, guibg = color, guifg = color3 },
        { tail .. ' ', guibg = color },
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
    always_show_bufferline = false,
  },
}
