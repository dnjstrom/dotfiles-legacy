#!/bin/bash

# Install dependencies
~/.dotfiles/install.sh

# Phoenix
ln -s ~/.dotfiles/phoenix.js ~/.phoenix.js

# Git
ln -s ~/.dotfiles/git/gitignore ~/.gitignore

# Hyper
ln -s ~/.dotfiles/hyper.js ~/.hyper.js

# Vim
# rm -fr ~/.vim
ln -s ~/.dotfiles/vim ~/.vim 
ln -s ~/.dotfiles/vim ~/.config/nvim 
# rm ~/.vimrc
ln -s ~/.dotfiles/vim/init.vim ~/.vimrc

# tmux
# rm -f ~/.tmux.conf
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
echo ""
echo "Remember to install plugins with '<prefix>-I'!"

# Fish
ln -Fs ~/.dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -Fs ~/.dotfiles/fish/fishfile ~/.config/fish/fishfile
touch ~/.dotfiles/fish/config.secret.fish


# zsh
# ~/.dotfiles/zsh/provision.sh

echo ""
echo "You probably want to reload your shell now"
