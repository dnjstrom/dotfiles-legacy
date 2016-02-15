#!/bin/bash

# This will overwrite any current vim-configurations present
rm -fr ~/.vim
ln -s ~/.dotfiles/vim ~/.vim 
ln -s ~/.dotfiles/vim ~/.config/nvim 
rm ~/.vimrc
ln -s ~/.dotfiles/vim/init.vim ~/.vimrc
