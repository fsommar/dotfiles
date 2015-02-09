#!/bin/bash
##
## $Header: /afs/.nada.kth.se/common/usr/local/etc/nadaskel/en/RCS/.bashrc,v 1.8 2011/03/23 15:25:09 ragge Exp $
##
## bash individual per-interactive-shell startup file.
## Executed for new interactive shells and for remote command execution
## (as in: ssh host command)
## For more information, type "man bash".
##


## See if we run interactively. If not, we should not output
## anything, since it disturbs scp and other protocols.
case "$-" in
    *i*) INTERACTIVE=TRUE ;;
esac


## source global init file
global_bashrc=/usr/local/etc/shellinits/bashrc
if [ -r $global_bashrc ]; then
    source $global_bashrc
fi


## Environment setup - only do this if it has not already been done
if [[ ! $USER_ENV_INIT_DONE ]]; then
    ## Use nano as text mode editor and gedit as gui editor
    export EDITOR=nano
    export VISUAL=gedit
    #export EDITOR=emacs
    #export VISUAL=emacs

    ## Example: Use "less" instead of "more" as pager program, and set it up
    # export PAGER=less
    # export LESS=-Mn

    export USER_ENV_INIT_DONE=True
fi


## Initialisation for interactive mode
if [[ $INTERACTIVE ]]; then

    ## Nada legacy aliases
    alias lf='ls -F'
    alias ll='ls -laF'
    function lsd { cd $*; ls -aF; }
    alias h='history'
    alias logo='logout'
    # alias trm='rm *~;'

    ## OWN ALIASES
    alias oops='lprm -'

    ## Example: set erase char to ^?, as used on many other systems
    # alias se='stty erase ^?'

    ## Use ? for completion - Nada legacy functionality
    ## Standard in bash is tab for completion
    # bind '?:complete'

    ## Example: Set prompt to a one that you can include when you copy
    ## and paste command lines between terminals.
    ## (Works since the command ":" does nothing.)
    # PS1=': \h:\w ; '

    ## Example: Set prompt as above, but also make it stand out
    # prompt=': \h:\w ;'
    # smso=$(tput smso 2> /dev/null)
    # rmso=$(tput rmso 2> /dev/null)
    # PS1="\[$smso\]$prompt\[$rmso\] "

    ## Example: Let > overwrite existing files
    # set +C

    ## Example: Let first ctrl-D exit bash
    # unset IGNOREEOF
fi

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias gs='git st'
export VIMCAT='~/.scripts/vimcat'
alias dog=$VIMCAT
alias ccat=$VIMCAT

# export TERM=xterm-256color

# Colors for ls

alias ls='ls -GpFh'

# Colors for other commands
alias grep='grep --color'

# Change prompt with colors
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] '



if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad
else
    alias ls='ls -GpFh --color=auto'
    eval `dircolors ~/.config/dircolors-solarized/dircolors.ansi-dark`
fi
