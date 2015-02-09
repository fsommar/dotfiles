#!/bin/bash

dir=~/dotfiles                    # dotfiles directory
themes="fsommar"

for theme in $themes; do
	echo "Creating symlink to $theme in oh-my-zsh directory."
	ln -s $dir/$theme.zsh-theme $dir/oh-my-zsh/themes/
done
