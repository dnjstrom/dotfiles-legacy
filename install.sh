# Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install ctop nvm tmux reattach-to-user-namespace fish neovim ctags starship

# Fira Code
brew tap homebrew/cask-fonts
brew cask install font-fira-code

# Fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
