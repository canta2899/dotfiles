## User configuration

unsetopt nomatch

# -- ALIASES --

alias icloud="cd /Users/andrea/Library/Mobile\ Documents/com~apple~CloudDocs"

alias mysql="/usr/local/mysql/bin/mysql"

alias runmongod="mongod --config /usr/local/etc/mongod.conf --fork"

alias ztc="zerotier-cli"

alias ls='logo-ls'

alias lg='logo-ls -D'

alias lsort="logo-ls | sort -n"

alias lsortg="logo-ls -D | sort -n"

alias tn="tmux new-session -t"

alias tl='tmux ls'

alias t='tmux'

alias ta='tmux attach -t'

alias vim="lvim"

alias nc="netcat"

alias lss="/bin/ls"

alias s="open"

alias lz="lazygit"

. $HOME/development/scripts/hue.sh


# -- PATH -- 

# Sourcing local
PATH="$HOME/.local/bin:$PATH"
#sbin
PATH="/usr/local/sbin:$PATH"
# PostgreSQL
PATH="$PATH:/Applications/Postgres.app/Contents/Versions/13/bin"
# Yarn
PATH="$PATH:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
# Python
PATH="/usr/local/opt/python/libexec/bin:${PATH}"
# Ruby
PATH="/usr/local/opt/ruby/bin:$PATH"
# Tex
PATH="/usr/local/texlive/2021/bin/universal-darwin:$PATH"
# Homebrew Php
PATH="/usr/local/opt/php/bin:$PATH"
PATH="/usr/local/opt/php/sbin:$PATH"
# Apache
PATH="/usr/local/opt/httpd/bin:$PATH"
# Flutter
PATH="$PATH:$HOME/development/flutter/bin"
# Global node 
PATH="$HOME/.npm-global/bin:$PATH"
# Go
PATH="$PATH:$HOME/go/bin"
export PATH

# -- VARIABLES --

source ~/.secrets

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export LANG="en_US.UTF-8"

# -- FUNCTIONS --

# Returns human readable weight of file/directory calculated recursively

we(){
    if [[ $# -eq 1 ]] then
        du -d 0 -h $1
    else
        echo "Specific a path to a file"
    fi
}

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

safetoken(){
    
    # copies github token on copy buffer or clears the buffer
    # the token in sourced as an environment variable
    if [ "$1" = "clear" ]; then
        echo "" | pbcopy
        return 0
    fi

    echo $GH | pbcopy
    echo "Token copied, use \"safetoken clear\" to remove"
    return 0
}

