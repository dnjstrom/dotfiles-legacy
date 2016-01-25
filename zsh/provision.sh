#!/bin/bash

# git submodule init ~/.dotfiles/zsh/.oh-my-zsh

rm -fr ~/.oh-my-zsh
ln -s ~/.dotfiles/zsh/oh-my-zsh ~/.oh-my-zsh

cat ~/.dotfiles/zsh/oh-my-zsh/templates/zshrc.zsh-template |\
	sed -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bureau"/' |\
	sed -e 's/plugins=(git)/plugins=(autojump docker docker-compose git history-substring-search npm nvm node themes)/' \
	> ~/.dotfiles/zsh/zshrc

rm ~/.zshrc
ln -s ~/.dotfiles/zsh/zshrc	~/.zshrc

# Zsh aliases
line="source ~/.dotfiles/zsh/aliases.sh"

if grep -q "$line" ~/.zshrc; then
	echo "zsh aliases already present in .zshrc."
else
	echo "Adding zsh aliases to .zshrc."
	echo "" >> ~/.zshrc
	echo "# Define some utility aliases for zsh" >> ~/.zshrc
	echo "$line" >> ~/.zshrc
fi
