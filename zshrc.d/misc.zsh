# vim: ts=4 sw=4
# Pretty dircolors
eval `dircolors -b /etc/bash/LS_COLORS`

# Prettier ZLE highlighting
zle_highlight=(region:standout special:fg=199 isearch:fg=220)

# Auto-quote meta chars in URLs and Git refspecs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
git-escape-magic

# Show user/host/pwd in terminal title
autoload -Uz add-zsh-hook
_show_pwd() { print -Pn "\e]0;[%n@%m:%d]\a" }
[[ "$TERM" != "linux" ]] && add-zsh-hook precmd _show_pwd

# Builtin help, triggered with \e-h
autoload -Uz run-help
unalias run-help 2>/dev/null

# Interactive mv
function imv() {
	local src dst
	for src; do
		[[ -e $src ]] || { print -Pu2 "%F{red}%B$src: No such file or directory%b%f"; continue }
		dst=$src
		vared dst
		[[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
	done
}

# Useful stuff
autoload -Uz age
autoload -Uz zargs
autoload -Uz zcalc
