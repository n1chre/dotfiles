#!/bin/bash

# get utility functions
source ./util.sh

print_info "Setting up symlinks"

# symlink bin to ~/bin
link_smart bin

# symlink all .configs to ~/.config
link_smart .config

# symlink everything in git to ~
link_smart git ''
