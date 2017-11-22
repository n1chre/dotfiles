# prefix it with space so these commands don't get saved to history
alias cd=' cd'
alias cp=' cp'
alias exit=' exit'
alias ln=' ln'
alias ls=' ls --color'
alias mv=' mv'
alias pwd=' pwd'

alias grep='grep --color=auto'
alias path='echo -e ${PATH//:/\\n}'
alias py='python'
alias py3='python3'
alias rm='rm -i'
alias sz='source ~/.zshrc'
alias sush='ssh -l root'
alias tree='tree -CFupsha'

# IP addresses
alias ippub="dig +short myip.opendns.com @resolver1.opendns.com"
alias ippriv="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print \$2}'"
