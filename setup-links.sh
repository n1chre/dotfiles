#!/bin/bash

# get utility functions
DOTFILES="$(cd "$(dirname "$0")" || exit 1; pwd -P)"
source $DOTFILES/util.sh

print_info "Setting up symlinks"

# symlink bin to ~/bin and make them executable
link_smart bin
for ex in ${HOME}/bin; do
    chmod +rwx ${ex}
done

# symlink all .configs to ~/.config
link_smart .config

# symlink everything in git to ~
link_smart git ''
