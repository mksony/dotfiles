!#/bin/bash

echo "Checking if brew is installed..."
# Check if brew is installed, if not install it
if ! command -v brew &>/dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "Homebrew is already installed"
fi

brew bundle

chezmoi init git@github.com:mksony/dotfiles.git
