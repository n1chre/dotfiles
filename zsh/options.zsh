# default umask
umask 022

# fail if any command in pipe fails, not only last one
set -o pipefail
# vi key bindings
set -o vi

# don't beep on error
setopt no_beep
# Allow comments even in interactive shells (especially for Muness)
setopt interactive_comments
# enter directory just by typing it's name
setopt auto_cd
# don't push multiple copies of the same directory onto the directory stack
setopt pushd_ignore_dups
# no spelling correction
unsetopt correct_all
