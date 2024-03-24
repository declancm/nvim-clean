local keymap = vim.keymap.set

vim.opt.background = 'dark'
-- vim.opt.colorcolumn = '80'

-- TOKYONIGHT:

vim.g.tokyonight_style = 'storm'
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_colors = { bg_float = 'NONE' }
vim.cmd([[colorscheme tokyonight]])
vim.cmd([[highlight ColorColumn ctermbg=0 guibg=#1f2335]])
vim.cmd([[highlight LineNr guifg=#3D59A1]])

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

require('lualine').setup {
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
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

require('gitsigns').setup {
  current_line_blame_opts = {
    delay = 0
  }
}

local gs = package.loaded.gitsigns
keymap({ 'n', 'x' }, '<Leader>tb', gs.toggle_current_line_blame)

-- INDENT_BLANKLINE:

require('ibl').setup {
  indent = {
    char = '▏', -- faint line
    -- char = '▎', -- thick line
    -- char = '╎', -- dotted line
  }
}

-- BUFFERLINE:

require('bufferline').setup {
  options = {
    mode = 'tabs',
    diagnostics = 'nvim_lsp',
    always_show_bufferline = false,
  },
}
