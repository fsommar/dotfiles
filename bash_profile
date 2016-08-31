#!/bin/bash
## source global init file
 global_bash_profile=/usr/local/etc/shellinits/bash_profile
 if [ -r $global_bash_profile ]; then
     source $global_bash_profile
 fi
#
# ## source the individual per-interactive-shell startup file
#if [ -r ~/.bashrc ]; then
#    source ~/.bashrc
#fi

# If we-re in gnome terminal or terminator, set TERM for more vim colors.
if [[ $COLORTERM = gnome-terminal && ! $TERM = screen-256color ]]; then
	TERM=xterm-256color
fi
JAVA_8_HOME=$JAVA_HOME

if [ -x $(which zsh) ]; then
	exec $(which zsh);
elif [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi
