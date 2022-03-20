local opts = { silent = true }
local keymap = vim.keymap.set

-- Source config file.
keymap('n', '<Leader>sc', '<Cmd>wa | so $MYVIMRC | PackerCompile<CR>', opts)

-- Toggle your notes file and keep it synced with the github remote.
keymap('n', '<Leader>nt', '<Cmd>lua ToggleNotes("~/notes/notes.txt")<CR>', opts)

-- MOVEMENT:

-- Replace a word then press '.' to change next occurence.
keymap('n', 'cn', '<Cmd>let @/=expand("<cword>")<CR>"_cgn', opts)
keymap('n', 'cN', '<Cmd>let @/=expand("<cword>")<CR>"_cgN', opts)

-- Jump to the next line with the same indent size.
-- Will only find a match after the indent has changed, stopping it from jumping
-- just one line at a time.
keymap('', '<Leader>iu', "<Cmd>lua FindSameIndent('Up')<CR>", opts)
keymap('', '<Leader>id', "<Cmd>lua FindSameIndent('Down')<CR>", opts)

-- Moving text.
keymap('x', '<C-k>', ":m '<-2<CR>gv=gv", opts)
keymap('x', '<C-j>', ":m '>+1<CR>gv=gv", opts)
keymap('i', '<C-k>', '<Esc>:m .-2<CR>==a', opts)
keymap('i', '<C-j>', '<Esc>:m .+1<CR>==a', opts)
keymap('n', '<C-k>', ':m .-2<CR>==', opts)
keymap('n', '<C-j>', ':m .+1<CR>==', opts)

-- Moving text with arrows.
keymap('x', '<C-Up>', ":m '<-2<CR>gv=gv", opts)
keymap('x', '<C-Down>', ":m '>+1<CR>gv=gv", opts)
keymap('i', '<C-Up>', '<Esc>:m .-2<CR>==a', opts)
keymap('i', '<C-Down>', '<Esc>:m .+1<CR>==a', opts)
keymap('n', '<C-Up>', ':m .-2<CR>==', opts)
keymap('n', '<C-Down>', ':m .+1<CR>==', opts)

-- Improve the <Home> key.
keymap('', '<Home>', '^<Cmd>normal! zH<CR>', opts)
keymap('i', '<Home>', '<Esc>zHI', opts)

-- Stay centered during word search (replaced by vim-cinnamon).
-- keymap('n', 'n', 'nzzzv', opts)
-- keymap('n', 'N', 'Nzzzv', opts)

-- Don't move during J.
keymap('n', 'J', 'mzJ`z:delmarks z<CR>', opts)

-- Adding more undo break points.
keymap('i', ',', ',<C-g>u', opts)
keymap('i', '.', '.<C-g>u', opts)
keymap('i', '!', '!<C-g>u', opts)
keymap('i', '?', '?<C-g>u', opts)

-- Highlight after indenting.
keymap('x', '>', '>gv', opts)
keymap('x', '<', '<gv', opts)

-- Delete the start of the word.
keymap('i', '<C-H>', '<Cmd>lua DeleteStartWord("w")<CR>', opts)
keymap('i', '<M-BS>', '<Cmd>lua DeleteStartWord("W")<CR>', opts)
keymap('c', '<C-H>', '<C-w>', {})

-- Delete the end of the word.
keymap('i', '<C-Del>', '<Cmd>lua DeleteEndWord("w")<CR>', opts)
keymap('i', '<M-Del>', '<Cmd>lua DeleteEndWord("W")<CR>', opts)

-- Enter pattern to get a count for total matches in file.
-- Prepend a ' (single quotation mark) to the pattern for an exact match.
-- Use 'n' to go to the next match or 'N' to go to the previous.
keymap('n', '<Leader>/', '<Cmd>call Search()<CR>', opts)

-- TERMINAL:

-- Toggle the native terminal.
keymap('t', '<C-n>', '<C-Bslash><C-N>', opts)
keymap({ 'n', 't' }, '<C-Bslash>', '<Cmd>lua TerminalToggle()<CR>', opts)

-- Open lazygit:
keymap('n', '<C-g>', "<Cmd>lua TerminalToggle('lazygit')<CR>", opts)

-- COPY_AND_PASTE:

-- Y works like D and C.
keymap('n', 'Y', '"*yg_', opts)

-- Yank to global clipboard.
keymap({ 'n', 'x' }, 'y', '"*y', opts)

-- Yank and append to the '*' register using the same type as the '*' register.
keymap('x', '<Leader>Y', "\"0yg_<Cmd>call setreg('*', getreg('*') . getreg('0'), getregtype('*'))<CR>", opts)
keymap('x', '<Leader>y', "\"0y<Cmd>call setreg('*', getreg('*') . getreg('0'), getregtype('*'))<CR>", opts)

-- Paste from global register '*' and highlight.
keymap('n', '<Leader>p', '"*p`[v`]', opts)
keymap('n', '<Leader>P', '"*P`[v`]', opts)

-- Paste from the global register '*' and if pasting a visual line selection of
-- text, perform automatic indentation.
keymap('n', 'p', '<Cmd>lua GlobalPaste("p")<CR>', opts)
keymap('n', 'P', '<Cmd>lua GlobalPaste("P")<CR>', opts)
keymap('n', 'gp', '<Cmd>lua GlobalPaste("gp")<CR>', opts)
keymap('n', 'gP', '<Cmd>lua GlobalPaste("gP")<CR>', opts)

-- Paste from the global register '*' and enter insert mode at the end.
keymap({ 'i', 'n' }, '<M-p>', '<Cmd>lua GlobalPaste("p")<CR>a', opts)
keymap({ 'i', 'n' }, '<M-P>', '<Cmd>lua GlobalPaste("P")<CR>a', opts)

-- c, d and x are now delete without yanking.
keymap('n', 'x', '"_x', opts)
keymap({ 'n', 'x' }, 'd', '"_d', opts)
keymap('n', 'D', '"_D', opts)
keymap({ 'n', 'x' }, 'c', '"_c', opts)
keymap('n', 'C', '"_C', opts)

-- Cut is now Leader d.
keymap({ 'n', 'x' }, '<M-d>', '"*d', opts)
keymap('n', '<M-D>', '"*d', opts)

-- LISTS:

-- NOTE: Use the quickfix list with ':vimgrep'.

-- Quickfix-list:
keymap('n', '<Leader>qt', '<Cmd>cwindow<CR>', opts)
keymap('n', '<Leader>qn', '<Cmd>cnext<CR>', opts)
keymap('n', '<Leader>qp', '<Cmd>cprevious<CR>', opts)
keymap('n', '<Leader>qa', '<Cmd>cafter<CR>', opts)
keymap('n', '<Leader>qb', '<Cmd>cbefore<CR>', opts)

-- Location-list:
keymap('n', '<Leader>lt', '<Cmd>lwindow<CR>', opts)
keymap('n', '<Leader>ln', '<Cmd>lnext<CR>', opts)
keymap('n', '<Leader>lp', '<Cmd>lprevious<CR>', opts)
keymap('n', '<Leader>la', '<Cmd>lafter<CR>', opts)
keymap('n', '<Leader>lb', '<Cmd>lbefore<CR>', opts)

-- WINDOWS:

-- Toggle maximizing the current window.
keymap({ 'n', 'x' }, '<Leader>z', '<Cmd>lua MaximizeWindow()<CR>', opts)

-- Switch to previous vim window.
-- If no previous vim window exists, switch to last tmux pane.
keymap('n', '<Leader>;', function()
  local win1 = vim.fn.winnr()
  vim.cmd 'wincmd p'
  local win2 = vim.fn.winnr()
  if win1 == win2 then
    os.execute 'tmux select-pane -l > /dev/null 2>&1'
  end
end, { silent = true })

-- Creating windows.
keymap('n', '<Leader>wv', '<C-w>v', opts)
keymap('n', '<Leader>ws', '<C-w>s', opts)

-- Switch windows.
keymap('n', '<Leader>wk', "<Cmd>lua SwitchWindow('k')<CR>", opts)
keymap('n', '<Leader>wj', "<Cmd>lua SwitchWindow('j')<CR>", opts)
keymap('n', '<Leader>wh', "<Cmd>lua SwitchWindow('h')<CR>", opts)
keymap('n', '<Leader>wl', "<Cmd>lua SwitchWindow('l')<CR>", opts)
keymap('n', '<Leader>w<Up>', "<Cmd>lua SwitchWindow('k')<CR>", opts)
keymap('n', '<Leader>w<Down>', "<Cmd>lua SwitchWindow('j')<CR>", opts)
keymap('n', '<Leader>w<Left>', "<Cmd>lua SwitchWindow('h')<CR>", opts)
keymap('n', '<Leader>w<Right>', "<Cmd>lua SwitchWindow('l')<CR>", opts)

-- Resize windows.
keymap('n', '<S-Up>', '<Cmd>resize +5<CR>', opts)
keymap('n', '<S-Down>', '<Cmd>resize -5<CR>', opts)
keymap('n', '<S-Right>', '<Cmd>vertical resize +5<CR>', opts)
keymap('n', '<S-Left>', '<Cmd>vertical resize -5<CR>', opts)

-- Save and close the window in the direction selected.
keymap('n', '<Leader>xl', "<Cmd>lua CloseOtherWindow('l')<CR>", opts)
keymap('n', '<Leader>xh', "<Cmd>lua CloseOtherWindow('h')<CR>", opts)
keymap('n', '<Leader>xk', "<Cmd>lua CloseOtherWindow('k')<CR>", opts)
keymap('n', '<Leader>xj', "<Cmd>lua CloseOtherWindow('j')<CR>", opts)
keymap('n', '<Leader>x<Right>', "<Cmd>lua CloseOtherWindow('l')<CR>", opts)
keymap('n', '<Leader>x<Left>', "<Cmd>lua CloseOtherWindow('h')<CR>", opts)
keymap('n', '<Leader>x<Up>', "<Cmd>lua CloseOtherWindow('k')<CR>", opts)
keymap('n', '<Leader>x<Down>', "<Cmd>lua CloseOtherWindow('j')<CR>", opts)

-- Save and quit all windows.
keymap('n', 'ZA', '<Cmd>xall<CR>', opts)

-- Close other windows.
keymap('n', 'ZO', '<Cmd>wa<CR><Cmd>only<CR>', opts)

-- BUFFERS:

-- Buffer movement.
keymap('n', '<Leader>bn', '<Cmd>bNext<CR>', opts)
keymap('n', '<Leader>bp', '<Cmd>bprevious<CR>', opts)

-- Show list of current buffers and select one.
keymap('n', '<Leader>bl', '<Cmd>ls | exec "buffer " . input("\\nEnter buffer: ")<CR>', opts)

-- TABS:

keymap('n', '<Leader>tn', '<Cmd>tabnew<CR>', opts)
keymap('n', '<Leader>ts', '<Cmd>tab split<CR>', opts)
keymap('n', '<Leader>tc', '<Cmd>tabclose<CR>', opts)
-- <C-PgUp> = prev. tab.
-- <C-PgDown> = next tab.
