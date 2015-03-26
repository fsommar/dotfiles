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

if [ -x $(which zsh) ]; then
	exec $(which zsh);
elif [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi
