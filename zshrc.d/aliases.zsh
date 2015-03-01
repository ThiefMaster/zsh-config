# vim: ts=4 sw=4
GREP_OPTS='--color=auto --exclude-dir={.git,.hg,.svn}'
alias grep="grep $GREP_OPTS"
alias egrep="egrep $GREP_OPTS"
alias fgrep="fgrep $GREP_OPTS"
unset GREP_OPTS

alias ..='cd ..'
alias ...='cd ../..'

alias l='ls -l'
alias ll='ls -al'
alias ls='ls --color=auto'

type hub > /dev/null && alias git='hub'
alias dmesg='dmesg --color --reltime'

alias alf='autoload -Uz'
