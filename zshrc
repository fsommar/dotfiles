source ~/.shell/defaults.zsh

function set_win_title(){
    # shellcheck disable=SC2250
    echo -ne "\033]0; ${PWD/$HOME/~} \007"
}
precmd_functions+=(set_win_title)
fpath+=(~/.shell/completions)
setopt autocd
setopt cdablevars
setopt ignoreeof

command -v starship > /dev/null && eval "$(starship init zsh)"

export ZPLUG_HOME=/usr/local/opt/zplug
test -e "${ZPLUG_HOME}" && source ~/.shell/zplug.zsh
