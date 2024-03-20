sudo apt-get update
sudo apt update && sudo apt upgrade -y
sudo apt install cargo python3-pip

# install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 21.7.1
npm install -g node-gyp

# clipboard
sudo apt install xsel

# lsp servers
sudo apt install clangd-12
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
sudo apt install ripgrep
sudo apt install fd-find
sudo apt install fzf
sudo apt install zoxide
cargo install zoxide --locked

# treesitter
npm install tree-sitter
