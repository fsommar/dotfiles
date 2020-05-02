export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LD_LIBRARY_PATH="/usr/local/bin:${LD_LIBRARY_PATH}"

export GEM_HOME=/usr/local/lib/ruby/gems/
export EDITOR=vim
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
# shellcheck disable=SC2155
export SHELL="$(command -v zsh)"
# shellcheck disable=SC2155
export GPG_TTY="$(tty)"
export PROJECT_PATH="${HOME}/projects"
export GO11MODULE=on

# shellcheck disable=SC2140
export PATH=\
"${HOME}/bin":\
/usr/local/bin:\
/usr/local/opt/mysql-client/bin:\
/usr/local/opt/make/libexec/gnubin:\
/usr/local/opt/python/libexec/bin:\
"${HOME}/scripts":\
"${GEM_HOME}/bin":\
"${HOME}/.jenv/bin":\
"${HOME}/.cargo/bin":\
"${HOME}/go/bin":\
"${PATH}"

alias -g NUL="> /dev/null 2>&1"
alias gs='git st'
alias gd='git df'
alias gdc='gd --cached'
alias grep='grep --color'
alias -g ...='../..'
alias -g ....='../../..'

if command -v exa > /dev/null 2>&1; then
  # shellcheck disable=SC2120
  function ls() {
    if [[ "$#" -eq 0 ]]; then
      exa -Fx
    else
      exa -F --color-scale "$@"
    fi
  }
else
  alias ls='ls -GpFh'
fi

alias ll='ls -l'

# shellcheck disable=SC2119
cd() { builtin cd "$@" && ls; }
# shellcheck disable=SC2164
function cdp() {
  if [[ "$#" -eq 0 ]]; then
    cd "${PROJECT_PATH}"
  else
    cd "${PROJECT_PATH}/$1"
  fi
}

if [[ $(uname) = Darwin ]]; then
  # Ensure colors in terminal
  export CLICOLOR=1
  export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
fi

function iterm2_print_user_vars() {
  iterm2_set_user_var kubecontext "$(kubectl config current-context | awk -F'_' '{print $NF}')"
  iterm2_set_user_var kubenamespace "$(kubectl config view --minify --output 'jsonpath={..namespace}')"
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
test -e "${HOME}/.secret_envs" && source "${HOME}/.secret_envs"
command -v zoxide > /dev/null 2>&1 && eval "$(zoxide init zsh)"

if command -v jenv > /dev/null 2>&1; then
  eval "$(jenv init - --no-rehash)"
  (jenv rehash &) > /dev/null 2>&1
fi
