#!/bin/bash

echo "Checking if brew is installed..."

# Check if brew is installed, if not install it
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "Homebrew is already installed"
fi

brew bundle

# to avoid problems setting zsh as default shell
sudo echo "$(which zsh)" >>/etc/shells
chsh -s $(which zsh)

bash ~/.macos
