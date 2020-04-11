#!/usr/bin/env bash
set -ueo pipefail

# shellcheck disable=SC2155
export DOTFILES="$(cd "$(dirname "$0")" && pwd)"

for script in bin/*
do
  source "${script}"
done
