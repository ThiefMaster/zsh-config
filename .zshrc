# vim: ts=4 sw=4

# get the directory where this file is located
_custom_zsh_config_base="${${(%):-%x}:A:h}"

# bail out if global config is disabled
[[ $_custom_zsh_config_base == */etc/* && $_custom_zsh_no_global == 1 ]] && return

# bail out if we are already loaded
if (( _custom_zsh_config_loaded )); then
	print -P '%B%F{red}The custom ZSH config is already loaded (probably from the global zshrc)%f%b'
	print -P "%B%F{red}The local version ($_custom_zsh_config_base) has NOT been loaded%f%b"
	print -P '%B%F{yellow}To disable this warning, run the following command:%f%b'
	print -P "%B%F{green}echo '_custom_zsh_no_global=1' >>! ~/.zshenv%f%b"
	return
fi
_custom_zsh_config_loaded=1

# load all our config files
for file ($_custom_zsh_config_base/zshrc.d/*.zsh(N)); do
	source $file
done
