local M = {}

function M.CMP_setup(on_attach)
  local lsp = require 'lspconfig'
  local cmp = require 'cmp'

  cmp.setup {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<Tab>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ['<S-Tab>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ['<Down>'] = cmp.config.disable,
      ['<Up>'] = cmp.config.disable,
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ['<CR>'] = cmp.mapping.confirm(),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    }),
  }

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })

  -- Setup lspconfig
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  lsp.bashls.setup { on_attach = on_attach, capabilities = capabilities }
  lsp.clangd.setup { on_attach = on_attach, capabilities = capabilities }
  lsp.cmake.setup { on_attach = on_attach, capabilities = capabilities }
  lsp.eslint.setup { on_attach = on_attach, capabilities = capabilities }
  lsp.powershell_es.setup {
    bundle_path = vim.fn.expand '$HOME/lsp/PowerShellEditorServices',
    on_attach = on_attach,
    capabilities = capabilities,
  }
  lsp.pyright.setup { on_attach = on_attach, capabilities = capabilities }
  lsp.sumneko_lua.setup {
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
    on_attach = on_attach,
    capabilities = capabilities,
  }
  -- lsp.tsserver.setup { on_attach = on_attach, capabilities = capabilities }
  lsp.vimls.setup { on_attach = on_attach, capabilities = capabilities }
end

function M.COQ_setup(on_attach)
  local lsp = require 'lspconfig'

  local autocmd = vim.api.nvim_create_autocmd
  local augroup = vim.api.nvim_create_augroup

  vim.g.coq_settings = {
    ['auto_start'] = 'shut-up',
    ['keymap.recommended'] = false,
    ['keymap.jump_to_mark'] = '<C-n>',
    ['display.ghost_text.enabled'] = false,
    ['display.preview.border'] = 'rounded',
  }

  vim.cmd [[
  inoremap <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
  inoremap <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
  inoremap <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
  inoremap <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"
  inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"

  " Arrow keys close the completion popup window.
  inoremap <silent><expr> <Up>    pumvisible() ? "\<C-e>\<Up>"   : "\<Up>"
  inoremap <silent><expr> <Down>  pumvisible() ? "\<C-e>\<Down>" : "\<Down>"
  ]]

  -- Automatically compile snippets when saving.
  autocmd('BufWritePost', {
    command = 'COQsnips compile',
    pattern = '*/coq-user-snippets/*.snip',
    group = augroup('coq_custom_snippets', {}),
  })

  local coq_status, coq = pcall(require, 'coq')
  if not coq_status then
    print "'coq' executed with errors."
    -- Setup diagnostics in init.lua if coq wasn't executed successfully.
    lsp.sumneko_lua.setup {
      settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
      on_attach = on_attach,
    }
    return
  end

  lsp.bashls.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.clangd.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.cmake.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.eslint.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.powershell_es.setup(coq.lsp_ensure_capabilities {
    bundle_path = vim.fn.expand '$HOME/lsp/PowerShellEditorServices',
    on_attach = on_attach,
  })
  lsp.pyright.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities {
    settings = { Lua = { diagnostics = { globals = { 'vim' } } } },
    on_attach = on_attach,
  })
  -- lsp.tsserver.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
  lsp.vimls.setup(coq.lsp_ensure_capabilities { on_attach = on_attach })
end

return M
