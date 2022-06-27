-- OPTIONS:

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.opt.undofile = true
vim.opt.relativenumber = true
vim.opt.number = true -- Line number at cursor.
vim.opt.showmode = true
vim.opt.cmdheight = 2
vim.opt.incsearch = true -- Incremental search.
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false -- Disable line wrap.
vim.opt.expandtab = true -- Convert tabs into spaces.
vim.opt.autoindent = true -- Copy indent of current line for new line.
vim.opt.cindent = true -- C style indenting.
vim.opt.scrolloff = 8 -- Minimum number of screen lines above/below the cursor.
vim.opt.iskeyword:remove('_') -- '_' separates words, same as '-'.
vim.opt.backspace = { 'indent', 'eol', 'start', 'nostop' } -- Better backspace.
vim.opt.updatetime = 100 -- Delay before CursorHold event is activated.
vim.opt.shortmess:append('ac')
vim.opt.splitbelow = true -- Create new windows below.
vim.opt.splitright = true -- Create new windows to the right.
vim.opt.timeoutlen = 500 -- Maximum time between key presses for a keymap.
vim.opt.mouse = 'a' -- Enable mouse.
vim.opt.path:append('**')
-- vim.opt.textwidth = 80
vim.opt.pastetoggle = '<F9>'
vim.opt.laststatus = 3 -- Use one status line for all windows.
vim.opt.inccommand = 'split'
vim.opt.shortmess:remove('S') -- Show count for search results.
-- vim.opt.lazyredraw = true
vim.opt.autowrite = true
-- vim.opt.autowriteall = true
