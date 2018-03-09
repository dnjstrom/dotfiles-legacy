#!/bin/bash

brew install fish reattach-to-user-namespace

echo "Setting up symbolic link to config"
rm -f ~/.tmux.conf
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

echo ""
echo "Remember to install plugins with '<prefix>-I'!"