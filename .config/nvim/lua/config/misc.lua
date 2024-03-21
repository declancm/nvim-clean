local keymap = vim.keymap.set

-- UNDOTREE:

keymap('n', '<Leader>u', '<Cmd>UndotreeToggle<CR><Cmd>wincmd p<CR>')
-- u is undo
-- <C-R> is redo

-- BUFRESIZE:

local bufresize_status, bufresize = pcall(require, 'bufresize')
if not bufresize_status then
  print("'bufresize' executed with errors.")
  return
end

bufresize.setup()
