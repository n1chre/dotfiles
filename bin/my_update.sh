#!/bin/bash

# this is ment to be run by cron

# update oh-my-zsh
cd ${HOME}/.oh-my-zsh && upgrade_oh_my_zsh

# update powerlevel9k
cd ${HOME}/.oh-my-zsh/custom/themes/powerlevel9k && git pull --rebase

# update fuzzy finder
cd ${HOME}/.fzf && git pull && ./install

# update brew
hash brew &>/dev/null && { brew update ; brew upgrade ; brew cleanup }
