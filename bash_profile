#!/usr/bin/env bash
 global_bash_profile=/usr/local/etc/shellinits/bash_profile
 if [[ -r ${global_bash_profile} ]]; then
     source "${global_bash_profile}"
 fi

# If we-re in gnome terminal or terminator, set TERM for more vim colors.
# shellcheck disable=SC2154
if [[ ${COLORTERM} = gnome-terminal && ! ${TERM} = screen-256color ]]; then
	TERM=xterm-256color
fi

if command -v zsh > /dev/null; then
	exec "$(command -v zsh)";
elif [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi
