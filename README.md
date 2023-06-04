# 🧼 The CLEAN Neovim Config 🧼

This is my neovim nightly lua config which is full of some heat 🔥 custom
functions, keymaps, and plugins configurations.

Comes with three themes and two completion sources to choose between.

Some of the plugins with configs:
* chadtree
* ✨ coq_nvim ✨
* Comment.nvim
* gitsigns.nvim
* indent-blankline.nvim
* ✨ lspconfig ✨
* lualine
* LuaSnip
* null-ls
* ✨ nvim-cmp ✨
* ✨ nvim-dap ✨
* nvim-treesitter
* symbols-outline.nvim
* ✨ telescope ✨

## Installation

_Note: Please ensure you are using neovim nightly_ 🌘.

Stow is required to install the config.

For Ubuntu:
```bash
sudo apt install stow
```

```bash
cd ~
git clone https://github.com/declancm/nvim-clean.git
cd nvim-clean && stow .
```

📦 Information on packages required for plugins is at the bottom of init.lua.
