source $DOTFILES/shell/prompt.sh

# zsh specific under this

setopt PROMPT_SUBST

# if git rev-parse &>/dev/null; then
#   # standard vcs for git is better
#   VCS=vcs
# else
#   fb scm prompt is better for hg
#   POWERLEVEL9K_CUSTOM_VCS="_vcs_prompt"
#   POWERLEVEL9K_CUSTOM_VCS_BACKGROUND="yellow"
#   POWERLEVEL9K_CUSTOM_VCS_FOREGROUND="black"
#   VCS=custom_vcs
# fi

# TODO: figure out how to do the above, use vcs based on repo
POWERLEVEL9K_CUSTOM_VCS="_vcs_prompt"
POWERLEVEL9K_CUSTOM_VCS_BACKGROUND="yellow"
POWERLEVEL9K_CUSTOM_VCS_FOREGROUND="black"
VCS=custom_vcs

# setup theme
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{white}→ %f "
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_BATTERY_VERBOSE=false
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir_writable dir $VCS)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs load time command_execution_time)
POWERLEVEL9K_MODE='awesome-patched'
ZSH_THEME="powerlevel9k/powerlevel9k"
