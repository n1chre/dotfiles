source $DOTFILES/shell/prompt.sh
ZSH_THEME="powerlevel10k/powerlevel10k"

# used in .p10k.zsh as a my_vcs segment
function prompt_my_vcs () {
	local prompt="$(_scm_prompt)"  # from shell/prompt.sh ^
    [ -z "$prompt" ] && return
    p10k segment -f yellow -t "${prompt##*( )}"
}
