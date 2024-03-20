#!/bin/bash

sudo apt-get update
sudo apt update && sudo apt upgrade -y
sudo apt install cargo python3-pip -y

# install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 21.7.1
npm install -g node-gyp

# clipboard
sudo apt install xsel -y

# lsp servers
sudo apt install clangd-12 -y
npm install bash-language-server
npm install vscode-langservers-extracted
npm install typescript typescript-language-server
npm install vim-language-server
pip3 install cmake-language-server
pip3 install pyright

# formatting
pip3 install black
npm install --save-dev --save-exact prettier
cargo install stylua

# telescope
sudo apt install ripgrep -y
sudo apt install fd-find -y
sudo apt install fzf -y
sudo apt install zoxide -y
cargo install zoxide --locked

# treesitter
npm install tree-sitter

# chadtree
apt install python3-venv -y
