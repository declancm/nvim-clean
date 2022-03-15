local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

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
keymap('v', '>', '>gv', opts)
keymap('v', '<', '<gv', opts)

-- Delete the start of the word.
keymap('i', '<C-H>', '<Cmd>lua DeleteStartWord("w")<CR>', opts)
keymap('i', '<M-BS>', '<Cmd>lua DeleteStartWord("W")<CR>', opts)
keymap('c', '<C-H>', '<C-w>', { noremap = true })

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
keymap('n', '<C-Bslash>', '<Cmd>lua TerminalToggle()<CR>', opts)
keymap('t', '<C-Bslash>', '<Cmd>lua TerminalToggle()<CR>', opts)

-- Open lazygit:
keymap('n', '<C-g>', "<Cmd>lua TerminalToggle('lazygit')<CR>", opts)

-- COPY_AND_PASTE:

-- Y works like D and C.
keymap('n', 'Y', '"*yg_', opts)

-- Yank to global clipboard.
keymap('n', 'y', '"*y', opts)
keymap('v', 'y', '"*y', opts)

-- Yank to the default register.
-- Append to the '*' register using the same type as the '*' register.
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
keymap('n', '<M-p>', '<Cmd>lua GlobalPaste("p")<CR>a', opts)
keymap('n', '<M-P>', '<Cmd>lua GlobalPaste("P")<CR>a', opts)
keymap('i', '<M-p>', '<Esc><Cmd>lua GlobalPaste("p")<CR>a', opts)
keymap('i', '<M-P>', '<Esc><Cmd>lua GlobalPaste("P")<CR>a', opts)

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

-- WINDOWS:

-- Toggle maximizing the current window.
keymap('n', '<Leader>z', '<Cmd>lua MaximizeWindow()<CR>', opts)
keymap('x', '<Leader>z', '<Cmd>lua MaximizeWindow()<CR>', opts)

-- Switch to previous vim window.
-- If no previous vim window exists, switch to last tmux pane.
keymap('n', '<Leader>;', '<Cmd>lua PreviousWindow()<CR>', opts)

-- Creating windows.
keymap('n', '<Leader>v', '<C-w>v', opts)
keymap('n', '<Leader>nv', '<C-w>s', opts)

-- Switch windows.
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

-- Save and close the window in the direction selected.
keymap('n', 'ql', "<Cmd>lua CloseOtherWindow('l')<CR>", opts)
keymap('n', 'qh', "<Cmd>lua CloseOtherWindow('h')<CR>", opts)
keymap('n', 'qk', "<Cmd>lua CloseOtherWindow('k')<CR>", opts)
keymap('n', 'qj', "<Cmd>lua CloseOtherWindow('j')<CR>", opts)
keymap('n', 'q<Right>', "<Cmd>lua CloseOtherWindow('l')<CR>", opts)
keymap('n', 'q<Left>', "<Cmd>lua CloseOtherWindow('h')<CR>", opts)
keymap('n', 'q<Up>', "<Cmd>lua CloseOtherWindow('k')<CR>", opts)
keymap('n', 'q<Down>', "<Cmd>lua CloseOtherWindow('j')<CR>", opts)

-- Save and quit all windows.
keymap('n', 'ZA', '<Cmd>wqall<CR>', opts)

-- BUFFERS:

-- Buffer movement.
keymap('n', '<Leader>bn', '<Cmd>bNext<CR>', opts)
keymap('n', '<Leader>bp', '<Cmd>bprevious<CR>', opts)

-- Show list of current buffers and select one.
-- keymap('n', '<Leader>bl', '<Cmd>ls | exec "buffer " . input("\\nEnter buffer: ")<CR>', opts)

-- Close all buffers but the current one.
keymap('n', '<Leader>bd', '<Cmd>call ClearBuffers()<CR>', opts)

-- TABS:

keymap('n', '<Leader>tn', '<Cmd>tabnew<CR>', opts)
keymap('n', '<Leader>ts', '<Cmd>tab split<CR>', opts)
keymap('n', '<Leader>tc', '<Cmd>tabclose<CR>', opts)
-- <C-PgUp> = prev. tab.
-- <C-PgDown> = next tab.
