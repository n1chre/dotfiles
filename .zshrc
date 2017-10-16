# Source global definitions
if [ -f /etc/zshrc ]; then
  source /etc/zshrc
fi

# set up path
PATH_DIRS=( \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/bin \
  /usr/sbin \
  /bin \
  /sbin \
  $HOME/bin \
)
unset PATH
for DIR in ${PATH_DIRS}; do
	if [ -d "${DIR}" ]; then
    	PATH=$PATH:${DIR}
	fi
done
export PATH=${PATH:1}
unset PATH_DIRS

export ZSH="${HOME}/.oh-my-zsh"

# History

HISTFILE="${HOME}/.zsh_history" # The path to the history file.
HISTSIZE=100000000              # The maximum number of events to save in the internal history.
SAVEHIST=100000000              # The maximum number of events to save in the history file.
setopt BANG_HIST                # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY         # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY       # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY            # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS        # Do not display a previously found event.
setopt HIST_IGNORE_SPACE        # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file.
setopt HIST_VERIFY              # Do not execute immediately upon history expansion.
setopt HIST_BEEP                # Beep when accessing non-existent history.
setopt HIST_NO_STORE            # Remove the history (fc -l) command from the history list when invoked

# prefix it with space so these commands don't get saved to history
alias cp=' cp --backup=numbered'
alias ln=' ln --backup=numbered'
alias mv=' mv -f --backup=numbered'
alias ls=' ls'
alias cd=' cd'
alias pwd=' pwd'
alias exit=' exit'

# custom scm prompt
POWERLEVEL9K_CUSTOM_SCM="_scm_prompt"
POWERLEVEL9K_CUSTOM_SCM_BACKGROUND="yellow"
POWERLEVEL9K_CUSTOM_SCM_FOREGROUND="black"
source ${HOME}/.scm.sh

# setup theme
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_BATTERY_VERBOSE=false
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir custom_scm)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time command_execution_time)
POWERLEVEL9K_MODE='awesome-patched'
ZSH_THEME="powerlevel9k/powerlevel9k"

CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="false"

plugins=(\
  colored-man-pages \
  fast-syntax-highlighting \
  z \
)

source ${ZSH}/oh-my-zsh.sh

umask 022

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export EDITOR='vim'
export PAGER='less -FRX'
# make less more friendly for non-text input files, see lesspipe(1)
LESS_PIPE="lesspipe"
export LESSOPEN="| ${LESS_PIPE} %s";
export LESSCLOSE="${LESS_PIPE} %s %s";

alias sush='ssh -l root'
alias rm='rm -i'
alias grep='grep --color=auto'
alias tree='tree -CFupsha' # need to install
alias path='echo -e ${PATH//:/\\n}'
alias py='python'
alias py3='python3'

# extract all kinds of compressed files with single command
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract file [, file, file, ...]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
      fi
    done
fi
}

set -o pipefail
set -o vi # vi mode editing in shell

# any local settings ?
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
