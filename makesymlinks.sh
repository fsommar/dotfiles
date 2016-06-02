#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/old_dotfiles             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bashrc bash_profile gitconfig vimrc ideavimrc zshrc dircolors oh-my-zsh"

##########

echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
	mv ~/.$file $olddir 2> /dev/null
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done

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
