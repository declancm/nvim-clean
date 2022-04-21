vim.api.nvim_add_user_command('E', function()
  local saved = {}
  saved.splitright = vim.opt.splitright:get()
  vim.opt.splitright = false
  vim.cmd('Vexplore')
  vim.cmd('vertical resize 40')
  vim.opt.splitright = saved.splitright
end, {})
