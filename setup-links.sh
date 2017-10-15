#!/bin/bash

# get dotfiles directory
DOTFILES="$(cd "$(dirname "$0")" || exit 1; pwd -P)"

linky() {
    # linky target [dst=$HOME/target] == ln -s $DOTFILES/target dst
    if [ "${#}" -ne 1 ]; then
        echo "Provide target name"
        return 1
    fi
    local src="${DOTFILES}/${1}"
    if [ ! -e "${src}" ]; then
        echo "Target doesn't exist"
        return 2
    fi

    local dst=${HOME}/${1}
    if [ "${#}" -eq 2 ]; then
        dst=${HOME}/${2}
    fi

    if [ -d "${src}" ]; then
        mkdir -p "${dst}"
        for name in ${src}/*; do
            local target="${dst}/$(basename ${name})"
            if [ ! -e "${target}" ]; then
                ln -s "${name}" "${target}"
            else
                echo "${target} exists; skipping..."
            fi
        done
    elif [ ! -e "${dst}" ]; then
        ln -s "${src}" "${dst}"
    else
        echo "${dst} exists; skipping..."
    fi
}

# setup personal bin folder
linky bin

# setup git
linky .gitconfig
linky .gitignore
