# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="fsommar"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Change the command execution time stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git common-aliases dircycle last-working-dir scala)

# User configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/bin:$LD_LIBRARY_PATH

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export EDITOR=vim
export RUST_SRC_PATH=/usr/local/src/rust/src

cd() { builtin cd "$@" && ls; }
alias cdp='cd ~/projects'
alias cdd='cd ~/Downloads'
alias ls='ls -GpFh'
alias gs='git st'
alias gdc='gd --cached'

# Colors for other commands
alias grep='grep --color'

if [ "$(uname)" = "Darwin" ]; then
    # Ensure colors in terminal
    export CLICOLOR=1
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
else
    alias ls='ls -GpFh --color=auto'
    eval `dircolors ~/.dircolors/solarized/dircolors.ansi-dark`
fi

export SHELL=$(which zsh)
