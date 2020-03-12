alias gs='git status'
alias gd='git diff --patience'
alias gdc='git diff --cached --patience'
alias grh='git reset HEAD'
alias grm='git rm'
alias gfu='git fetch upstream'
alias gcf='git commit --fixup'
alias grai='git rebase -i --autosquash'
alias branchgrep="git for-each-ref --sort='-*committerdate' --format=\"%(refname:short)\" refs/heads/ | grep"

bunshort() {
    $1 | $(npm bin)/bunyan -o short
}

alias pyserve='python -m SimpleHTTPServer'
alias py='python3'

alias viprofile="vim ~/.bash_profile"
alias vialias="vim ~/.bash_aliases"
alias vivi="vim ~/.vimrc"
alias vissh="vim ~/.ssh/config"
alias vigit="vim .git/config"

alias vi='vim'
alias rebootprofile="source ~/.bash_profile"

alias la='ls -al'

alias dkr='docker'
alias dc='docker-compose'

alias dkr-clean='docker ps -aq | xargs docker rm -f && docker images --filter="dangling=true" -q | xargs docker rmi'
alias dkr-blat='docker ps -aq | xargs docker rm -f && docker images -q | xargs docker rmi -f'

alias gpg2='gpg'

alias jup="pipenv run jupyter notebook"
 
# Activate nvm and use latest version of node
alias nod="source ~/.nvm/nvm.sh && nvm use v12.16.1"

alias sgit="searchGitAliases $1"
