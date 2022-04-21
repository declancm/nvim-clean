local dap = require('dap')

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

-- Keymaps:
local opts = { silent = true }
local keymap = vim.keymap.set

keymap('n', '<Leader>dc', "<Cmd>lua require('dap').continue()<CR>", opts)
-- keymap('n', '<Leader>dq', "<Cmd>lua require('dap').terminate()<CR>", opts)
keymap('n', '<Leader>drl', "<Cmd>lua require('dap').run_last()<CR>", opts)

-- Breakpoints:
keymap('n', '<Leader>db', "<Cmd>lua require('dap').toggle_breakpoint()<CR>", opts)
keymap('n', '<Leader>dB', function()
  local condition = vim.fn.input('Condition: ')
  local hit = vim.fn.input('Hit Condition: ')
  local log = vim.fn.input('Log Message: ')
  require('dap').toggle_breakpoint(condition, hit, log)
end, opts)
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
keymap('n', '<Leader>dd', "<Cmd>lua require('config.debugging').open_repl('toggle')<CR>", opts)
-- keymap('n', '<Leader>dc', function()
--   require('dap').continue()
--   open_repl()
-- end, opts)
keymap('n', '<Leader>dq', function()
  require('dap').terminate()
  require('dap').repl.close()
end, opts)

require('dap').listeners.after.event_initialized['repl_open'] = function()
  require('config.debugging').open_repl()
end

-- NVIM-DAP-VIRTUAL-TEXT:

require('nvim-dap-virtual-text').setup()

-- NVIM-DAP-UI:

require('dapui').setup {
  floating = { borders = 'rounded' },
}

keymap('n', '<Leader>du', "<Cmd>lua require('dapui').toggle()<CR>", opts)
-- keymap('n', '<Leader>dc', "<Cmd>lua require('dap').continue()<CR><Cmd>lua require('dapui').open()<CR>", opts)
-- keymap('n', '<Leader>dq', "<Cmd>lua require('dap').terminate()<CR><Cmd>lua require('dapui').close()<CR>", opts)

-- require('dap').listeners.after.event_initialized['dapui_config'] = function()
--   require('dapui').open()
-- end
-- require('dap').listeners.before.event_terminated['dapui_config'] = function()
--   require('dapui').close()
-- end
-- require('dap').listeners.before.event_exited['dapui_config'] = function()
--   require('dapui').close()
-- end

local M = {}

M.open_repl = function(cmd)
  cmd = cmd or 'open'
  local win_width = vim.api.nvim_win_get_width(0)
  local win_height = vim.api.nvim_win_get_height(0)
  if win_width >= 170 then
    local width = math.floor(win_width / 2)
    if cmd == 'toggle' then
      require('dap').repl.toggle({ width = width }, 'belowright vertical split')
    else
      require('dap').repl.open({ width = width }, 'belowright vertical split')
    end
  else
    local height = math.floor(win_height / 3)
    if cmd == 'toggle' then
      require('dap').repl.toggle({ height = height }, 'belowright split')
    else
      require('dap').repl.open({ height = height }, 'belowright split')
    end
  end
end

return M
