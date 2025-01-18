export MGC_HOME='/wv/cal_nightly_TOT/2024.12.09.calibreube.monday/ic/ic_superproj/aok/Mgc_home'
export DESIGN_DIR='/user/pev/qa/data_dir'
export CVSROOT=':pserver:wvcalcvs:/wv/pevtools/cvsroot'
export SGE_ROOT='/wv/calgrid/sge'
export SKIP_OS_CHECKS=yes
export CAL_OPTIONS="-turbo -hyper"

export TEST_SUITE_TOP='/wv/lvs_aut/master_perc_tot/calibre'



# Licensing Environment
. /user/pete/bin/env_init.sh
lserver set

if [ -e /home/$USER/.aliases ]; then
    source /home/$USER/.aliases
fi

if [ -e /wv/calgrid/sge/default/common/settings.csh ]; then
    source /wv/calgrid/sge/default/common/settings.sh
fi

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

eval `/user/pete/lib/lserver_manager/lic_server_info set -sh --tools calibre,corp`

# functions (comment in as desired)
# pool() { gridq -l "g=*${1}*" ; } # INFO: Displays the grid hosts whose group name contain the first argument

# aliases (comment in as desired)
# alias ll='ls -alh --color' # INFO: Recommended, makes ls display more information in more readable color
# alias maint='filemaint get -t users -f' # INFO: Displays the linux users who maintain the file (eg. maint path_to/file.txt)
# alias maintg='filemaint get -t groups -f' # INFO: Displays the linux groups that maintain the file (eg. maintg path_to/file.txt)
# alias mv='mv -i' # INFO: Asks for confirmation before overwriting a file with mv
# alias whatos='lsb_release -idr' # INFO: Lists OS distributor ID, description, and release

# # enable programmable completion features (you don't need to enable
# # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# # sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi



# Calibre specific Aliases:

source /user/pete/bin/pe_aliases.sh   
source /home/chiroz51/.calibre_aliases_bash
alias nedit='/user/hanguyen/bin/nedit -rows 60 -columns 90'
# Chinmay custom Aliases:

alias nobackup='cd /wv/chiroz51_nobackup'
alias whatos='lsb_release -idr' # INFO: Lists OS distributor ID, description, and release
alias lsa='ls -lrtha'
alias chiroz='cd /wv/chiroz51'
alias master='cd /wv/perc_aut2/master_perc_tot'
alias restart_vnc='
/usr/bin/vncserver -kill :1 && \
/usr/bin/vncserver :1 -geometry 1920x1080 -depth 24 -alwaysshared -AcceptCutText=1 -SendCutText=1 -listen tcp
'
alias cheatsheets="cd /wv/chiroz51/misc/cheatsheets"
alias misc="cd /wv/chiroz51/misc"

# rc files
alias bashrc="vim ~/.bashrc"
alias sbashrc="source ~/.bashrc"
alias vimrc="vim ~/.vimrc"
alias svimrc="source ~/.vimrc"
alias tmuxconf="vim ~/.tmux.conf"
alias stmuxconf="source ~/.tmux.conf"

# Joplin
alias joplin="/wv/chiroz51/misc/Joplin-3.1.24.AppImage"

# Taskwarrior
export PATH=$HOME/.local/bin:$PATH
alias tasks="task"
alias t="task list"
alias ta="tasj add $1"
alias report="task burndown.daily"

function taskTag(){
        task $1 modify +$2
}

alias tt=taskTag
alias tclw="task end.after:today-1wk completed"

function taskPriority(){
    task $1 modify priority:$2
}


alias tp=taskPriority
export PATH=$PATH:/home/chiroz51/pandoc/pandoc-3.5/bin

# Countdown timers and stopwatch

## Usage:
# countdown 60                     --> 60 sec countdown timer
# countdown "$((2 * 60 * 60))"     --> Countdown 2 hours
# stopwatch                        --> starts a stopwatch



countdown() {
    start="$(( $(date '+%s') + $1))"
    while [ $start -ge $(date +%s) ]; do
        time="$(( $start - $(date +%s) ))"
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

stopwatch() {
    start=$(date +%s)
    while true; do
        time="$(( $(date +%s) - $start))"
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}


