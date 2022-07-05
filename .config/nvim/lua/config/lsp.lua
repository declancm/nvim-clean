local keymap = vim.keymap.set

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- LSPCONFIG:

local lsp_status = pcall(require, 'lspconfig')
if not lsp_status then
  print("'lspconfig' executed with errors.")
  return
end

local navic_status, navic = pcall(require, 'nvim-navic')
if not navic_status then
  print("'navic' executed with errors.")
  return
end

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    -- Format on save.
    autocmd('BufWritePre', {
      callback = function()
        vim.lsp.buf.format()
        vim.cmd('retab')
      end,
      buffer = bufnr,
      group = augroup('lsp_format', { clear = false }),
    })
  end
  -- Add diagnostics to location list.
  autocmd({ 'BufEnter', 'InsertLeave' }, {
    callback = function()
      vim.diagnostic.setloclist { open = false }
    end,
    group = augroup('lsp_loclist', { clear = false }),
  })
  -- Navic setup.
  navic.attach(client, bufnr)
end

-- LSP dianostic keymaps:
keymap('n', '<Leader>e', vim.diagnostic.open_float)
keymap('n', '[d', vim.diagnostic.goto_prev)
keymap('n', ']d', vim.diagnostic.goto_next)
-- keymap('n', '<Leader>q', vim.diagnostic.setloclist)

-- LSP buffer keymaps:
keymap('n', 'gd', vim.lsp.buf.definition)
keymap('n', 'gD', vim.lsp.buf.declaration)
keymap('n', 'gt', vim.lsp.buf.type_definition)
keymap('n', 'gr', vim.lsp.buf.references)
keymap('n', 'gi', vim.lsp.buf.implementation)
keymap('n', 'H', vim.lsp.buf.hover)
keymap('n', '<C-h>', vim.lsp.buf.signature_help)
keymap('n', '<Leader>rn', vim.lsp.buf.rename)
keymap('n', '<Leader>ca', vim.lsp.buf.code_action)
-- keymap('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder)
-- keymap('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder)
-- keymap('n', '<Leader>wl', function()
--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end)
-- keymap('n', '<Leader>f', vim.lsp.buf.formatting)

-- Go to definition in split window:
keymap('n', '<Leader>gd', function()
  if vim.api.nvim_win_get_width(0) >= 170 then
    vim.cmd('vertical split')
  else
    vim.cmd('split')
  end
  vim.lsp.buf.definition()
end)

-- Format on command.
vim.cmd('command! Format lua vim.lsp.buf.formatting_sync()')

-- COMPLETION:

local completion = vim.g.__selected_completion or 'cmp'

if completion == 'cmp' then
  require('config.completion').CMP_setup(on_attach)
elseif completion == 'coq' then
  require('config.completion').COQ_setup(on_attach)
end

-- LSPCONFIG-UI:

-- Diagnostic symbols:
local signs = { Error = '▶ ', Warn = '▶ ', Hint = '▶ ', Info = '▶ ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Virtual text symbol:
vim.diagnostic.config { virtual_text = { prefix = '•' } }

-- Floating window border outlines:
local border = {
  { '╭', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╮', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '╯', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╰', 'FloatBorder' },
  { '│', 'FloatBorder' },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, options, ...)
  options = options or {}
  options.border = options.border or border
  return orig_util_open_floating_preview(contents, syntax, options, ...)
end

-- NULL-LS:

local null_status, null = pcall(require, 'null-ls')
if not null_status then
  print("'null-ls' executed with errors.")
  return
end

null.setup {
  debug = false,
  sources = {
    null.builtins.formatting.black,
    null.builtins.formatting.prettier,
    null.builtins.formatting.stylua,
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      -- Format on save.
      autocmd('BufWritePre', {
        callback = function()
          vim.lsp.buf.format()
          vim.cmd('retab')
        end,
        buffer = bufnr,
        group = augroup('lsp_format', { clear = false }),
      })
    end
  end,
}
