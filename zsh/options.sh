source $DOTFILES/shell/options.sh

# zsh specific under this

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
#allow tab completion in the middle of a word
setopt complete_in_word
