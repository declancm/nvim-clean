local dap = require 'dap'

vim.fn.sign_define('DapBreakpoint', { text = '⬤', texthl = 'DiagnosticError', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '⬤', texthl = 'DiagnosticWarn', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '⬤', texthl = 'DiagnosticHint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticHint', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '◯', texthl = 'DiagnosticError', linehl = '', numhl = '' })

-- Adapters:
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-12',
  name = 'lldb',
}

-- Configs:
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
    -- If 'runInTerminal' set to true, comment out the following line.
    postRunCommands = { 'process handle -p true -s false -n false SIGWINCH' },
  },
}

-- Use the cpp configuration for c and rust.
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- KEYMAPS:
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- keymap('n', '<Leader>dc', "<Cmd>lua require('dap').continue()<CR>", opts)
-- keymap('n', '<Leader>dq', "<Cmd>lua require('dap').terminate()<CR>", opts)

-- Breakpoints:
keymap('n', '<Leader>db', "<Cmd>lua require('dap').toggle_breakpoint()<CR>", opts)
keymap('n', '<Leader>dB', '', {
  callback = function()
    local condition = vim.fn.input 'Condition: '
    local hit = vim.fn.input 'Hit Condition: '
    local log = vim.fn.input 'Log Message: '
    require('dap').toggle_breakpoint(condition, hit, log)
  end,
  noremap = true,
  silent = true,
})
keymap('n', '<Leader>drb', "<Cmd>lua require('dap').clear_breakpoints()<CR>", opts)
keymap('n', '<Leader>dlb', "<Cmd>lua require('dap').list_breakpoints()<CR>", opts)
keymap('n', '<Leader>dtc', "<Cmd>lua require('dap').run_to_cursor()<CR>", opts)

-- Steps:
-- keymap('n', '<Leader>dsf', "<Cmd>lua require('dap').step_over()<CR>", opts)
-- keymap('n', '<Leader>dsb', "<Cmd>lua require('dap').step_back()<CR>", opts)
keymap('n', '<Leader>dj', "<Cmd>lua require('dap').step_over()<CR>", opts)
keymap('n', '<Leader>dk', "<Cmd>lua require('dap').step_back()<CR>", opts)
keymap('n', '<Leader>dsi', "<Cmd>lua require('dap').step_into()<CR>", opts)
keymap('n', '<Leader>dso', "<Cmd>lua require('dap').step_out()<CR>", opts)

-- Repl:
keymap('n', '<Leader>dd', "<Cmd>lua require('dap').repl.toggle({}, 'vertical split')<CR>", opts)
keymap('n', '<Leader>dc', '', {
  callback = function()
    require('dap').continue()
    require('dap').repl.open({}, 'vertical split')
  end,
  noremap = true,
  silent = true,
})
keymap('n', '<Leader>dq', '', {
  callback = function()
    require('dap').terminate()
    require('dap').repl.close()
  end,
  noremap = true,
  silent = true,
})

-- NVIM-DAP-VIRTUAL-TEXT:

require('nvim-dap-virtual-text').setup()

-- NVIM-DAP-UI:

require('dapui').setup()

keymap('n', '<Leader>du', "<Cmd>lua require('dapui').toggle()<CR>", opts)
-- keymap('n', '<Leader>dc', "<Cmd>lua require('dap').continue()<CR><Cmd>lua require('dapui').open()<CR>", opts)
-- keymap('n', '<Leader>dq', "<Cmd>lua require('dap').terminate()<CR><Cmd>lua require('dapui').close()<CR>", opts)
