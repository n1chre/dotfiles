# path to the dotfiles dir
export DOTFILES="$HOME/dotfiles"

# locale settings
export LC_ALL='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'
export LANG='en_US.UTF-8'

export TERM='xterm-256color'
export EDITOR='vim'

# set up less
export PAGER=less
export LESS=FRX
LESS_PIPE=lesspipe.sh
export LESSOPEN="| ${LESS_PIPE} %s";
export LESSCLOSE="${LESS_PIPE} %s %s";

# save history on each command
export PROMPT_COMMAND="history -a; history -n"

# run this on python interpreter startup
export PYTHONSTARTUP="$HOME/.pythonrc"
