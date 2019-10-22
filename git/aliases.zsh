# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# The rest of my fun git aliases
alias gl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'

# Remove `+` and `-` from start of diff lines; just rely upon color.
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gcb='git copy-branch-name'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias gac='git add -A && git commit -m'

# Push branch to upstream
function push(){
    branch=`git rev-parse --abbrev-ref HEAD`
    if [ $branch == 'master' ]; then
        echo "DO NOT PUSH TO MASTER"
    else
        git push origin $branch
    fi
}

# Create a PR through the GH Web UI
function pr(){
    remote=`git remote -v | grep origin | head -1 | awk '{print $2}' | sed 's/.*:\(.*\)*/\1/' | sed 's/\.git$//'`
    branch=`git rev-parse --abbrev-ref HEAD`
    open "https://github.com/$remote/compare/${1:-master}...$branch?expand=1"
}
