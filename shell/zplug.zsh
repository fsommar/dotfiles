source "${ZPLUG_HOME}/init.zsh"

zplug "paulirish/git-open"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "gradle/gradle-completion"
zplug "pkulev/zsh-rustup-completion"

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/gpg-agent", from:oh-my-zsh
zplug "plugins/last-working-dir", from:oh-my-zsh

# zplug check returns true if all packages are installed
if ! zplug check; then
    zplug install
fi
#
# source plugins and add commands to the PATH
zplug load
