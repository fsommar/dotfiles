set -x fish_greeting

set -q XDG_CONFIG_HOME
or set XDG_CONFIG_HOME ~/.config

if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x LD_LIBRARY_PATH /usr/local/bin $LD_LIBRARY_PATH
set -x EDITOR vim
set -x SHELL (type -P fish)
set -x GPG_TTY (tty)
set -x PROJECT_PATH $HOME/projects
set -x GO11MODULE on
set -qx PATH /usr/local/bin $HOME/scripts $HOME/.jenv/bin $HOME/.cargo/bin $HOME/go/bin $PATH

test -e ~/.secret_envs
and source ~/.secret_envs

abbr -a cdp "cd $PROJECT_PATH"
abbr -a gs 'git st'
abbr -a gd 'git df'
abbr -a gdc 'git df --cached'
abbr -a ll 'ls -l'
abbr -a ... '../..'
abbr -a .... '../../..'

if status is-interactive
    source $XDG_CONFIG_HOME/fish/events.fish

    if command -s jenv
        set PATH $HOME/.jenv/shims $PATH
        eval (command jenv init - --no-rehash)
        and fish -c 'command jenv rehash 2>/dev/null' &
    end

    type -q zoxide
    and zoxide init --hook pwd --z-cmd j fish | source

    type -q starship
    and starship init fish | source
end