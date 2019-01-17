# default umask
umask 022

# fail if any command in pipe fails, not only last one
set -o pipefail

# vi key bindings
set -o vi

# don't allow `$cmd > existing_file`
# overwrite with `$cmd >! existing_file`
set -o noclobber
