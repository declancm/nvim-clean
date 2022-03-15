local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
local bufmap = vim.api.nvim_buf_set_keymap

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

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

-- Telescope keymaps will close chadtree.
autocmd('FileType', {
  callback = function()
    bufmap(0, 'n', '<Leader>ff', "<Cmd>bd<CR><Cmd>lua require('telescope.builtin').find_files()<CR>", opts)
    bufmap(0, 'n', '<Leader>fg', "<Cmd>bd<CR><Cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
    bufmap(0, 'n', '<Leader>fb', "<Cmd>bd<CR><Cmd>lua require('telescope.builtin').buffers()<CR>", opts)
  end,
  pattern = 'CHADTree',
  group = augroup('chadtree_telescope', {}),
})

-- Disable indent guides for chadtree.
autocmd('FileType', {
  callback = function()
    vim.b.indent_blankline_enabled = false
  end,
  pattern = 'CHADTree',
  group = augroup('chadtree_indent', {}),
})

-- MARKDOWN-PREVIEW:

keymap('n', '<Leader>md', '<Cmd>MarkdownPreview<CR>', opts)
keymap('n', '<Leader>ms', '<Cmd>MarkdownPreviewStop<CR>', opts)
