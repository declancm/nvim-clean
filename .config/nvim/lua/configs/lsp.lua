-- NOTE: Information on how to install the servers is at the bottom of the file.

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- LSPCONFIG:

local lsp_status = pcall(require, 'lspconfig')
if not lsp_status then
  print "'lspconfig' executed with errors."
  return
end

local on_attach = function(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    -- Format on save.
    autocmd('BufWritePre', {
      callback = function()
        vim.lsp.buf.formatting_sync()
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
end

-- LSP dianostic keymaps:
keymap('n', '<Leader>e', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- keymap('n', '<Leader>q', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- LSP buffer keymaps:
keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
keymap('n', 'H', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<C-h>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- keymap('n', '<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
-- keymap('n', '<Leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- keymap('n', '<Leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- keymap('n', '<Leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- Go to definition in split window:
keymap('n', '<Leader>gd', '<Cmd>split<CR><Cmd>lua vim.lsp.buf.definition()<CR>', opts)

-- Format on command.
vim.cmd "command! Format lua vim.lsp.buf.formatting_sync(); vim.cmd 'retab'"

-- COMPLETION:

local completion = vim.g.__selected_completion or 'cmp'

if completion == 'cmp' then
  require('configs.completion').CMP_setup(on_attach)
elseif completion == 'coq' then
  require('configs.completion').COQ_setup(on_attach)
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
  print "'null-ls' executed with errors."
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
    if client.resolved_capabilities.document_formatting then
      -- Format on save.
      autocmd('BufWritePre', {
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
        buffer = bufnr,
        group = augroup('lsp_format', { clear = false }),
      })
    end
  end,
}

--[[

~ INSTALLATION ~

bashls:             npm i -g bash-language-server
black:              pip3 install black
clangd:             sudo apt-get install clangd-12
cmake:              pip3 install cmake-language-server
eslint:             npm i -g vscode-langservers-extracted
powershell_es:      https://github.com/PowerShell/PowerShellEditorServices/releases
                    Extract the zip file to '~/lsp/PowerShellEditorServices'.
                    (Set 'bundle_path' to PowerShellEditorServices root directory)
prettier:           npm install --save-dev --save-exact prettier
pyright:            pip3 install pyright
stylua:             cargo install stylua
                    (Make sure '~/.cargo/bin' is added to path)
sumneko_lua:        https://github.com/sumneko/lua-language-server/wiki/Build-and-Run
                    Clone to '~/lsp/lua-language-server'.
                    (Make sure '/lua-language-server/bin' is added to path)
tsserver:           npm install -g typescript typescript-language-server
vimls:              npm install -g vim-language-server

~ NOTES ~

clangd:             To use clangd for a cpp project, add this to the CMakeLists.txt:
                    set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")
coq:                Requires python3-venv:
                    sudo apt install -y python3-venv

]]
