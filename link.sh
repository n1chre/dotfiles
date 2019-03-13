#!/usr/bin/env bash
DOTFILES="~/dotfiles"

ln -fs "${DOTFILES}/bash/bashrc" ~/.bashrc
ln -fs "${DOTFILES}/gitconfig" ~/.gitconfig
ln -fs "${DOTFILES}/gitignore" ~/.gitignore
ln -fs "${DOTFILES}/inputrc" ~/.inputrc
ln -fs "${DOTFILES}/pythonrc" ~/.pythonrc
ln -fs "${DOTFILES}/tmux.conf" ~/.tmux.conf
ln -fs "${DOTFILES}/zsh/zshrc" ~/.zshrc
ln -fs "${DOTFILES}/zsh/zshenv" ~/.zshenv
