## User configuration

# -- ALIASES --

alias icloud="cd /Users/andrea/Library/Mobile\ Documents/com~apple~CloudDocs"

alias mysql="/usr/local/mysql/bin/mysql"

alias runmongod="mongod --config /usr/local/etc/mongod.conf --fork"

alias ztc="zerotier-cli"

alias ls='logo-ls'

alias lsg='logo-ls -D'

alias lsort="logo-ls | sort -n"

alias lsortg="logo-ls -D | sort -n"

alias tn="tmux new-session -t"

alias tl='tmux ls'

alias t='tmux'

alias ta='tmux attach -t'

alias vim="lvim"

# Just in case the original /bin/ls is needed
alias binls="/bin/ls"

. $HOME/development/scripts/hue.sh


# -- PATH -- 

# Sourcing local
PATH="$HOME/.local/bin:$PATH"
#sbin
PATH="/usr/local/sbin:$PATH"
# PostgreSQL
PATH="$PATH:/Applications/Postgres.app/Contents/Versions/13/bin"
# Yarn
PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# Python
PATH="/usr/local/opt/python/libexec/bin:${PATH}"
# Ruby
PATH="/usr/local/opt/ruby/bin:$PATH"
# Tex
PATH="/usr/local/texlive/2021/bin/universal-darwin:$PATH"
# Homebrew Php
PATH="/usr/local/opt/php@7.4/bin:$PATH"
PATH="/usr/local/opt/php@7.4/sbin:$PATH"
PATH="/usr/local/opt/httpd/bin:$PATH"
# Flutter
PATH="/Users/andrea/development/flutter/bin:$PATH"
# Global node 
PATH="$HOME/.npm-global/bin:$PATH"

export PATH


# -- VARIABLES --

source ~/.secrets

export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

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
	else
		echo "No environment activated"
	fi
}

# Wrapper around spleeter to split an audio file in vocals iso + backing track
# Usage: "split [path_to_audio_file]"

split(){
	if [[ $# -eq 1 ]]; then
		filename=$(basename $1)
		filename_noext=`echo $filename | grep -o "^.*[^\.]{"`
		cp $1 ~/development/repos/spleeter/
		(
			cd ~/development/repos/spleeter
			conda activate spleeter
			spleeter separate -p spleeter:2stems -o output $filename
			conda deactivate
			open ~/development/repos/spleeter/output/
		)
		mv ~/development/repos/spleeter/$filename ~/development/repos/spleeter/output/$filename_noext/$filename
	else
		echo "Usage: split audio_file.mp3"
		echo "Result: opens a folder with audio splitted in backing_track and vocals isolated"
	fi
}

# Builds a "notes" directory template (with makefile) ready to take markdown notes

makenotesenv(){
	if [ -d "notes" ]; 
	then
  		echo "notes directory already exists"
		return 1
	fi
	mkdir -p notes
	cat $HOME/.notes_makefile > ./notes/Makefile
	mkdir -p notes/img
	mkdir -p notes/pdfs
}

whatismyip(){
	curl https://api.ipify.org\?format\=text
	echo "\n"
}

# Opens a repository's origin in browser

openrepo() {
	url=`git remote -v 2>/dev/null | grep "fetch" | grep -o 'https:\/\/.* '`
	if [[ $? -eq 0 ]]; then
		open ${url% }
	else
		echo "Use this inside a GitHub connected repository"
	fi
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

