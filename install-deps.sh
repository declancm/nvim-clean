#!/bin/bash

sudo apt-get update
sudo apt update && sudo apt upgrade -y

# install dependencies
sudo apt install build-essential cmake cargo python3-pip -y

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
npm install -g bash-language-server
npm install -g vscode-langservers-extracted
npm install -g typescript-language-server
npm install -g vim-language-server
pip3 install cmake-language-server
pip3 install pyright
git clone https://github.com/LuaLS/lua-language-server ~/lua-language-server && cd ~/lua-language-server && ./make.sh; cd $OLDPWD

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

# git
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo ~/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && tar xf lazygit.tar.gz -C ~/ && sudo install ~/lazygit /usr/local/bin
