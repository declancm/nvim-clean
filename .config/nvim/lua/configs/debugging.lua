local dap = require 'dap'

vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })

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

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Keymaps:
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', '<Leader>dc', "<Cmd>lua require('dapui').open()<CR><Cmd>lua require('dap').continue()<CR>", opts)
-- keymap('n', '<Leader>dc', "<Cmd>lua require('dap').continue()<CR>", opts)
keymap('n', '<Leader>db', "<Cmd>lua require('dap').toggle_breakpoint()<CR>", opts)
keymap('n', '<Leader>drb', "<Cmd>lua require('dap').clear_breakpoint()<CR>", opts)
keymap('n', '<Leader>dlb', "<Cmd>lua require('dap').list_breakpoint()<CR>", opts)
keymap('n', '<Leader>dtc', "<Cmd>lua require('dap').run_to_cursor()<CR>", opts)
keymap('n', '<Leader>dsf', "<Cmd>lua require('dap').step_over()<CR>", opts)
keymap('n', '<Leader>dsb', "<Cmd>lua require('dap').step_back()<CR>", opts)
keymap('n', '<Leader>dsi', "<Cmd>lua require('dap').step_into()<CR>", opts)
keymap('n', '<Leader>dso', "<Cmd>lua require('dap').step_out()<CR>", opts)
keymap('n', '<Leader>dq', "<Cmd>lua require('dap').terminate()<CR><Cmd>lua require('dapui').close()<CR>", opts)
-- keymap('n', '<Leader>dq', "<Cmd>lua require('dap').terminate()<CR>", opts)

-- NVIM-DAP-UI:

require('dapui').setup()

keymap('n', '<Leader>du', "<Cmd>lua require('dapui').toggle()<CR>", opts)
