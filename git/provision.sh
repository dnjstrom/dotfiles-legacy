#!/bin/bash

# Symlink global git config, overwriting existing configuration
ln -sfFvh ~/.dotfiles/git/gitconfig ~/.gitconfig


# Add some git aliases to user shells

line="source ~/.dotfiles/git/aliases.sh"

# Add the git aliases to .zshrc
if test -e ~/.zshrc; then
	if grep -q "$line" ~/.zshrc; then
		echo "Git aliases already present in .zshrc."
	else
		echo "Adding git aliases to .zshrc."
		echo "" >> ~/.zshrc
		echo "# Define some nice git aliases" >> ~/.zshrc
		echo "$line" >> ~/.zshrc
	fi
else
	echo "No .zshrc present"
fi


# Add the git aliases to .bashrc
if test -e ~/.bashrc; then
	if grep -q "$line" ~/.bashrc; then
		echo "Git aliases already present in .bashrc."
	else
		echo "Adding git aliases to .bashrc."
		echo "" >> ~/.bashrc
		echo "# Define some nice git aliases" >> ~/.bashrc
		echo "$line" >> ~/.bashrc
	fi
else
	echo "No .bashrc present"
fi
