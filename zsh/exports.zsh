#!/bin/zsh

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export EDITOR='vim'
export PAGER='less -FRX'
# make less more friendly for non-text input files, see lesspipe(1)
LESS_PIPE="lesspipe"
export LESSOPEN="| ${LESS_PIPE} %s";
export LESSCLOSE="${LESS_PIPE} %s %s";
