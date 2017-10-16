#!/bin/bash

# get utility functions
DOTFILES="$(cd "$(dirname "$0")" || exit 1; pwd -P)"
# shellcheck source=./util.sh disable=SC1091
source "$DOTFILES/util.sh"

MY_ZSH=.oh-my-zsh/custom/my_zsh

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
link_smart zsh ${MY_ZSH}
# remove some links
unlink ${HOME}/${MY_ZSH}/zshrc
unlink ${HOME}/${MY_ZSH}/zshenv
