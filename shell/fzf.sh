#! /usr/bin/env bash

current_shell="$1"
if [[ -z "$current_shell" ]]; then current_shell=$(ps -o args= -p "$$"); fi

if [[ "${current_shell}" = *bash ]]; then
  FZF_FILE=~/.fzf.bash
elif [[ "${current_shell}" = *zsh ]]; then
  FZF_FILE=~/.fzf.zsh
else
  echo "FZF - Unknown shell: ${current_shell}"
  return
fi
unset current_shell

if [ ! -f ${FZF_FILE} ]; then
  "${FZF_FILE} doesn't exist, reinstall fzf?"
  unset FZF_FILE
  return
fi

source $FZF_FILE
unset FZF_FILE

export FZF_DEFAULT_COMMAND='ag -U --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--bind "F1:toggle-preview" --preview "rougify {} 2> /dev/null || cat {} 2> /dev/null || tree -C {} 2> /dev/null | head -100" --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
--color info:150,prompt:110,spinner:150,pointer:167,marker:174'

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}
