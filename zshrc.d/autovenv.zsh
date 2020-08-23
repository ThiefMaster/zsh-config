# vim: ts=4 sw=4

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _autovenv_chpwd

function _autovenv_chpwd() {
	setopt localoptions
	local pyenv_venv_init_cmd env ps1 current_env=$VIRTUAL_ENV

	(( MANUAL_VENV )) && return
	[[ ! -f ~/.autovenv ]] && return

	if [[ -n $PYENV_VIRTUALENV_INIT ]]; then
		# pyenv-virtualenv is not compatible with this because having two utils that activate/deactivate
		# virtualenvs is a mess and even more so when they use different shell hooks (this one uses chpwd,
		# pyenv-virtualenv uses precmd).
		# when both are active at the same time they fail rather quietly so we force the user to choose one
		if (( !_custom_zsh_autovenv_pyenv_warned )); then
			print -P '%F{220}WARNING: %F{247}autovenv%F{242} is %F{196}not compatible%F{242} with %F{247}pyenv-virtualenv%F{242} so it has been disabled.%f'
			pyenv_venv_init_cmd='eval "$(pyenv virtualenv-init -)"'
			if [[ -f ~/.zshrc ]] && grep -qxF $pyenv_venv_init_cmd ~/.zshrc; then
				print -P '%F{242}Please remove the following line from your %F{247}~/.zshrc%F{242} to disable pyenv-virtualenv:%f'
				grep -xnF $pyenv_venv_init_cmd ~/.zshrc
			else
				print -P '%F{242}Please ensure that the following code is not executed (usually it is in your shell config):%f'
				print -P '%F{9}${pyenv_venv_init_cmd}%f'
			fi
			print -P '%F{242}Alternatively, you can delete %F{247}~/.autovenv%F{242} to disable autovenv.%f'
			print -P '%F{220}Regardless of what you choose, open a new shell afterwards.%f'
			_custom_zsh_autovenv_pyenv_warned=1
		fi
		return
	fi

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
