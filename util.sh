#!/bin/bash

# shellcheck disable=SC2034 disable=SC2044
# complains about not exporting variables and for...find being fragile

# get dotfiles directory
DOTFILES="$(cd "$(dirname "$0")" || exit 1; pwd -P)"

# set os
if [ "$(uname -s)" = "Darwin" ]; then
    OSX=1
else
    OSX=0
fi

backup="${DOTFILES}/backup"
mkdir -p "${backup}"

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
  if [ -x "$(command -v "$1")" ]; then
      true
  else
      false
  fi
}

link_ask() {
    [ $# -eq 2 ] || false
    local sourceFile=$1
    local targetFile=$2
    if [ ! -e "${targetFile}" ]; then
        if ln -fs "${sourceFile}" "${targetFile}"; then
          print_success "${targetFile} → ${sourceFile}"
        else
          print_error "${targetFile} → ${sourceFile}"
        fi
    elif [ "$(readlink "${targetFile}")" != "${sourceFile}" ]; then
        if ask "'${targetFile}' already exists, do you want to overwrite it?"
        then
            local backupFile=${backup}${targetFile}
            mkdir -p "$(dirname "${backupFile}")"
            mv "${targetFile}" "${backupFile}" && print_info "Backed up to ${backupFile}"
            if ln -fs "${sourceFile}" "${targetFile}"; then
              print_success "${targetFile} → ${sourceFile}"
            else
              print_error "${targetFile} → ${sourceFile}"
            fi
        else
            print_error "${targetFile} → ${sourceFile}"
        fi
    fi
}

link_smart() {
    # link_smart sourceFile [targetFile = ~/sourceFile]
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
        for name in $(find "${source}" -mindepth 1 -maxdepth 1); do
            link_ask "${name}" "${targetFile}/$(basename "${name}")"
        done
    else
        link_ask "${source}" "${targetFile}"
    fi
}
