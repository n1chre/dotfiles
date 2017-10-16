#!/bin/zsh

MY_ZSH=${HOME}/.oh-my-zsh/custom/my_zsh

if git rev-parse &>/dev/null; then
  # standard vcs for git is better
  VCS=vcs
else
  # fb scm prompt is better for hg
  POWERLEVEL9K_CUSTOM_VCS="_vcs_prompt"
  POWERLEVEL9K_CUSTOM_VCS_BACKGROUND="yellow"
  POWERLEVEL9K_CUSTOM_VCS_FOREGROUND="black"
  source ${MY_ZSH}/vcs_prompt.sh
  VCS=custom_vcs
fi

# setup theme
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_BATTERY_VERBOSE=false
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir ${VCS})
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs time command_execution_time)
POWERLEVEL9K_MODE='awesome-patched'
ZSH_THEME="powerlevel9k/powerlevel9k"

CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

plugins=(\
  colored-man-pages \
  fast-syntax-highlighting \
  z \
)
