#!/bin/zsh

# prefix it with space so these commands don't get saved to history
alias cd=' cd'
alias cp=' cp --backup=numbered'
alias exit=' exit'
alias ln=' ln --backup=numbered'
alias ls=' ls'
alias mv=' mv -f --backup=numbered'
alias pwd=' pwd'

alias grep='grep --color=auto'
alias path='echo -e ${PATH//:/\\n}'
alias py='python'
alias py3='python3'
alias rm='rm -i'
alias sush='ssh -l root'
alias tree='tree -CFupsha'