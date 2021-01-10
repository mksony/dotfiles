# .dotfiles
This repository contains dotfiles that set up a development environment that
uses the following tools:

* zsh
* Visual Studio Code

# Installation

## Install Homebrew
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Clone the repository
```sh
git clone --bare git@github.com:Mksony/dotfiles.git $HOME/.cfg
```

## Setup the config files
```sh
bash .install.sh
```

# Recipes

## Adding local settings
If ~/.extra exists, it will be sourced along with the other files.
This comes in handy for things like git user settings, e.g.:

```sh
# Git credentials
GIT_AUTHOR_NAME="John Doe"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="john@doe.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

## Folder based git config

Create a `.gitextra` file and put e.g.

```
[include]
  path = .gitconfig-default
[includeIf "gitdir:~/repos/projects/"]
  path = .gitconfig-my-company
[includeIf "gitdir:~/repos/private/"]
  path = .gitconfig-private
[includeIf "gitdir:~/repos/hackspace/"]
  path = .gitconfig-private
```

Create the included files and add folder specific git config.