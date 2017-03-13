#!/bin/bash

# This will overwrite any current vim-configurations present
rm -fr ~/.vim
ln -s ~/.dotfiles/vim ~/.vim 
ln -s ~/.dotfiles/vim ~/.config/nvim 
rm ~/.vimrc
ln -s ~/.dotfiles/vim/init.vim ~/.vimrc

brew install python3
brew linkapps python3
echo "Enter password to install ensure pip"
sudo python -m ensurepip
pip2 install --user neovim
pip3 install --user neovim
