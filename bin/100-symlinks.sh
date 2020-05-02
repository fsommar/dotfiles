#!/usr/bin/env bash
: "${DOTFILES:?DOTFILES must be set}"

set -ueo pipefail

# Creates symlinks in the home directory
mkdir -p "${DOTFILES}/old"
function symlink() {
  FOLDER="$(dirname "${HOME}/.$2")"
  if [ -d "${FOLDER}" ]; then
    mv -f "${HOME}/.$2" "${DOTFILES}/old" || true
  else
    mkdir -p "${FOLDER}"
  fi
  ln -Ffs "$1" "${HOME}/.$2"
}
# symlink needs to be exported for xargs to access it.
# https://stackoverflow.com/a/11003457
export -f symlink

# shellcheck disable=SC2016
find "$(pwd)" -maxdepth 1 ! -type d ! -name '_*' ! -name '.*' ! -name Brewfile \
  -print0 \
  | xargs -0 -n1 bash -c 'symlink "$0" "$(basename "$0")"'

for f in "${DOTFILES}/config/"*
do
  symlink "${f}" "config/$(basename "${f}")"
done

for f in "${DOTFILES}/gitconfig.d/"*
do
  symlink "${f}" "gitconfig.d/$(basename "${f}")"
done

mkdir -p "${HOME}/.shell"
for f in "${DOTFILES}/shell/"*
do
  symlink "${f}" "shell/$(basename "${f}")"
done
