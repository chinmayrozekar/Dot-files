#export MGC_HOME='/wv/cal_nightly_TOT/2025.03.19.calibreube.wednesday/ic/ic_superproj/aok/Mgc_home'
export DESIGN_DIR='/user/pev/qa/data_dir'
export CVSROOT=':pserver:wvcalcvs:/wv/pevtools/cvsroot'
export SGE_ROOT='/wv/calgrid/sge'
export SKIP_OS_CHECKS=yes
#export CAL_OPTIONS="-turbo -hyper"

export TEST_SUITE_TOP='/wv/lvs_aut/master_perc_tot/calibre'

alias clrcalenv='unset ${!CALIBRE_*}; unset CAL_OPTIONS' # remove all CALIBRE envs

# System Report
#/wv/chiroz51/toolbox/sys_report

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

export TOOLBOX='/wv/chiroz51/toolbox'


# function to copy contents of a file directly to clipboard
copyfile() {
    cat "$1" | xclip -selection clipboard
}

alias clearclip='echo -n "" | xclip -selection clipboard'

# Calibre specific Aliases:

source /user/pete/bin/pe_aliases.sh   
source /home/chiroz51/.calibre_aliases_bash
source /wv/chiroz51/toolbox/setmgc.sh
source $TEST_SUITE_TOP/perc/utils/lib/include.lib

tot

alias nedit='/user/hanguyen/bin/nedit -rows 60 -columns 90'
# Chinmay custom Aliases:

alias tclsh="rlwrap tclsh"
alias n='nautilus . &> /dev/null & disown'
alias nobackup='cd /wv/chiroz51_nobackup'
alias tickets='cd /wv/chiroz51/tickets'
alias mu='nvim /wv/chiroz51/tickets/Moustafa_updates'
alias whatos='lsb_release -idr' # INFO: Lists OS distributor ID, description, and release
alias whichmgc='echo $MGC_HOME'
alias la='ls'
alias lsa='ls -lrtha'
alias chiroz='cd /wv/chiroz51'
alias toolbox='cd /wv/chiroz51/toolbox'
alias myoshimo='cd /wv/myoshimo'
alias hanguyen='cd /wv/hanguyen'
alias ibrbin2r='cd /wv/ibrbin2r '
alias master_tot='cd /wv/perc_aut2/master_perc_tot'
alias master_large='pd /wv/perc_aut2/master_perc_tot/calibre/perc/large'
alias master_topo='pd /wv/perc_aut2/master_perc_tot/calibre/perc/topo'
alias master_topo_feature='pd /wv/perc_aut2/master_perc_tot/calibre/perc/topo/topo/feature'
alias master_3DIC='pd /wv/perc_aut2/master_perc_tot/calibre/perc/topo/3DIC'
alias master_LDL='pd /wv/perc_aut2/master_perc_tot/calibre/perc/LDL'
alias master_p2p='pd /wv/perc_aut2/master_perc_tot/calibre/perc/LDL/p2p'
alias master_cd='pd /wv/perc_aut2/master_perc_tot/calibre/perc/LDL/cd'
alias restart_vnc='
/usr/bin/vncserver -kill :1 && \
/usr/bin/vncserver :1 -geometry 1920x1080 -depth 24 -alwaysshared -AcceptCutText=1 -SendCutText=1 -listen tcp
'
alias perc_lib="nvim /wv/lvs_aut/master_perc_tot/calibre/perc/utils/lib/perc.lib"
alias cal_version="$MGC_HOME/bin/calibre -version"
alias cheatsheets="cd /wv/chiroz51/misc/cheatsheets"
alias cheatsheet_masa="nvim /home/myoshimo/myCheatSheet.txt"
alias mycheatsheet="nvim /wv/chiroz51/misc/cheatsheets/cheatSheetChinmay.txt"
alias wl="vim /wv/chiroz51/misc/cheatsheets/vimwiki/workLog.md"
alias misc="cd /wv/chiroz51/misc"
alias del_CVS="find . -type d -name "CVS" -exec rm -rf {} \;"
alias cim="nvim"
alias rp='realpath'


# switch branches:
swb() {
    new_branch=$1
    current_path=$(pwd)
    base_path="/wv/perc_aut2/master_perc_"
    
    # Extract current branch
    current_branch=$(echo $current_path | grep -o "master_perc_[^/]*")
    current_branch=${current_branch#master_perc_}
    
    # Create new path
    new_path=${current_path/master_perc_$current_branch/master_perc_$new_branch}
    
    cd $new_path
}



# rc files
alias bashrc="vim ~/.bashrc"
alias sbashrc="source ~/.bashrc"
alias vimrc="vim ~/.vimrc"
alias svimrc="source ~/.vimrc"
alias tmuxconf="gvim ~/.tmux.conf"
alias stmuxconf="source ~/.tmux.conf"

# Joplin
alias joplin="/wv/chiroz51/misc/Joplin-3.1.24.AppImage"

# Taskwarrior
export PATH=$HOME/.local/bin:$PATH
alias tasks="task"
alias taskrc="nvim ~/.taskrc"
alias staskrc="source ~/.taskrc"
alias t="task list"
#alias ta="task add $1"
alias ta="task active"
alias tan="task $1 annotate $2"
alias report="task burndown.daily"
alias tui="taskwarrior-tui"

# JIRA

alias mywork='jira list --template list --query "(assignee = chiroz51 OR \"QA Owner\" = chiroz51) AND project in (PERC, PERC_AMY) AND status not in (closed, released, done) ORDER BY fixVersion DESC"'

alias mywork-simple='jira list --template simple --query "(assignee = chiroz51 OR \"QA Owner\" = chiroz51) AND project in (PERC, PERC_AMY) AND status not in (closed, released, done)"'


function taskTag(){
        task $1 modify +$2
}

alias tt=taskTag
alias tclw="task end.after:today-1wk completed"

function taskPriority(){
    task $1 modify priority:$2
}


alias tp=taskPriority
#export PATH=$PATH:/home/chiroz51/pandoc/pandoc-3.5/bin
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

# pushd and popd

alias pd="pushd"
alias dirs="dirs -v"

# PERC EXECUTION RELATED:
alias r1="./cleanup_output;./setup_tst;./dofile"
alias r2="./setup_tst;./dofile;./compare"



# find and remove all cvs directories from my testcase

alias f_cvs="find . -type d -name 'CVS'"
alias rm_cvs="find . -type d -name "CVS" -exec rm -r {} +"

#------------- TEMPORARY DEL LATER---------------#

my_commands() {
    cp curr_ew baseline/
    cp qaout.perc.rep baseline/
    cp qaout.cell_list baseline/
    cp qaout.log baseline/
}


#------------- CVS related commands---------------#

cm() {
  cvs ci -m "chiroz51: updated $1" "$1"
}

## commit all files to regression

cma() {
    for i in $(cm_status | awk '{print $1}'); do cm $i; done
}
#  ---------   2025 ------------------------------#
cal_1() {
    cvs up -r cal2025_1
}

cal_2() {
    cvs up -r cal2025_2
}

cal_3() {
    cvs up -r cal2025_3
}

cal_4() {
    cvs up -r cal2025_4
}
cvsa() {
    cvs up -A
}




. "$HOME/.cargo/env"
export PATH=~/taskwarrior_local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
#export PS1="\[\033[01;34m\]\[\033[01;32m\] λ \[\033[00m\]"
#export PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\W\[\e[0m\]\$ '

# Taskwarrior Git Sync Aliases
alias task-save='cd ~/.task && git add . && git commit -am "update: $(date +%Y-%m-%d_%H:%M)" && git push && cd -'
alias task-sync='cd ~/.task && git pull --rebase && cd -'
export PATH="$HOME/bin:$PATH"


#LogSeq
alias logseq=/home/chiroz51/appimages/Logseq-linux-x64-0.9.4.AppImage


# ---------------- https://calconfluence.wv.mentorg.com/display/BIG/Using+modernized+Unix+CLI+tools ----------------------------------------#
#source /user/caldevtools/bin/load-devtools.sh

#export DEVTOOLS

# Add this to your ~/.bashrc

# Load devtools
. /user/caldevtools/bin/load-devtools.sh

# Enhanced command aliases (after tools are loaded)
#if command -v bat &> /dev/null; then
#    alias cat='bat --paging=never'
#fi

    
#if command -v eza &> /dev/null; then
#    alias ls='eza'                # Just list files
#    alias ll='eza -l'            # Long format
#    alias la='eza -la'           # Long format including hidden files
#    alias lt='eza --tree'        # Tree view
#    alias lm='eza -l --sort=modified'  # Sort by modified date
#    alias lsize='eza -l --sort=size'   # Sort by size
#    alias lsa='eza -lah --group --total-size --sort=modified'
#fi


# alias vim="nvim"

if command -v btop &> /dev/null; then
    alias top='btop'
fi


# Set up fzf if available
if command -v fzf &> /dev/null; then
    # CTRL-T - Paste the selected file path(s) into the command line
    # CTRL-R - Paste the selected command from history into the command line
    # ALT-C - cd into the selected directory
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
fi

# Set up zoxide (smart cd command) if available
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
    alias cd='z'
fi

# Set up starship prompt if available
#if command -v starship &> /dev/null; then
#    eval "$(starship init bash)"
#fi

# Ensure UTF-8 locale for proper character rendering
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Silence devtools warnings if desired
# export SILENCE_DEVTOOLS_WARNINGS=1


# perctest user login related:
alias perclogin="~/bin/perclogin.exp"


# -------------------------------------------------------
# Testcase Checkins to use with checkin script
# Test Case Functions
check_test() {
    if [ -z "$1" ]; then
        echo "Usage: check_test <test_name>"
        return 1
    fi
    $TOOLBOX/checkin_perc_testcase.py -t "$1" 
#    $TOOLBOX/checkin_script/dist/perc_checkin_testcase -t "$1"

}

checkin_test() {
    if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
        echo "Usage: checkin_test <test_name> <branch_path> <branches> <comment>"
        echo "Example: checkin_test dr1356268_mtk_issue topo/voltage/feature 'tot,2019_4' 'your comment'"
        return 1
    fi
    $TOOLBOX/checkin_perc_testcase.py -t "$1" -s -r "$2" -b "$3" -cm "$4"
#    $TOOLBOX/checkin_script/dist/perc_checkin_testcase -t "$1" -s -r "$2" -b "$3" -cm "$4"
}

# Test Suite Functions
check_suite() {
    if [ -z "$1" ]; then
        echo "Usage: check_suite <suite_name>"
        return 1
    fi
    $TOOLBOX/checkin_perc_testcase.py -p "$1"
}

checkin_suite() {
    if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
        echo "Usage: checkin_suite <suite_name> <branch_path> <branch> <comment>"
        echo "Example: checkin_suite dr1356268_mtk_issue topo/voltage/feature tot 'your comment'"
        return 1
    fi
    $TOOLBOX/checkin_perc_testcase.py -p "$1" -s -r "$2" -b "$3" -cm "$4"
}


mars_import() {
    # Show help if no args
    if [ -z "$1" ]; then
        echo "Usage: mi <branch> [testpath]"
        echo "Examples:"
        echo "  mi 2025_3 topo/voltage/tests/my_test"
        echo "  mi 2025_3    # full branch"
        echo "  mi tot       # ToT branch"
        return 1
    fi

    local branch=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    local base="/wv/perc_aut2/master_perc_"
    local path="${base}${branch}/calibre/perc"
    
    # Handle ToT vs numbered branch
    [ "$branch" = "tot" ] && branch="TOT" || branch="cal${1}"
    
    /user/pete/bin/mars_testcat import_tree \
        --branch "$branch" \
        --treeroot "$path" \
        "${path}/${2:-}" \
        --team perc
}

alias ct='check_test'
alias cit='checkin_test'
alias cs='check_suite'
alias cis='checkin_suite'
alias mi='mars_import'


# This line shuld always be at the end
export PATH=$(echo "$PATH" | awk -v RS=: -v ORS=: '!seen[$0]++' | sed 's/:$//')
