#!/bin/bash

# this is ment to be run by cron

# update oh-my-zsh
yes | sh "${HOME}/.oh-my-zsh/tools/upgrade.sh"

# update powerlevel9k
cd "${HOME}/.oh-my-zsh/custom/themes/powerlevel9k" && git pull --rebase

cd "${HOME}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" && git pull --rebase

# update fuzzy finder
cd "${HOME}/.fzf" && git pull && yes | ./install

# update brew
if hash brew &>/dev/null; then
  brew update
  brew upgrade
  brew cleanup
fi
