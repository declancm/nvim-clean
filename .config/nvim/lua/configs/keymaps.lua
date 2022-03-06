local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Source config file.
keymap('n', '<Leader>sc', '<Cmd>wa | source $MYVIMRC | PackerCompile<CR>', opts)

-- Improve the <Home> key.
keymap('', '<Home>', '^<Cmd>normal! zH<CR>', opts)
keymap('i', '<Home>', '<Esc>zHI', opts)

-- Creating windows.
keymap('n', '<Leader>v', '<C-w>v', opts)
keymap('n', '<Leader>nv', '<C-w>s', opts)

-- Window movement.
keymap('n', '<Leader>k', '<Cmd>wincmd k<CR>', opts)
keymap('n', '<Leader>j', '<Cmd>wincmd j<CR>', opts)
keymap('n', '<Leader>h', '<Cmd>wincmd h<CR>', opts)
keymap('n', '<Leader>l', '<Cmd>wincmd l<CR>', opts)
keymap('n', '<Leader><Up>', '<Cmd>wincmd k<CR>', opts)
keymap('n', '<Leader><Down>', '<Cmd>wincmd j<CR>', opts)
keymap('n', '<Leader><Left>', '<Cmd>wincmd h<CR>', opts)
keymap('n', '<Leader><Right>', '<Cmd>wincmd l<CR>', opts)

-- Resize windows.
keymap('n', '<S-Up>', '<Cmd>resize +5<CR>', opts)
keymap('n', '<S-Down>', '<Cmd>resize -5<CR>', opts)
keymap('n', '<S-Right>', '<Cmd>vertical resize +5<CR>', opts)
keymap('n', '<S-Left>', '<Cmd>vertical resize -5<CR>', opts)

-- Y works like D and C.
keymap('n', 'Y', '"*yg_', opts)

-- Stay centered during word search (replaced by vim-cinnamon).
-- keymap('n', 'n', 'nzzzv', opts)
-- keymap('n', 'N', 'Nzzzv', opts)

-- ZZ but for all windows.
keymap('n', '<Leader>ZZ', '<Cmd>wqall<CR>', opts)

-- Don't move during J.
keymap('n', 'J', 'mzJ`z:delmarks z<CR>', opts)

-- Adding more undo break points.
keymap('i', ',', ',<C-g>u', opts)
keymap('i', '.', '.<C-g>u', opts)
keymap('i', '!', '!<C-g>u', opts)
keymap('i', '?', '?<C-g>u', opts)

-- Moving text.
keymap('v', '<C-k>', ":m '<-2<CR>gv=gv", opts)
keymap('v', '<C-j>', ":m '>+1<CR>gv=gv", opts)
keymap('i', '<C-k>', '<Esc>:m .-2<CR>==a', opts)
keymap('i', '<C-j>', '<Esc>:m .+1<CR>==a', opts)
keymap('n', '<C-k>', ':m .-2<CR>==', opts)
keymap('n', '<C-j>', ':m .+1<CR>==', opts)

-- Moving text with arrows.
keymap('v', '<C-Up>', ":m '<-2<CR>gv=gv", opts)
keymap('v', '<C-Down>', ":m '>+1<CR>gv=gv", opts)
keymap('i', '<C-Up>', '<Esc>:m .-2<CR>==a', opts)
keymap('i', '<C-Down>', '<Esc>:m .+1<CR>==a', opts)
keymap('n', '<C-Up>', ':m .-2<CR>==', opts)
keymap('n', '<C-Down>', ':m .+1<CR>==', opts)

-- Replace a word then press '.' to change next occurence.
keymap('n', 'cn', '<Cmd>let @/=expand("<cword>")<CR>"_cgn', opts)
keymap('n', 'cN', '<Cmd>let @/=expand("<cword>")<CR>"_cgN', opts)

-- Yank to global clipboard.
keymap('n', 'y', '"*y', opts)
keymap('v', 'y', '"*y', opts)

-- Paste from global clipboard and highlight.
keymap('n', '<Leader>p', '"*p`[v`]', opts)
keymap('n', '<Leader>P', '"*P`[v`]', opts)

-- Highlight after indenting.
keymap('v', '>', '>gv', opts)
keymap('v', '<', '<gv', opts)

-- c, d and x are now delete without yanking.
keymap('n', 'x', '"_x', opts)
keymap('n', 'd', '"_d', opts)
keymap('n', 'D', '"_D', opts)
keymap('v', 'd', '"_d', opts)
keymap('n', 'c', '"_c', opts)
keymap('n', 'C', '"_C', opts)
keymap('v', 'c', '"_c', opts)

-- Cut is now Leader d.
keymap('n', '<Leader>d', '"*d', opts)
keymap('n', '<Leader>D', '"*d', opts)
keymap('v', '<Leader>d', '"*d', opts)

-- Delete start of word for command line with ctrl-backspace.
keymap('c', '<C-H>', '<C-w>', { noremap = true })
