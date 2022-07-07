local keymap = vim.keymap.set

-- UNDOTREE:

keymap('n', '<Leader>u', '<Cmd>UndotreeToggle<CR><Cmd>wincmd p<CR>')
-- u is undo
-- <C-R> is redo

-- BULLETS:

vim.g.bullets_enabled_file_types = { 'markdown', 'text' }
vim.g.bullets_enable_in_empty_buffers = 0

-- MARKDOWN-PREVIEW:

keymap('n', '<Leader>md', '<Cmd>MarkdownPreview<CR>')
keymap('n', '<Leader>ms', '<Cmd>MarkdownPreviewStop<CR>')

-- BUFRESIZE:

local bufresize_status, bufresize = pcall(require, 'bufresize')
if not bufresize_status then
  print("'bufresize' executed with errors.")
  return
end

bufresize.setup()

-- CHADTREE:

vim.api.nvim_set_var('chadtree_settings', {
  ['options.close_on_open'] = true,
  ['theme.text_colour_set'] = 'solarized_light',
  ['options.session'] = false,
  -- ['view.open_direction'] = 'right',
})

keymap('n', '<Leader>ct', '<Cmd>CHADopen<CR>')
keymap('n', '<Leader>cl', '<Cmd>CHADopen --version-ctl<CR>')
keymap('n', '<Leader>cq', '<Cmd>call setqflist([])<CR>')
