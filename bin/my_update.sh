#!/bin/bash

# this is ment to be run by cron

# update oh-my-zsh and all plugins and themes
cd "${HOME}/.oh-my-zsh" && \
git pull --recurse-submodules --rebase --stat origin master

# update fuzzy finder
cd "${HOME}/.fzf" && git pull && yes | ./install

# update brew
if hash brew &>/dev/null; then
  brew update
  brew upgrade
  brew cleanup
fi
