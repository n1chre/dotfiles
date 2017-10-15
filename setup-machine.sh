#!/bin/bash

# get utility function
DOTFILES="$(cd "$(dirname "$0")" || exit 1; pwd -P)"
# shellcheck source=./util.sh disable=SC1091
source "$DOTFILES/util.sh"

install_zsh() {
  # If zsh isn't installed, try to install it
  if [ "${OSX}" -eq 1 ]; then
      brew install zsh
  else
    # it better be linux
      if [ -f /etc/redhat-release ]; then
          sudo yum install zsh
      elif [ -f /etc/debian_version ]; then
          sudo apt-get install zsh
      else
        print_error "Unknown operating system, don't know what to do"
      fi
  fi
}

install_oh_my_zsh() {
    # Install Oh My Zsh if it isn't already present
    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
        print_info "oh-my-zsh not found, donloading it..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        print_success "Installed oh-my-zsh"
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [ "${SHELL}" != /bin/zsh ]; then
        print_info "Changing shell to zsh"
        execute "sudo chsh -s /bin/zsh" "Changed shell to zsh"
    fi
}

################################################################################
# ZSH                                                                          #
################################################################################

print_info "Setup ZSH"

# install oh-my-zsh
if [ ! -f /bin/zsh ]; then
    install_zsh
    if [ -f /bin/zsh ]; then
        print_error "/bin/zsh doesn't exist. What went wrong?"
        exit 1
    fi
    print_success "Installed zsh, re-run this script"
    exit 0
fi
install_oh_my_zsh

# install powerlevel9k theme
if [ ! -d "${HOME}/.oh-my-zsh/custom/themes/powerlevel9k" ]; then
    git clone https://github.com/bhilburn/powerlevel9k.git \
              "${HOME}/.oh-my-zsh/custom/themes/powerlevel9k"
    print_success "Installed powerlevel9k theme"
    print_info "Install font SourceCodePro for everything to work!"
    print_info "url: https://github.com/adobe-fonts/source-code-pro"
    print_info "url: https://github.com/powerline/fonts"
fi

################################################################################
# Fuzzy finder                                                                 #
################################################################################

print_info "Setup fuzzy finder"

if [ ! -d "${HOME}/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
    "${HOME}/.fzf/install"
    print_success "Installed fuzzy finder"
fi

################################################################################
# Cron                                                                         #
################################################################################

print_info "Setup cron"

crontab -l > crontab.tmp
if ! grep 'my-update.sh' crontab.tmp &>/dev/null ; then
    echo "0 12 * * * ~/my-update.sh" >> crontab.tmp  # every day at noon
    crontab crontab.tmp
fi
rm -f crontab.tmp

################################################################################
# Finish                                                                       #
################################################################################

# set up symlinks and start using it
"$DOTFILES/setup-links.sh"
print_success "All done!"
print_info "execute \$ source ~/.zshrc"
