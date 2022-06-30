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
