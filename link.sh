#!/usr/bin/env bash
DOTFILES="${HOME}/dotfiles"

ln -fs "${DOTFILES}/bash/bashrc" ~/.bashrc
ln -fs "${DOTFILES}/configs/gitconfig" ~/.gitconfig
ln -fs "${DOTFILES}/configs/gitignore" ~/.gitignore
ln -fs "${DOTFILES}/configs/inputrc" ~/.inputrc
ln -fs "${DOTFILES}/configs/pythonrc" ~/.pythonrc
ln -fs "${DOTFILES}/configs/tmux.conf" ~/.tmux.conf
ln -fs "${DOTFILES}/zsh/zshrc" ~/.zshrc
ln -fs "${DOTFILES}/zsh/zshenv" ~/.zshenv
