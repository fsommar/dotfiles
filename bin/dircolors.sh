#!/bin/bash
# Enable nicer colors when listing directories
dir="$DOTFILES/dircolors/"
if [[ ! -d $dir ]]; then
  git clone https://github.com/seebi/dircolors-solarized.git
  mkdir $dir
  mv dircolors-solarized $_/solarized
fi
