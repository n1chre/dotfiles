# set up path
PATH_DIRS=( \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/bin \
  /usr/sbin \
  /bin \
  /sbin \
  $HOME/bin \
)
unset PATH
for DIR in ${PATH_DIRS}; do
	if [ -d "${DIR}" ]; then
    	PATH=$PATH:${DIR}
	fi
done
export PATH=${PATH:1}
unset PATH_DIRS
