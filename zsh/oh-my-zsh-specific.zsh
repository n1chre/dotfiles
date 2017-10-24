# here are the oh-my-zsh specific stuff and plugins

DISABLE_AUTO_UPDATE="true"
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

# see .oh-my-zsh/lib/clipboard.zsh
alias ctrlc='clipcopy'
alias ctrlv='clippaste'

export ZSH_PLUGINS_ALIAS_TIPS_TEXT='Why not this? >> '

plugins=(\
  alias-tips \
  colored-man-pages \
  fast-syntax-highlighting \
  sudo \
  web-search \
  zsh-autosuggestions \
  z \
)

if [ "$(uname -s)" = "Darwin" ]; then
    plugins+=(osx)
fi
