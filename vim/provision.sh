#!/bin/bash

# This will overwrite any current vim-configurations present
rm -fr ~/.vim
ln -s ~/.dotfiles/vim ~/.vim 
rm ~/.vimrc
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
