# set up path

function is_dir_and_not_in {
  [[ -d ${1} ]] && [[ ${2} != *:${1}:* ]] && [[ ${2} != ${1}:* ]] && [[ ${2} != *:${1} ]]
}

function append_path {
  if is_dir_and_not_in "${1}" "${PATH}"; then
    PATH="${PATH}:${1}"
  fi
}

function prepend_path {
  if is_dir_and_not_in "${1}" "${PATH}"; then
    PATH="${1}:${PATH}"
  fi
}

function append_manpath {
  if is_dir_and_not_in "${1}" "${MANPATH}"; then
    MANPATH="${MANPATH}:${1}"
  fi
}

function prepend_manpath {
  if is_dir_and_not_in "${1}" "${MANPATH}"; then
    MANPATH="${1}:${MANPATH}"
  fi
}

PATH_DIRS=( \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/bin \
  /usr/sbin \
  /bin \
  /sbin \
  $HOME/bin \
)
PATH=
for DIR in ${PATH_DIRS}; do append_path ${DIR}; done

# export them
export PATH=${PATH:1}
export MANPATH
unset PATH_DIRS
# disable path_helper on mac in /etc/zprofile for magic rewriting of this
