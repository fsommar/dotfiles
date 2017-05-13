#!/bin/bash
#################################################################################
# Setups a clean mac installation, in an as-complete-as-possible state          #
#################################################################################

if ! which brew > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew bundle install

export DOTFILES="$(cd "$(dirname "$0")" && pwd)"

source bin/macOS.sh
source bin/symlinks.sh
source bin/oh-my-zsh.sh
source bin/dircolors.sh

# Set the default shell to zsh if it isn't currently set to zsh
if [[ ! $SHELL = $(which zsh) ]]; then
  echo "Setting default shell to zsh"
  chsh -s "$(which zsh)"
fi
