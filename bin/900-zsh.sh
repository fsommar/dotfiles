#!/usr/bin/env bash
if [[ ! ${SHELL} = $(command -v zsh) ]]; then
  echo "Setting default shell to zsh"
  chsh -s "$(command -v zsh)"
fi
