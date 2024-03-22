local M = {}

function M.config()
  vim.g.coq_settings = {
    auto_start = 'shut-up',
    keymap = { jump_to_mark = '<c-n>' },
    display = {
      ghost_text = { enabled = true },
      preview = { border = 'rounded' }
    }
  }
end

function M.setup(on_attach)
  local lsp = require('lspconfig')
  local coq = require('coq')

  local autocmd = vim.api.nvim_create_autocmd
  local augroup = vim.api.nvim_create_augroup

  -- Arrow keys close the completion popup window.
  vim.cmd([[
  inoremap <silent><expr> <Up>    pumvisible() ? "\<C-e>\<Up>"   : "\<Up>"
  inoremap <silent><expr> <Down>  pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
  ]])

  -- Automatically compile coq snippets when saving.
  autocmd('BufWritePost', {
    command = 'COQsnips compile',
    pattern = '*/coq-user-snippets/*.snip',
    group = augroup('coq_custom_snippets', {}),
  })

  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, 'lua/?.lua')
  table.insert(runtime_path, 'lua/?/init.lua')

  lsp.bashls.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.clangd.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.cmake.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.cssls.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.eslint.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.html.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.pyright.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.lua_ls.setup(coq.lsp_ensure_capabilities {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
          ignoreDir = { 'undodir' },
        },
        telemetry = { enable = false },
      },
    },
    on_attach = on_attach,
  })
  -- lsp.tsserver.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.vimls.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
end

return M
