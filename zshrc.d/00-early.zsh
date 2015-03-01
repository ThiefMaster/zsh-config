# vim: ts=4 sw=4
# Early commands running before any other files
# Use emacs mode. Vim is nice but not in a shell.
bindkey -e

# Create cache folder for compdump etc.
ZSH_CACHE="/tmp/.zsh-${USER}-${ZSH_VERSION}"
mkdir -p $ZSH_CACHE
chmod 700 $ZSH_CACHE
