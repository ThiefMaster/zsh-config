# vim: ts=4 sw=4

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _autovenv_chpwd

function _autovenv_chpwd() {
	setopt localoptions
	local env ps1 current_env=$VIRTUAL_ENV

	(( MANUAL_VENV )) && return
	[[ ! -f ~/.autovenv ]] && return
	if ! whence deactivate > /dev/null; then
		current_env=''
	fi

	env=$(python $_custom_zsh_config_base/util/autovenv.py $PWD)
	if [[ $? -ne 0 ]]; then
		print -P '%F{196}error while running autovenv helper%f'
		return
	fi

	if [[ $env == 'IGNORE' ]]; then
		return
	elif [[ $env != $current_env ]]; then
		if [[ $env == 'GLOBAL' && -n $current_env ]]; then
			print -P "%F{247}Deactivating virtualenv %F{242}$current_env%f"
			deactivate
		elif [[ $env != 'GLOBAL' ]]; then
			print -P "%F{247}Activating virtualenv %F{29}$env%F{247} [previously %F{242}${current_env:-(none)}%F{247}]%f"
			unsetopt warn_create_global
			ps1=$PS1  # save PS1 since activate messes with it
			source $env/bin/activate
			PS1=$ps1
		fi
	fi
}
sched 0 _autovenv_chpwd  # run after we are done loading configs
