#!/bin/bash

cd ~/

echo 'Installing dependencies...'
brew install stow git curl ripgrep fd fontconfig unzip fzf imagemagick ghostscript tectonic mermaid-cli utftex anomalyco/tap/opencode

echo 'Installing asdf'
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

echo 'Installing nerd-fonts...'
curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
getnf -i JetBrainsMono

echo 'Installing tmux...'
brew install tmux

echo 'Installing neovim...'
brew install neovim

echo 'Installing starship...'
brew install starship

echo 'Installing zap...'
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)

echo 'Installing tmux tpm...'
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo 'Cleaning files...'
rm -rf ~/.zshrc
rm -rf ~/.config/nvim
rm -rf ~/.tmux.conf

echo 'Linking dot files...'
cd ~/dotfiles
stow .

echo ''
read -p "Do you like to configure Github ssh? (y/n): " confirm && [[ $confirm == [yY] ]] || exit 1
sh configure_git.sh
