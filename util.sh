#!/bin/bash

# get dotfiles directory
export DOTFILES
DOTFILES="$(cd "$(dirname "$0")" || exit 1; pwd -P)"

# set os
export OSX
if [ "$(uname -s)" = "Darwin" ]; then
    OSX=1
else
    OSX=0
fi

backup="$DOTFILES/backup"
mkdir -p $backup

print_info() {
  # Print output in purple
  printf "\e[0;35m %s\e[0m\n" "$1"
}

print_error() {
  # Print output in red
  printf "\e[0;31m  [✖] %s %s\e[0m\n" "$1" "$2"
}

print_question() {
  # Print output in yellow
  printf "\e[0;33m  [?] %s\e[0m " "$1"
}

print_success() {
  # Print output in green
  printf "\e[0;32m  [✔] %s\e[0m\n" "$1"
}

print_result() {
  if [ "$1" -eq 0 ]; then
      print_success "$2"
  else
      print_error "$2"
  fi

  [ "$3" = "true" ] && [ "$1" -ne 0 ] && exit
}

# asking for stuff

ask() {
  print_question "$1 (y/n) "
  read -r answer
  case ${answer} in
    [Yy]* ) true ;;
    * ) false ;;
  esac
}

ask_sudo() {
  # Ask for the administrator password upfront
  sudo -v
  # Update existing `sudo` time stamp until this script has finished
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &
}

cmd_exists() {
  [ -x "$(command -v "$1")" ] && true || false
}

execute() {
  $1 &> /dev/null
  print_result $? "${2:-$1}"
}

is_git_repository() {
  git rev-parse &>/dev/null && true || false
}

link_ask() {
    [ $# -eq 2 ] || false
    local sourceFile=$1
    local targetFile=$2
    if [ ! -e "${targetFile}" ]; then
        execute "ln -fs ${sourceFile} ${targetFile}" "${targetFile} → ${sourceFile}"
    elif [ "$(readlink "${targetFile}")" = "${sourceFile}" ]; then
        print_success "${targetFile} → ${sourceFile}"
    else
        if ask "'${targetFile}' already exists, do you want to overwrite it?"
        then
            local backupFile=${backup}${targetFile}
            mkdir -p $(dirname "${backupFile}")
            mv ${targetFile} ${backupFile} && print_info "Backed up to ${backupFile}"
            execute "ln -fs ${sourceFile} ${targetFile}" "${targetFile} → ${sourceFile}"
        else
            print_error "${targetFile} → ${sourceFile}"
        fi
    fi
}

link_smart() {
    # link_smart sourceFile [targetFile=$HOME/target]
    # if target is a file, do link of a file
    # if target is a directory, link insides of the directory

    local source="${DOTFILES}/$1"
    if [ ! -e "${source}" ]; then
        echo "Source doesn't exist"
        false
    fi

    local targetFile=${HOME}/$1
    if [ "$#" -ge 2 ]; then
        if [ "$2" = '' ]; then
            targetFile=${HOME}
        else
            targetFile=${HOME}/$2
        fi
    fi

    if [ -d "${source}" ]; then
        mkdir -p "${targetFile}"
        for name in `find ${source} -depth 1`; do
            local target
            target=$(basename "${name}")
            target="${targetFile}/${target}"
            link_ask "${name}" "${target}"
        done
    else
        link_ask "${source}" "${targetFile}"
    fi
}

export -f print_info
export -f print_error
export -f print_question
export -f print_success
export -f print_result

export -f ask
export -f ask_sudo

export -f execute
export -f cmd_exists
export -f is_git_repository

export -f link_ask
export -f link_smart
