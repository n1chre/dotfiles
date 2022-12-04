# prefix it with space so these commands don't get saved to history
alias cd=' cd'
alias exit=' exit'
alias ls=' ls --color'
alias la=' ls -la'
alias pwd=' pwd'

# interactive rm
alias rm='rm -i'

# grep use color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias sudo='sudo '
alias sush='ssh -l root'

alias path='echo -e ${PATH//:/\\n}'

alias py='python'
alias py3='python3'

alias tree="tree -CFupsha -I '.git|.hg'"
