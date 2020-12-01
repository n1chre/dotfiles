source $DOTFILES/shell/history.sh

# zsh specific under this

# The path to the history file.
export HISTFILE="${HOME}/.zsh_history"
# The maximum number of events to save in the internal history.
export HISTSIZE=100000000
# The maximum number of events to save in the history file.
export SAVEHIST=100000000
# Treat the '!' character specially during expansion.
setopt bang_hist
# Write the history file in the ':start:elapsed;command' format.
setopt extended_history
# Write to the history file immediately, not when the shell exits.
setopt inc_append_history
# Share history between all sessions.
# setopt share_history
# Expire a duplicate event first when trimming history.
setopt hist_expire_dups_first
# Do not record an event that was just recorded again.
setopt hist_ignore_dups
# Do not record an event that was just recorded again.
setopt hist_ignore_all_dups
# Do not display a previously found event.
setopt hist_find_no_dups
# Do not record an event starting with a space.
setopt hist_ignore_space
# Do not write a duplicate event to the history file.
setopt hist_save_no_dups
# Do not execute immediately upon history expansion.
setopt hist_verify
# Beep when accessing non-existent history.
setopt hist_beep
# Remove the history (fc -l) command from the history list when invoked
setopt hist_no_store
