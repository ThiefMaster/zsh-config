# vim: ts=4 sw=4
# INS, DEL, etc.
function _delete-char-or-region() {
	[[ $REGION_ACTIVE -eq 1 ]] && zle kill-region || zle delete-char
}
zle -N _delete-char-or-region
bindkey ${terminfo[kich1]}	quoted-insert
bindkey ${terminfo[kdch1]}	_delete-char-or-region
bindkey ${terminfo[khome]}	beginning-of-line
bindkey ${terminfo[kend]}	end-of-line
bindkey ${terminfo[kpp]}	up-line-or-search
bindkey ${terminfo[knp]}	down-line-or-search
bindkey '\e[1~'				beginning-of-line		# HOME in putty
bindkey '\e[4~'				end-of-line				# END in putty
bindkey "\e[H"				beginning-of-line
bindkey "\e[F"				end-of-line

# Easy access to previous args
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "\em" copy-earlier-word

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Completion
zmodload zsh/complist
bindkey -M menuselect ${terminfo[kcbt]}	reverse-menu-complete	# shift-tab
bindkey -M menuselect ${terminfo[kpp]}	backward-word
bindkey -M menuselect ${terminfo[knp]}	forward-word
bindkey -M menuselect '\eo'				accept-and-infer-next-history
bindkey -M isearch '\e'		accept-search
bindkey '\ee'				end-of-list
bindkey '\eq'				push-line-or-edit

# Misc
bindkey '^[p'				copy-prev-shell-word
bindkey -s ${terminfo[kf5]}	'\C-U unset _custom_zsh_config_loaded; source ~/.zshrc\n'

# Quickly jump right after the first word (e.g. to insert switches)
function _after-first-word() {
	zle beginning-of-line
	zle forward-word
}
zle -N _after-first-word
bindkey '\C-X1' _after-first-word

# Extended word movements/actions
autoload -Uz select-word-style
function _zle-with-style() {
	setopt localoptions
	unsetopt warn_create_global
	local style
	[[ -n "$3" ]] && WORDCHARS=${WORDCHARS/$3}
	[[ $BUFFER =~ '^\s+$' ]] && style=shell || style=$2
	select-word-style $style
	zle $1
	[[ -n "$3" ]] && WORDCHARS="${WORDCHARS}${3}"
	select-word-style normal
}

function _backward-word()		{ _zle-with-style backward-word			bash }
function _forward-word()		{ _zle-with-style forward-word			bash }
function _backward-arg()		{ _zle-with-style backward-word			shell }
function _forward-arg()			{ _zle-with-style forward-word			shell }
function _backward-kill-arg()	{ _zle-with-style backward-kill-word 	shell }
function _forward-kill-arg()	{ _zle-with-style kill-word 			shell }
function _backward-kill-word()	{ _zle-with-style backward-kill-word 	normal }
function _backward-kill-path()	{ _zle-with-style backward-kill-word 	normal	'/' }

zle -N _backward-word
zle -N _forward-word
zle -N _backward-arg
zle -N _forward-arg
zle -N _backward-kill-arg
zle -N _forward-kill-arg
zle -N _backward-kill-word
zle -N _backward-kill-path

bindkey '\C-[OD'	_backward-word		# ctrl-left
bindkey "\e[1;5D"	_backward-word		# ctrl-left
bindkey '\C-[OC'	_forward-word		# ctrl-right
bindkey "\e[1;5C"	_forward-word		# ctrl-right
bindkey '\e\e[D'	_backward-arg		# alt-left
bindkey '\e[1;3D'	_backward-arg		# alt-left
bindkey '\e[1;3C'	_forward-arg		# alt-right
bindkey '\e\e[C'	_forward-arg		# alt-right
bindkey '\e\C-?'	_backward-kill-arg	# alt-backspace
bindkey '\e\e[3~'	_forward-kill-arg	# alt-del
bindkey '\C-w'		_backward-kill-word
bindkey '\C-f'		_backward-kill-path

# Allow more powerful history-i-search (multiple uses in the same line)
autoload -Uz narrow-to-region
function _history-incremental-preserving-pattern-search-backward() {
	local state tmp
	MARK=CURSOR  # magick, else multiple ^R don't work
	narrow-to-region -p "$LBUFFER${BUFFER:+>>}" -P "${BUFFER:+<<}$RBUFFER" -S state
	zle end-of-history
	zle history-incremental-pattern-search-backward
	narrow-to-region -R state
}
zle -N _history-incremental-preserving-pattern-search-backward
bindkey '^r' _history-incremental-preserving-pattern-search-backward
bindkey -M isearch '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward
