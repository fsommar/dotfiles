#!/bin/bash
##
## $Header: /afs/.nada.kth.se/common/usr/local/etc/nadaskel/en/RCS/.bash_profile,v 1.1 2008/09/25 14:16:02 ragge Exp $
##
## bash initialization file, executed for login shells.
## For more information, type "man bash".
##

## source global init file
# global_bash_profile=/usr/local/etc/shellinits/bash_profile
# if [ -r $global_bash_profile ]; then
#     source $global_bash_profile
# fi
#
# ## source the individual per-interactive-shell startup file
# if [ -r ~/.bashrc ]; then
#     source ~/.bashrc
# fi

if [ -x $(which zsh) ]; then exec $(which zsh) -l; fi
