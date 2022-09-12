# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bash_profile.pre.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.pre.bash"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm use 12

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Use rbenv - move to aliases?
# eval "$(rbenv init -)"

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

export EDITOR=vim

# Add keys to keychain
ssh-add --apple-load-keychain

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

# Spark doesn't work with Java 10, so fix our java version to 1.8
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home

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
export PATH=~/dotfiles/scripts:$PATH
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

# This really slows things down :-/
# eval "$(pipenv --completion)"

export COMPOSE_HTTP_TIMEOUT=10000

# Add spark to path
export PATH="/Users/alastair/code/spark-2.2.0-bin-custom-spark/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/alastair/google-cloud-sdk/path.bash.inc' ]; then source '/Users/alastair/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/alastair/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/alastair/google-cloud-sdk/completion.bash.inc'; fi



export PIP_REQUIRE_VIRTUALENV=true

# ICU stuff
export LDFLAGS="-L/usr/local/opt/icu4c/lib"
export CPPFLAGS="-I/usr/local/opt/icu4c/include"

# Load scm_breeze
[ -s "/Users/alastair/.scm_breeze/scm_breeze.sh" ] && source "/Users/alastair/.scm_breeze/scm_breeze.sh"

# So many damn shortcuts in scm_breeze, quickly find what's available (see aliases for quick version)
function searchGitAliases {
    git_aliases | ag "$1"
}
eval "$(/opt/homebrew/bin/brew shellenv)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bash_profile.post.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.post.bash"
