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

function append_unique {
  if is_dir_and_not_in "${1}" "${2}"; then
    echo "${2}:${1}"
  else
    echo "${2}"
  fi
}

function build_path {
  local path="$1"; shift
  local path_file=$1; shift
  local path_dir=$1; shift

  for d in $@; do
    path=$(append_unique "${d}" "${path}")
  done

  if [ -f ${path_file} ]; then
    for d in $(/bin/cat ${path_file}); do
      path=$(append_unique "${d}" "${path}")
    done
  fi

  if [ -d ${path_dir} ]; then
    for path_d in $(/bin/ls ${path_dir}); do
      for d in $(/bin/cat "${path_dir}/${path_d}"); do
        path=$(append_unique "${d}" "${path}")
      done
    done
  fi

  echo $path
}

# ============================================================================ #
# set up PATH                                                                  #
# ============================================================================ #

export PATH=$(build_path "$PATH" /etc/paths /etc/paths.d \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/bin \
  /usr/sbin \
  /bin \
  /sbin \
  $HOME/bin \
)

# ============================================================================ #
# set up MANPATH                                                               #
# ============================================================================ #

export MANPATH=$(build_path "$MANPATH" /etc/manpaths /etc/manpaths.d \
)

# unset some helpers
unset append_unique
unset build_path
