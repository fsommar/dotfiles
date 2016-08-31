#!/bin/bash
# This script creates symlinks in the home directory

########## Variables

dir="$(cd "$(dirname "$0")" && pwd)"
olddir=$dir/old
# list of files/folders to symlink in homedir
files="bashrc bash_profile gitconfig vimrc ideavimrc zshrc dircolors oh-my-zsh tmux.conf"

function symlink() {
	echo "~/.$2 --> ~${1#$HOME}"
	mv ~/.$2 $olddir 2> /dev/null
	ln -s $1 ~/.$2
}

##########

cd $dir
mkdir -p $olddir

for file in $files; do
	symlink $dir/$file $file
done

# Share plugin directories for vim and neovim
mkdir -p ~/.config
symlink $dir/nvim vim
symlink $dir/nvim config/nvim 0

# Test to see if zshell is installed
if [ -f $(which zsh) ]; then
	# Clone my oh-my-zsh repository from GitHub only if it isn't already present
	if [[ ! -d $dir/oh-my-zsh/ ]]; then
		git clone https://github.com/robbyrussell/oh-my-zsh.git
	fi
	# Set the default shell to zsh if it isn't currently set to zsh
	if [[ ! $SHELL = $(which zsh) ]]; then
		echo "Setting default shell to zsh"
		chsh -s $(which zsh)
	fi
fi

if [[ ! -d $dir/dircolors/ ]]; then
	git clone https://github.com/seebi/dircolors-solarized.git
	mkdir dircolors
	mv dircolors-solarized $_/solarized
fi
