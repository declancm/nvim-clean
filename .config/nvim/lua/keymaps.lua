local keymap = vim.keymap.set

-- Undo:
keymap({ 'n', 'v' }, '<C-z>', 'u')

-- Source config file.
keymap('n', '<Leader>sc', '<Cmd>wa | so $MYVIMRC | PackerCompile<CR>')

-- Toggle your notes file and keep it synced with the github remote.
keymap('n', '<Leader>nt', function()
  require('functions').toggle_notes('~/notes/notes.txt')
end)

-- MOVEMENT:

-- Replace a word then press '.' to change next occurence.
keymap('n', 'cn', '<Cmd>call setreg("/", "\\\\<" . expand("<cword>") . "\\\\>", "v")<CR>"_cgn')
keymap('n', 'cN', '<Cmd>call setreg("/", "\\\\<" . expand("<cword>") . "\\\\>", "v")<CR>"_cgN')

-- Jump to the next line with the same indent size.
keymap('', '<Leader>iu', function()
  require('functions').same_indent('Up')
end)
keymap('', '<Leader>id', function()
  require('functions').same_indent('Down')
end)

-- Moving text.
keymap('x', '<C-k>', ":m '<-2<CR>gv=gv")
keymap('x', '<C-j>', ":m '>+1<CR>gv=gv")
keymap('i', '<C-k>', '<Esc>:m .-2<CR>==a')
keymap('i', '<C-j>', '<Esc>:m .+1<CR>==a')
keymap('n', '<C-k>', ':m .-2<CR>==')
keymap('n', '<C-j>', ':m .+1<CR>==')

-- Moving text with arrows.
keymap('x', '<C-Up>', ":m '<-2<CR>gv=gv")
keymap('x', '<C-Down>', ":m '>+1<CR>gv=gv")
keymap('i', '<C-Up>', '<Esc>:m .-2<CR>==a')
keymap('i', '<C-Down>', '<Esc>:m .+1<CR>==a')
keymap('n', '<C-Up>', ':m .-2<CR>==')
keymap('n', '<C-Down>', ':m .+1<CR>==')

-- Improve the <Home> key.
keymap({ '', 'i' }, '<Home>', '<Cmd>norm! ^ze<CR>')

-- Stay centered during word search (replaced by vim-cinnamon).
-- keymap('n', 'n', 'nzzzv')
-- keymap('n', 'N', 'Nzzzv')

-- Don't move during J.
keymap('n', 'J', 'm`J``')

-- Adding more undo break points.
keymap('i', ',', ',<C-g>u')
keymap('i', '.', '.<C-g>u')
keymap('i', '!', '!<C-g>u')
keymap('i', '?', '?<C-g>u')
keymap('i', '<CR>', '<CR><C-g>u')

-- Highlight after indenting.
keymap('x', '>', '>gv')
keymap('x', '<', '<gv')

-- Delete the start of the word.
keymap('i', '<C-H>', function()
  require('functions').delete_start_word('w')
end)
keymap('i', '<M-BS>', function()
  require('functions').delete_start_word('W')
end)
keymap('c', '<C-H>', '<C-w>', {})

-- Delete the end of the word.
keymap('i', '<C-Del>', function()
  require('functions').delete_end_word('w')
end)
keymap('i', '<M-Del>', function()
  require('functions').delete_end_word('W')
end)

-- Search/Grep
-- keymap('n', '<Leader>/', '<Cmd>call Search()<CR>')
keymap('n', '<Leader>/', '<Cmd>call VimGrep()<CR>')

-- COPY_AND_PASTE:

-- Y works like D and C.
keymap('n', 'Y', '"*yg_')

-- Yank to global clipboard.
keymap({ 'n', 'x' }, 'y', '"*y')

-- Yank and append to the '*' register using the same type as the '*' register.
keymap('x', '<Leader>Y', "\"0yg_<Cmd>call setreg('*', getreg('*') . getreg('0'), getregtype('*'))<CR>")
keymap('x', '<Leader>y', "\"0y<Cmd>call setreg('*', getreg('*') . getreg('0'), getregtype('*'))<CR>")

-- Paste from global register '*' and highlight.
keymap('n', '<Leader>p', '"*p`[v`]')
keymap('n', '<Leader>P', '"*P`[v`]')

-- Paste from the global register '*' and if pasting a visual line selection of
-- text, perform automatic indentation.
keymap('n', 'p', function()
  require('functions').paste('p')
end)
keymap('n', 'P', function()
  require('functions').paste('P')
end)
keymap('n', 'gp', function()
  require('functions').paste('gp')
end)
keymap('n', 'gP', function()
  require('functions').paste('gP')
end)

-- Paste from the global register '*' and enter insert mode at the end.
keymap({ 'i', 'n' }, '<M-p>', function()
  require('functions').paste('p')
end)
keymap({ 'i', 'n' }, '<M-P>', function()
  require('functions').paste('P')
end)

-- c, d and x are now delete without yanking.
keymap('n', 'x', '"_x')
keymap({ 'n', 'x' }, 'd', '"_d')
keymap('n', 'D', '"_D')
keymap({ 'n', 'x' }, 'c', '"_c')
keymap('n', 'C', '"_C')

-- Cut is now Leader d.
keymap({ 'n', 'x' }, '<M-d>', '"*d')
keymap('n', '<M-D>', '"*d')

-- LISTS:

-- Quickfix-list:
-- keymap('n', '<Leader>qt', '<Cmd>cwindow<CR>')
-- keymap('n', '<Leader>qn', '<Cmd>cnext<CR>')
-- keymap('n', '<Leader>qp', '<Cmd>cprevious<CR>')
-- keymap('n', '<Leader>qa', '<Cmd>cafter<CR>')
-- keymap('n', '<Leader>qb', '<Cmd>cbefore<CR>')

-- Location-list:
-- keymap('n', '<Leader>lt', '<Cmd>lwindow<CR>')
-- keymap('n', '<Leader>ln', '<Cmd>lnext<CR>')
-- keymap('n', '<Leader>lp', '<Cmd>lprevious<CR>')
-- keymap('n', '<Leader>la', '<Cmd>lafter<CR>')
-- keymap('n', '<Leader>lb', '<Cmd>lbefore<CR>')

-- WINDOWS:

-- Creating windows.
-- keymap('n', '<Leader>v', '<C-w>v')
-- keymap('n', '<Leader>s', '<C-w>s')

-- Resize windows.
keymap('n', '<S-Up>', '<Cmd>resize +5<CR>')
keymap('n', '<S-Down>', '<Cmd>resize -5<CR>')
keymap('n', '<S-Right>', '<Cmd>vertical resize +5<CR>')
keymap('n', '<S-Left>', '<Cmd>vertical resize -5<CR>')

-- Save and quit all windows.
keymap('n', 'ZA', '<Cmd>xall<CR>')

-- Close other windows.
keymap('n', 'ZO', '<Cmd>wa<CR><Cmd>only<CR>')

-- BUFFERS:

-- Buffer movement.
keymap('n', '<Leader>bn', '<Cmd>bNext<CR>')
keymap('n', '<Leader>bp', '<Cmd>bprevious<CR>')

-- Show list of current buffers and select one.
keymap('n', '<Leader>bl', '<Cmd>ls | exec "buffer " . input("\\nEnter buffer: ")<CR>')

-- TABS:

keymap('n', '<Leader>tn', '<Cmd>tab split<CR>')
keymap('n', '<Leader>tc', '<Cmd>tabclose<CR>')
keymap('n', '<Leader>tl', '<Cmd>tabnext<CR>')
keymap('n', '<Leader>th', '<Cmd>tabprevious<CR>')
-- <C-PgUp> = previous tab.
-- <C-PgDown> = next tab.
