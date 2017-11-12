#!/bin/bash

# get utility functions
# shellcheck disable=SC1091 disable=SC2164 disable=SC2103
source ./util.sh

MY_ZSH_RELATIVE='.zsh'
MY_ZSH="${HOME}/${MY_ZSH_RELATIVE}"
mkdir -p "${MY_ZSH}"

################################################################################
# Helper functions                                                             #
################################################################################

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

    print_info "Put custom scripts in ${MY_ZSH} and source them in .zshrc"
}

add_repo(){
  # returns:
  #   0 - added repo
  #   1 - didn't add
  local URL="$1"
  local NAME
  NAME=$(basename "${URL}")
  if [ ! -d "./${NAME}" ]; then
      git submodule add -f "$URL" &>/dev/null
      print_success "Installed ${NAME}"
      return 0
  fi
  return 1
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

pushd "${HOME}/.oh-my-zsh/custom" &>/dev/null

# install theme
cd themes
if add_repo https://github.com/bhilburn/powerlevel9k; then
  print_info "Install font SourceCodePro for everything to work!"
  print_info "url: https://github.com/adobe-fonts/source-code-pro"
  print_info "url: https://github.com/powerline/fonts"
fi
cd ..

# install plugins
cd plugins
add_repo https://github.com/djui/alias-tips
add_repo https://github.com/zdharma/fast-syntax-highlighting
add_repo https://github.com/zsh-users/zsh-autosuggestions
cd ..

# if something was added, add it and commit it so that `git pull --rebase` works
if [ -n "$(git status --porcelain)" ]; then
  git add -A && git commit -avm '[auto] added themes and plugins as gitmodules'
fi

popd &>/dev/null  # return to previous directory

print_success "ZSH has been setup!!!"

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
if ! grep 'my_update.sh' crontab.tmp &>/dev/null ; then
    echo "0 12 * * 3 ~/bin/my_update.sh" >> crontab.tmp  # every wednesday at noon
    crontab crontab.tmp
fi
rm -f crontab.tmp

################################################################################
# Symlinks                                                                     #
################################################################################

print_info "Setting up symlinks"

# symlink bin to ~/bin and make them executable
link_smart bin
for ex in ${HOME}/bin; do chmod +rwx "${ex}"; done

# symlink all .configs to ~/.config
link_smart config .config

# symlink everything in git to ~
link_smart git/gitconfig .gitconfig
link_smart git/gitignore .gitignore

# link zsh stuff
link_smart zsh/zshrc .zshrc
link_smart zsh/zshenv .zshenv
link_smart zsh "${MY_ZSH_RELATIVE}"
# remove some links
unlink "${HOME}/${MY_ZSH_RELATIVE}/zshrc"
unlink "${HOME}/${MY_ZSH_RELATIVE}/zshenv"

if [ "${OSX}" -eq 1 ]; then
  mkdir -p "${HOME}/Library/Application Support/Spectacle"
  link_smart files/spectacle.json "Library/Application Support/Spectacle/Shortcuts.json"
fi

# DONE!!!
print_success "All done!"
print_info "execute \$ source ~/.zshrc"
