# set up path

function append_path {
  if [ -d "${1}" ]; then
    if [[ ${PATH} != *:${1}:* ]] && \
       [[ ${PATH} != ${1}:*   ]] && \
       [[ ${PATH} != *:${1}   ]]; then
      PATH="$PATH:${1}"
    fi
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
export PATH=${PATH:1}
unset PATH_DIRS
# disable path_helper on mac in /etc/zprofile for magic rewriting of this
