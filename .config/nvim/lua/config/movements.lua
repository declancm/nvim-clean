-- QUICKSCOPE:

vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
vim.g.qs_max_chars = 160

-- ISWAP:

local iswap_status, iswap = pcall(require, 'iswap')
if not iswap_status then
  print("'iswap' executed with errors.")
  return
end

iswap.setup {
  keys = '123456789abcdefghijklmnopqrstuvwxyz',
  hl_snipe = 'ErrorMsg',
  autoswap = true,
}

vim.keymap.set('n', '<Leader>is', function()
  require('iswap').iswap_with()
end)
