#!/bin/bash

brew bundle

# to avoid problems setting zsh as default shell
sudo echo "$(which zsh)" >>/etc/shells
chsh -s $(which zsh)

bash ~/.macos
