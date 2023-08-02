!#/bin/bash

brew bundle

curl -o- -L https://yarnpkg.com/install.sh | bash

# to avoid problems setting zsh as default shell
sudo echo "$(which zsh)" >>/etc/shells
chsh -s $(which zsh)

bash ~/.macos
