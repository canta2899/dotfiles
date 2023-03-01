## User configuration

unsetopt nomatch

# -- VARIABLES --

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export LANG="en_US.UTF-8"
source ~/.secrets

# -- ALIASES --

alias icloud='cd $CLOUDDOCS'

alias ztc="zerotier-cli"

alias ls='logo-ls -D'

alias we="du -d 0 -h"

alias tn="tmux new-session -t"

alias tl='tmux ls'

alias t='tmux'

alias ta='tmux attach -t'

alias vim="nvim"

alias nc="netcat"

alias ii="open"

alias startvnc="/Applications/RealVNC/VNC\ Server.app/Contents/MacOS/vncserver_service"

alias vncserver="/Library/vnc/vncserver"

alias gdu="$HOME/go/bin/gdu"

alias sed="gsed"

alias date="gdate"

alias gouni='tmux new-window -n uni -c $UNIPATH'

alias flushdnscache="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say 'get flushed'"

# -- PATH -- 

# Sourcing local
PATH="$HOME/.local/bin:$PATH"
#sbin
PATH="/usr/local/sbin:$PATH"
# Yarn
PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
# Python
PATH="/usr/local/opt/python/libexec/bin:${PATH}"
# Ruby
PATH="/usr/local/opt/ruby/bin:$PATH"
# Tex
PATH="/usr/local/texlive/2021/bin/universal-darwin:$PATH"
# Psql
PATH="/usr/local/opt/libpq/bin:$PATH"
# Homebrew Php
PATH="/usr/local/opt/php/bin:$PATH"
PATH="/usr/local/opt/php/sbin:$PATH"
# Apache
PATH="/usr/local/opt/httpd/bin:$PATH"
# Flutter
PATH="$PATH:$HOME/development/flutter/bin"
# Global node 
PATH="$HOME/.npm-global/bin:$PATH"
# Cargo
PATH="$HOME/.cargo/bin:$PATH"
# Go
PATH="$PATH:$HOME/go/bin"
# Coq (because older coq is needed for exercises)
PATH="/Applications/CoqIDE_8.13.1.app/Contents/Resources/bin:$PATH"
export PATH


export EDITOR="code"

# -- FUNCTIONS --

# Quick wrapper to activate and deactivate python virtual environments
# Usage consists of "envon [path_to_env folder]" and "deactivate"
# And then "envoff" to deactivate the current environment if activated

envon(){
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  ORANGE='\033[1;33m'
  if [[ $# -eq 1 ]]; then
    current_path="${1}/bin/activate"
    source ${current_path} 2>/dev/null
    if [[ $? -eq 0 ]]; then
      echo "${GREEN}Python env activated.\nUse \"envoff\" to deactivate the environment"
    else
      echo "${RED}An error occoured. Does $current_path exist?" 
    fi
  else
    echo "${ORANGE}Please provide a valid path.\nEx. envon /my/path"
  fi
}

envoff(){
  deactivate > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Environment deactivated"
    return 0
  else
    echo "No environment activated"
    return 1
  fi
}

whatismyip(){
  curl https://api.ipify.org\?format\=text
  echo "\n"
}

md2pdf(){
  if [[ $# -eq 1 ]]; then
    pandoc -f markdown -t latex "$1" -o "${1%.md}.tex" -s --number-sections && pdflatex "${1%.md}.tex" && rm "${1%.md}.tex" "${1%.md}.aux" "${1%.md}.log"
  else
    echo 'Usage: md2tex input.md'
  fi
}

md2slides(){
  if [[ $# -eq 1 ]]; then
    # pandoc -t beamer "$1" -o "${1%.md}.pdf"
    pandoc -s --webtex -i -t slidy "$1" -o "${1%.md}.html"
  else
    echo 'Usage: md2pdf markdown_document.md'
  fi
}


makepdf(){
  # osascript -e 'display notification "'$out'" with title "Makepdf"'
  if [[ $# -eq 1 ]]; then
    pandoc -f markdown-implicit_figures --number-sections $1 -o "${1%.md}.pdf"
  else
    echo "Usage: makepdf [/path/to/markdown]"
  fi
}    

b64url(){
  read content
  printf $content | tr -d '\n' | base64 | tr '/+' '_-' | tr -d '='
}

