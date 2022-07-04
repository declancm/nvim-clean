vim.api.nvim_create_user_command('E', function()
  local saved_splitright = vim.opt.splitright:get()
  vim.opt.splitright = true
  vim.cmd('wincmd v')
  vim.cmd('Explore')
  -- vim.cmd('vertical resize 40')
  vim.opt.splitright = saved_splitright
end, {})
