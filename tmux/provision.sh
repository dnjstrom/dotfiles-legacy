#!/bin/bash

brew install reattach-to-user-namespace

rm -f ~/.tmux.conf
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
