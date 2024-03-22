local keymap = vim.keymap.set

-- BUFRESIZE:

local bufresize_status, bufresize = pcall(require, 'bufresize')
if not bufresize_status then
  print("'bufresize' executed with errors.")
  return
end

bufresize.setup()
