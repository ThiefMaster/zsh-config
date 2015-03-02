# vim: ts=4 sw=4

# Misc prompts
ZCALCPROMPT='%F{48}%1v>%f '
SPROMPT='zsh: correct '%F{166}%R%f' to '%F{76}%r%f' [nyae]? '

# Main prompt
autoload -Uz add-zsh-hook
add-zsh-hook preexec _prompt_preexec
add-zsh-hook precmd _prompt_precmd
integer _prompt_next_command _prompt_last_command

function _prompt_preexec() {
	(( _prompt_next_command++ ))
}

function _prompt_precmd() {
	setopt localoptions
	local endsign host_color user_color last_was_empty
	host_color="%F{${ZSH_HOST_COLOR:-33}}"

	# Check if the last command was empty (always show that case as successful)
	if (( _prompt_next_command == _prompt_last_command )); then
		last_was_empty=1
	else
		last_was_empty=0
		(( _prompt_last_command = _prompt_next_command ))
	fi

	# root gets a special prompt
	if ((UID == 0)); then
		endsign='#'
		user_color='%F{9}'
	else
		endsign='>'
		user_color='%F{10}'
	fi

	# Highlight endsign if last command failed
	if (( !last_was_empty )); then
		endsign="%(?..%K{9}%F{15})$endsign%k"
	fi

	# Load VCS info
	vcs_info

	# Set the actual prompts
	typeset -g PS1="%F{15}[$user_color%n%F{15}@$host_color%m%F{15}:%F{11}%~%F{15}$vcs_info_msg_0_%F{15}]%F{14}$endsign%f "
	typeset -g PS2='%F{14}%_%F{15}>%f '
}

# VCS information
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' nvcsformats ''
zstyle ':vcs_info:git*' check-for-changes true
zstyle ':vcs_info:git*' check-for-staged-changes true
zstyle ':vcs_info:git*' get-revision false
zstyle ':vcs_info:git*' stagedstr '%F{2}+%f'
zstyle ':vcs_info:git*' unstagedstr '%F{1}*%f'
zstyle ':vcs_info:git*' formats ':%F{85}%b%F{85}%u%c%m%f'
zstyle ':vcs_info:git*' actionformats ':%F{85}%b%F{85}%u%c%m%f|%F{67}%a%F{15}%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-fancybranch git-stash git-space

function +vi-git-untracked() {
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && git status --porcelain | grep '??' &> /dev/null ; then
		hook_com[staged]+='%F{1}%%%f'
	fi
}

function +vi-git-fancybranch() {
	if [[ $hook_com[branch] == *... ]]; then
		# get a nice branch name such as master~1
		hook_com[branch]="%F{1}($(${vcs_comm[cmd]} describe --contains --all HEAD))"
	elif [[ $hook_com[branch] == remotes/* ]]; then
		# for a remote we just need to add the () around it and colorize it
		hook_com[branch]="%F{1}(${hook_com[branch]})"
	elif [[ $hook_com[branch] == heads/* ]]; then
		# for a head we let git show us the nice name like git-prompt does
		hook_com[branch]="%F{1}($(${vcs_comm[cmd]} describe --contains --all HEAD))"
	fi
}

function +vi-git-stash() {
	local -a stashes

	hook_com[misc]=''  # we don't care about patches
	if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
		stashes=$(git stash list 2>/dev/null | wc -l)
		hook_com[misc]='%F{12}$'
	fi
}

function +vi-git-space() {
	# Terrible workaround because we can't use conditionals in the format string..
	if [[ -n ${hook_com[unstaged]} || -n ${hook_com[staged]} || -n ${hook_com[misc]} ]]; then
		hook_com[unstaged]=" ${hook_com[unstaged]}"
	fi
}

# adam2 prompt looks pretty but lacks stuff like vcs prompts
# autoload -Uz promptinit
# promptinit
# prompt adam2 8bit
# TRAPWINCH() {
# 	zle && echo '' && prompt_adam2_precmd && zle reset-prompt
# }
