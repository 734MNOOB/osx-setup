#!/usr/bin/env bash

source ~/.bash_env
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
export NVM_DIR="$HOME/.nvm" && . "/usr/local/opt/nvm/nvm.sh"
. $HOME/.bin/.symlink

# =============================================================================

# misc
alias ka="killall"
alias pa="ps -A"
alias la="ls -GFhal"
alias ls="ls -GFh"
alias profile="subl $HOME/.bash_profile"
alias src="source $HOME/.bash_profile && clear"
alias brew-head="brew update; brew upgrade; brew prune; brew cleanup; brew cask cleanup"
alias now="date \"+DATE: %Y%m%d%nTIME: %H:%M:%S\""
# git
alias ga="git add ."
alias gb="git branch -v"
alias gc="git commit -m"
alias gca="git commit --amend -m"
alias gex="git reset"
alias gco="git checkout"
alias gp="git pull"
alias gs="git status"
alias gr="git remote -v"
alias t="tig"
alias gsl="git stash list"
alias gh="github"
alias master="git checkout master"

# yarn
alias yb="yarn build"
alias yd="yarn develop"
alias yr="yarn rebuild"
alias nls="npm ls --depth=0"

# =============================================================================

dev() {
  if [[ $# == 0 ]]; then
    cd ~/dev
  elif [[ $1 == "notes" || $1 == "docs" ]]; then
    cd ~/dev/notes
  else
    cd ~/dev/*$1*
  fi
}

# =============================================================================

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export CLICOLOR=1
export LSCOLORS='GxFxCxDxBxegedabagaced'

# =============================================================================

git_branch() {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"
  if [[ $git_status =~ $on_branch ]];
    then local branch=${BASH_REMATCH[1]}
    echo "($branch) "
  elif [[ $git_status =~ $on_commit ]];
    then local commit=${BASH_REMATCH[1]}
    echo "($commit) "
  fi
}

git_color() {
  local git_status="$(git status 2> /dev/null)"
  if [[ ! $git_status =~ "working tree clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

# =============================================================================

COLOR_RED="\033[0;31m"      ; COLOR_RED_LIGHT="\033[1;31m"
COLOR_GREEN="\033[0;32m"    ; COLOR_GREEN_LIGHT="\033[1;32m"
COLOR_BLUE="\033[0;34m"     ; COLOR_BLUE_LIGHT="\033[1;34m"
COLOR_YELLOW="\033[0;33m"   ; COLOR_YELLOW_LIGHT="\033[1;33m"
COLOR_CYAN="\033[0;36m"     ; COLOR_CYAN_LIGHT="\033[1;36m"
COLOR_MAGENTA="\033[0;35m"  ; COLOR_MAGENTA_LIGHT="\033[1;35m"
COLOR_WHITE="\033[0;37m"    ; COLOR_WHITE_BOLD="\033[1;37m"
COLOR_BLACK="\033[0;30m"
COLOR_NORMAL="\e[22m"       ; COLOR_DIM="\e[2m"
COLOR_OCHRE="\033[38;5;95m" ; COLOR_RESET="\033[0m"

# =============================================================================

PS1="\n "
PS1+="\[$COLOR_RED_LIGHT\]\\$ "
PS1+="\[$COLOR_CYAN_LIGHT\]\w "
PS1+="\[\$(git_color)\]\$(git_branch)"
PS1+="\n "
PS1+="\[$COLOR_GREEN_LIGHT\]> "
PS1+="\[$COLOR_WHITE_BOLD\]"
export PS1

# trap "tput sgr0" DEBUG

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
