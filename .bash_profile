source ~/.nvm/nvm.sh
nvm use v8.9.2

# Use rbenv
eval "$(rbenv init -)"

# Don't clear screen from manpage after quit
export MANPAGER="less -X";

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

export HISTTIMEFORMAT="%F %T "

# Add keys to keychain
ssh-add -A

# GPG
export GPG=gpg2

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

if [ -f ~/.git-prompt.sh ]; then
    . ~/.git-prompt.sh
fi

function checkoutgrep() {  head -"$@" | tail -1 | xargs git checkout ; }

function xco(){ git checkout `branchgrep $1 | head -n1`;  }

function forkclone() {
  git clone git@github.com:larister/$1.git;
  cd $1;
  git remote add upstream git@github.com:BrandwatchLtd/$1.git;
}

# Set up prompt
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLACK="\[\033[0;30m\]"
WHITE="\[\033[0;37m\]"

GIT_PS1_SHOWDIRTYSTATE=true
PS1="$RED\$(date +%H:%M) \W$YELLOW \$(__git_ps1 '(%s)')$WHITE \$ "

export PATH=~/bin:/usr/local/sbin:$PATH
export PATH=~/scripts:$PATH
export PATH="$PATH:`yarn global bin`"

export MARKPATH=$HOME/.marks
function leap { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

# Short fn for isolating frontend analytics pids; pipe to xargs kill
function frontendPs {
    ps aux | grep "[n]ode [worker|server]" | tr -s " " | cut -d " " -f 2
}

export COMPOSE_HTTP_TIMEOUT=10000

# added by Miniconda 3.7.0 installer
export PATH="/Users/alastair/miniconda/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/alastair/google-cloud-sdk/path.bash.inc' ]; then source '/Users/alastair/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/alastair/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/alastair/google-cloud-sdk/completion.bash.inc'; fi

# Use Python 3 by default (relies on conda being installed, and a 3_6 environment)
source activate 3_6
