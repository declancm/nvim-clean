local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- UNDOTREE:

keymap('n', '<Leader>u', '<Cmd>UndotreeToggle<CR><Cmd>wincmd p<CR>', opts)

-- CHADTREE:

local chadtree_settings = {
  ['options.close_on_open'] = true,
  ['theme.text_colour_set'] = 'solarized_light',
  -- ['options.session'] = false,
}
vim.api.nvim_set_var('chadtree_settings', chadtree_settings)

keymap('n', '<Leader>ct', '<Cmd>CHADopen<CR>', opts)
keymap('n', '<Leader>cl', '<Cmd>CHADopen --version-ctl<CR>', opts)
keymap('n', '<Leader>cq', '<Cmd>call setqflist([])<CR>', opts)

-- MARKDOWN-PREVIEW:

keymap('n', '<Leader>md', '<Cmd>MarkdownPreview<CR>', opts)
keymap('n', '<Leader>ms', '<Cmd>MarkdownPreviewStop<CR>', opts)
