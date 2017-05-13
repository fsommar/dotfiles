#!/bin/bash
dir="$DOTFILES/oh-my-zsh/"
if [[ ! -d $dir ]]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git $dir
fi

dir="$DOTFILES/oh-my-zsh/plugins/zsh-autosuggestions/"
if [[ ! -d $plugin ]]; then
  git clone git://github.com/zsh-users/zsh-autosuggestions $dir
fi

# Install custom themes in oh-my-zsh
for theme in "fsommar"; do
  echo "Creating symlink to $theme in oh-my-zsh directory."
  ln -s $DOTFILES/$theme.zsh-theme $DOTFILES/oh-my-zsh/themes/
done
