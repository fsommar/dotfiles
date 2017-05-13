#!/bin/bash
# Creates symlinks in the home directory
mkdir $DOTFILES/old
function symlink() {
  mv ~/.$2 $DOTFILES/old 2> /dev/null
  ln -Ffhs $1 ~/.$2
}

files="bashrc bash_profile gitconfig vimrc ideavimrc zshrc dircolors oh-my-zsh tmux.conf gitignore_global iterm"
for file in $files; do symlink $DOTFILES/$file $file; done

# Share plugin directories for vim and neovim
mkdir -p ~/.config
symlink $DOTFILES/nvim vim
symlink $DOTFILES/nvim config/nvim 0
