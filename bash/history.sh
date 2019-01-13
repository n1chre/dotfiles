source $DOTFILES/shell/history.sh

# bash specific under this

shopt -s histappend

HISTCONTROL=ignoreboth
HISTSIZE=1000000
HISTFILESIZE=-1
HISTCONTROL=ignoreboth:erasedups
