# Show git branch in command line prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Venv prompt
function __virtualenv_ps1 {
    echo "${VIRTUAL_ENV:+(venv:${VIRTUAL_ENV##*/})}"
}
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Full bash prompt
export PS1="\u@\h \[\033[32m\]\w -\$(parse_git_branch)\$(__virtualenv_ps1) $ "

# Git autocompletion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Change terminal color to red when using ssh
# See: https://gist.github.com/porras/5856906
function tabc() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi # if you have trouble with this, change
                                                      # "Default" to the name of your default theme
  osascript -e "tell application \"Terminal\" to set current settings of front window to settings set \"$NAME\""
}

function colorssh() {
  tabc SSH
  ssh $*
  tabc
}

alias ssh="colorssh"
