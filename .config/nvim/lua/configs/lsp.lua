local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- COQ:

vim.g.coq_settings = {
  ['auto_start'] = 'shut-up',
  ['keymap.recommended'] = false,
  ['keymap.jump_to_mark'] = '<C-n>',
  ['display.ghost_text.enabled'] = false,
  ['display.preview.border'] = 'solid',
}

vim.cmd [[
inoremap <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
inoremap <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
inoremap <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
inoremap <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"

" Arrow keys ignore popup window.
inoremap <silent><expr> <Up>    pumvisible() ? "\<C-e>\<Up>" : "\<Up>"
inoremap <silent><expr> <Down>  pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
]]

-- Automatically compile snippets when saving.
autocmd('BufWritePost', {
  command = 'COQsnips compile',
  pattern = '*/coq-user-snippets/*.snip',
  group = augroup('coq_custom_snippets', {}),
})

-- LSPCONFIG:

local lsp_status, lsp = pcall(require, 'lspconfig')
if not lsp_status then
  print "'lsp' executed with errors."
  return
end

local coq_status, coq = pcall(require, 'coq')
if not coq_status then
  print "'coq' executed with errors."
  return
end

local on_attach = function(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    -- Format on save.
    autocmd('BufWritePre', {
      callback = function()
        vim.lsp.buf.formatting_sync()
        vim.cmd 'retab'
      end,
      buffer = bufnr,
      group = augroup('lsp_format', {}),
    })
    -- Format on command.
    vim.cmd "command! Format lua vim.lsp.buf.formatting_sync(); vim.cmd 'retab'"
  end
end

--[[

~ INSTALLATION ~

bashls:             npm i -g bash-language-server
clangd:             sudo apt-get install clangd-12
cmake:              pip3 install cmake-language-server
eslint:             npm i -g vscode-langservers-extracted
powershell_es:      https://github.com/PowerShell/PowerShellEditorServices/releases
                    Extract the zip file to '~/lsp/PowerShellEditorServices'.
                    (Set 'bundle_path' to PowerShellEditorServices root directory)
pyright:            pip3 install pyright
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

vim.cmd 'let g:powershell_es_path = expand("$HOME/lsp/PowerShellEditorServices")'

lsp.bashls.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
lsp.clangd.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
lsp.cmake.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
lsp.eslint.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
lsp.powershell_es.setup(coq.lsp_ensure_capabilities {
  bundle_path = vim.g.powershell_es_path,
  on_attach = on_attach,
})
lsp.pyright.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities {
  settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
  on_attach = on_attach,
})
-- lsp.tsserver.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
lsp.vimls.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })

-- LSP dianostic keymaps:
keymap('n', '<Leader>e', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '<Leader>q', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- LSP buffer keymaps:
keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
keymap('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
keymap('n', 'H', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<C-h>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keymap('n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<Leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', '<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
keymap('n', '<Leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
keymap('n', '<Leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
-- keymap('n', '<Leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)

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

-- Open definition in a new window.
local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local log = require 'vim.lsp.log'
  local api = vim.api
  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, 'No location found')
      return nil
    end
    if split_cmd then
      vim.cmd(split_cmd)
    end
    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])
      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command 'copen'
        api.nvim_command 'wincmd p'
      end
    else
      util.jump_to_location(result)
    end
  end
  return handler
end
vim.lsp.handlers['textDocument/definition'] = goto_definition 'vertical split'

-- NULL-LS:

local null_status, null = pcall(require, 'null-ls')
if not null_status then
  print "'null-ls' executed with errors."
  return
end

--[[

~ INSTALLATION ~

black:              pip3 install black
prettier:           npm install --save-dev --save-exact prettier
stylua:             cargo install stylua
                    (Make sure '~/.cargo/bin' is added to path)

]]

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
          vim.cmd 'retab'
        end,
        -- pattern = '<buffer>',
        buffer = bufnr,
        group = augroup('null_format', {}),
      })
      -- Format on command.
      vim.cmd "command! Format lua vim.lsp.buf.formatting_sync(); vim.cmd 'retab'"
    end
  end,
}
