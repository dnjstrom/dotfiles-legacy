#!/bin/bash

# Symlink global git config, overwriting existing configuration
rm -f ~/.gitconfig
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

line="source ~/.dotfiles/git/aliases.sh"

# Set global gitignore
git config --global core.excludesfile '~/.dotfiles/git/gitignore'

