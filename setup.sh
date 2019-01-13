#!/bin/bash

echo "Don't use this, not ready yet. Old version"
exit

# get utility functions
# shellcheck disable=SC1091 disable=SC2164 disable=SC2103
source ./util.sh

MY_BASH_RELATIVE='.bash'
MY_BASH="${HOME}/${MY_BASH_RELATIVE}"
mkdir -p "${MY_ZSH}"

################################################################################
# Helper functions                                                             #
################################################################################

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
# Miscellaneous                                                                #
################################################################################

# hush logins
touch "${HOME}/.hushlogin"

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
link_smart bash/bashrc .bashrc
link_smart bash/bash_profile .bash_profile
link_smart bash "${MY_BASH_RELATIVE}"
# remove some links
unlink "${HOME}/${MY_BASH_RELATIVE}/bashrc"
unlink "${HOME}/${MY_BASH_RELATIVE}/bash_profile"

if [[ "${OSX}" = 1 ]]; then
  print_info "Setting up MacOS specific stuff"
  # Spectacle config
  mkdir -p "${HOME}/Library/Application Support/Spectacle"
  link_smart files/spectacle.json "Library/Application Support/Spectacle/Shortcuts.json"

  # gnupg
  mkdir -p "${HOME}/.gnupg"
  link_smart files/gpg-agent.conf .gnupg/gpg-agent.conf
fi

# remove backup dir if empty
rmdir backup &>/dev/null

# DONE!!!
print_success "All done!"
print_info "execute \$ source ~/.bashrc"
