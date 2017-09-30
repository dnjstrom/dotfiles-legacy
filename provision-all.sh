#!/bin/bash

~/.dotfiles/zsh/provision.sh
~/.dotfiles/git/provision.sh
~/.dotfiles/vim/provision.sh
~/.dotfiles/tmux/provision.sh
~/.dotfiles/fish/provision.sh

ln -s ~/.dotfiles/phoenix.js ~/.phoenix.js


echo ""
echo "You probably want to reload your shell like so:"
echo "source ~/.zshrc"
