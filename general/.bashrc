# # if not running interactively, don't do anything
[[ $- == *i* ]] || return

# history options
shopt -s histappend # append to the history file, don't overwrite it
HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with a space in the history
HISTTIMEFORMAT="[%F %T] "

# undocumented feature which sets the size to "unlimited"
# see http://stackoverflow.com/questions/9457233/unlimited-bash-history
HISTFILESIZE=
HISTSIZE=

# change the file location because certain bash sessions truncate .bash_history file upon close
# see http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
HISTFILE=~/.bash_eternal_history

# need to research this more
# sourcing .bashrc multiple times causes 'history -a' to repeat several times in $PROMPT_COMMAND, and I don't exactly understand what this is doing
# https://tldp.org/LDP/abs/html/sample-bashrc.html suggests PROMPT_COMMAND="history -a"
#PROMPT_COMMAND="history -a; $PROMPT_COMMAND" # force prompt to write history after every command; see http://superuser.com/questions/20900/bash-history-loss

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# match all files and zero or more directories and subdirectories when the pattern "**" is used in a pathname expansion context
shopt -s globstar

# color prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi

# if this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*) PS1="\[\e]0;\u@\h: \w\a\]$PS1";;
esac

# enable color support of grep and ls commands
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -la --color=auto'
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Chinmay custom Aliases:

alias tclsh="rlwrap tclsh"
alias n='nautilus . &> /dev/null & disown'
alias whatos='lsb_release -idr' # INFO: Lists OS distributor ID, description, and release
alias la='ls'
alias lsa='ls -lrtha'


# rc files
alias bashrc="vim ~/.bashrc"
alias sbashrc="source ~/.bashrc"
alias vimrc="vim ~/.vimrc"
alias svimrc="source ~/.vimrc"
alias tmuxconf="gvim ~/.tmux.conf"
alias stmuxconf="source ~/.tmux.conf"

# This line shuld always be at the end
export PATH=$(echo "$PATH" | awk -v RS=: -v ORS=: '!seen[$0]++' | sed 's/:$//')
