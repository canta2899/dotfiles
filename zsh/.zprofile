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

alias ls='logo-ls -Dh'

alias we="du -d 0 -h"

alias tn="tmux new-session -t"

alias tl='tmux ls'

alias t='tmux'

alias ta='tmux attach -t'

alias vim="nvim"

alias v="nvim"

alias nc="netcat"

alias ii="open"

alias gdu="$HOME/go/bin/gdu"

alias sed="gsed"

alias date="gdate"

alias flushdnscache="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

# -- PATH -- 

# Sourcing local
PATH="$HOME/.local/bin:$PATH"
#sbin
PATH="/usr/local/sbin:$PATH"
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
# Cargo
PATH="$HOME/.cargo/bin:$PATH"
# Go
PATH="$PATH:$HOME/go/bin"
# Ghcup
PATH="$HOME/.ghcup/bin:$PATH"
export PATH

export EDITOR="nvim"

# -- FUNCTIONS --

# Quick wrapper to activate and deactivate python virtual environments
# Usage consists of "envon [path_to_env folder]" and "deactivate"
# And then "envoff" to deactivate the current environment if activated

pyenvon(){
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

pyenvoff(){
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


topdf() {
  if [[ $# -eq 1 ]]; then
    pandoc -o "${1%.md}.pdf" $1 --template eisvogel
  else
    echo 'Usage: topdf markdown_document.md'
  fi
}

batstatus() {
  echo "$(ioreg -l | awk '$3~/Capacity/{c[$3]=$5}END{OFMT="%.3f";max=c["\"MaxCapacity\""];print(max>0?100*c["\"CurrentCapacity\""]/max:"?")}')"
}

makecert() {
    openssl req -x509 -nodes -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 365
}
