# vim: ts=4 sw=4
# Changing Directories
unsetopt	AUTO_CD
setopt		AUTO_PUSHD
unsetopt	CDABLE_VARS
unsetopt	CHASE_DOTS
unsetopt	CHASE_LINKS
setopt		PUSHD_IGNORE_DUPS
setopt		PUSHD_MINUS
setopt		PUSHD_SILENT
unsetopt	PUSHD_TO_HOME

# Completion
setopt		ALWAYS_LAST_PROMPT
# XXX setopt		ALWAYS_TO_END
setopt		AUTO_LIST
setopt		AUTO_MENU
setopt		AUTO_NAME_DIRS
setopt		AUTO_PARAM_KEYS
setopt		AUTO_PARAM_SLASH
unsetopt	AUTO_REMOVE_SLASH
unsetopt	BASH_AUTO_LIST
unsetopt	COMPLETE_ALIASES
setopt		COMPLETE_IN_WORD
unsetopt	GLOB_COMPLETE  # XXX not sure what's better...
setopt		HASH_LIST_ALL
setopt		LIST_AMBIGUOUS
unsetopt	LIST_BEEP
setopt		LIST_PACKED
setopt		LIST_ROWS_FIRST
setopt		LIST_TYPES
unsetopt	MENU_COMPLETE
unsetopt	REC_EXACT

# Expansion & Globbing
setopt		BAD_PATTERN
setopt		BARE_GLOB_QUAL
setopt		BRACE_CCL
setopt		CASE_GLOB
setopt		CASE_MATCH
unsetopt	CSH_NULL_GLOB
setopt		EQUALS
setopt		EXTENDED_GLOB
setopt		GLOB
unsetopt	GLOB_ASSIGN
unsetopt	GLOB_DOTS
unsetopt	GLOB_SUBST
unsetopt	HIST_SUBST_PATTERN
unsetopt	IGNORE_BRACES
unsetopt	KSH_GLOB
setopt		MAGIC_EQUAL_SUBST
setopt		MARK_DIRS
setopt		MULTIBYTE
setopt		NOMATCH
unsetopt	NULL_GLOB
setopt		NUMERIC_GLOB_SORT
setopt		RC_EXPAND_PARAM
setopt		REMATCH_PCRE
unsetopt	SH_GLOB
setopt		UNSET
setopt		WARN_CREATE_GLOBAL

# History
setopt		APPEND_HISTORY
setopt		BANG_HIST
setopt		EXTENDED_HISTORY
unsetopt	HIST_ALLOW_CLOBBER
unsetopt	HIST_BEEP
setopt		HIST_EXPIRE_DUPS_FIRST
setopt		HIST_FCNTL_LOCK
setopt		HIST_FIND_NO_DUPS
unsetopt	HIST_IGNORE_ALL_DUPS
setopt		HIST_IGNORE_DUPS
setopt		HIST_IGNORE_SPACE
setopt		HIST_NO_FUNCTIONS
setopt		HIST_NO_STORE
setopt		HIST_REDUCE_BLANKS
setopt		HIST_SAVE_BY_COPY
unsetopt	HIST_SAVE_NO_DUPS
setopt		HIST_VERIFY
setopt		INC_APPEND_HISTORY
setopt		SHARE_HISTORY

# I/O
setopt		ALIASES
unsetopt	CLOBBER
setopt		CORRECT
unsetopt	CORRECT_ALL
unsetopt	DVORAK
unsetopt	FLOWCONTROL
unsetopt	IGNORE_EOF
setopt		INTERACTIVE_COMMENTS
setopt		HASH_CMDS
setopt		HASH_DIRS
unsetopt	MAIL_WARNING
unsetopt	PATH_DIRS
unsetopt	PRINT_EIGHT_BIT
unsetopt	PRINT_EXIT_VALUE
setopt		RC_QUOTES
unsetopt	RM_STAR_SILENT
unsetopt	RM_STAR_WAIT
setopt		SHORT_LOOPS
unsetopt	SUN_KEYBOARD_HACK

# Job Control
setopt		AUTO_CONTINUE
unsetopt	AUTO_RESUME
setopt		BG_NICE
setopt		CHECK_JOBS
setopt		HUP
setopt		LONG_LIST_JOBS
setopt		MONITOR
setopt		NOTIFY

# Prompt
unsetopt	PROMPT_BANG
setopt		PROMPT_CR
setopt		PROMPT_SP
setopt		PROMPT_PERCENT
setopt		PROMPT_SUBST
setopt		TRANSIENT_RPROMPT

# Scripts & Functions
setopt		C_BASES
unsetopt 	C_PRECEDENCES
unsetopt	DEBUG_BEFORE_CMD
unsetopt	ERR_EXIT
unsetopt	ERR_RETURN
setopt		EVAL_LINENO
setopt		EXEC
setopt		FUNCTION_ARGZERO
setopt		LOCAL_OPTIONS
setopt		LOCAL_TRAPS
setopt		MULTIOS
unsetopt	OCTAL_ZEROES
unsetopt	TYPESET_SILENT
unsetopt	VERBOSE
unsetopt	XTRACE

# Shell Emulation
unsetopt	BASH_REMATCH
unsetopt	BSD_ECHO
unsetopt	CSH_JUNKIE_HISTORY
unsetopt	CSH_JUNKIE_LOOPS
unsetopt	CSH_JUNKIE_QUOTES
unsetopt	CSH_NULLCMD
unsetopt	KSH_ARRAYS
unsetopt	KSH_AUTOLOAD
unsetopt	KSH_OPTION_PRINT
unsetopt	KSH_TYPESET
unsetopt	KSH_ZERO_SUBSCRIPT
unsetopt	POSIX_ALIASES
unsetopt	POSIX_BUILTINS
unsetopt	POSIX_IDENTIFIERS
unsetopt	SH_FILE_EXPANSION
unsetopt	SH_NULLCMD
unsetopt	SH_OPTION_LETTERS
unsetopt	SH_WORD_SPLIT
unsetopt	TRAPS_ASYNC

# ZLE
setopt		BEEP
unsetopt	COMBINING_CHARS
setopt		EMACS
unsetopt	OVERSTRIKE
unsetopt	SINGLE_LINE_ZLE
unsetopt	VI
setopt		ZLE
