local theme, completion

-- THEME:
theme = 'gruvbox'
-- theme = 'onedark'
-- theme = 'tokyonight'

-- COMPLETION:
completion = 'cmp' -- Lots of good sources.
-- completion = 'coq' -- Faster completion. Requires 'python3-venv'.

vim.g.__selected_theme = theme
vim.g.__selected_completion = completion

-- Starting Python.
vim.g.python3_host_prog = '/bin/python3'
vim.g.python_host_prog = '/bin/python2'

-- PRE-CONFIG_OPTIONS:
vim.opt.syntax = 'on' -- Enable syntax highlighting.
vim.opt.termguicolors = true -- Enable 24-bit RGB.
vim.cmd 'let mapleader = "\\<BS>"' -- Set Leader for keymaps.

require 'setup.autocmds'

-- PLUGIN_CONFIGS:
require 'plugins'
require 'setup.lsp'
require 'setup.telescope'
require 'setup.treesitter'
require 'setup.debugging'
require 'setup.visuals'
require 'setup.comments'
require 'setup.movements'
require 'setup.misc'
require 'setup.declancm'

require 'setup.functions'
require 'setup.keymaps'
require 'setup.options'

--[[

These installation instructions are for Ubuntu.

-----------------
-- LSP SERVERS --
-----------------

You only need to install the language servers you want.

INSTALLATION:

bashls              npm i -g bash-language-server
clangd              sudo apt-get install clangd-12
cmake               pip3 install cmake-language-server
eslint              npm i -g vscode-langservers-extracted
powershell_es       https://github.com/PowerShell/PowerShellEditorServices/releases
                    Extract the zip file to '~/lsp/PowerShellEditorServices'.
                    (Set 'bundle_path' to PowerShellEditorServices root directory)
pyright             pip3 install pyright
sumneko_lua         https://github.com/sumneko/lua-language-server/wiki/Build-and-Run
                    Clone to '~/lsp/lua-language-server'.
                    (Make sure '/lua-language-server/bin' is added to path)
tsserver            npm install -g typescript typescript-language-server
vimls               npm install -g vim-language-server

NOTES:

clangd              To use clangd for a cpp project, add this to the CMakeLists.txt:
                    set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")

-------------
-- NULL-LS --
-------------

You only need to install the sources you want.

INSTALLATION:

black               pip3 install black
prettier            npm install --save-dev --save-exact prettier
stylua              cargo install stylua
                    (Make sure '~/.cargo/bin' is added to path)

---------------
-- TELESCOPE --
---------------

INSTALLATION:

fzf                 sudo apt-get install fzf
zoxide              sudo apt install zoxide

NOTES:

zoxide              Add to your .bashrc (or .zshrc etc.):
                    eval "$(zoxide init bash)"

----------------
-- TREESITTER --
----------------

INSTALLATION:

treesitter          npm install treesitter

]]
