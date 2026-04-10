## User configuration
unsetopt nomatch

# -- VARIABLES --

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LANG="en_US.UTF-8"
source ~/.secrets

# -- ALIASES --

alias icloud='cd $CLOUDDOCS'

alias ls='logo-ls -Dh'

alias we="du -d 0 -h"

alias tn="tmux new-session -t"

alias tl='tmux ls'

alias t='tmux'

alias ta='tmux attach -t'

alias vim="nvim"

alias nc="netcat"

alias ii="open"

alias gdu="$HOME/go/bin/gdu"

alias sed="gsed"

alias date="gdate"

alias flushdnscache="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

alias sv="source .venv/bin/activate"

export EDITOR="nvim"

export DOTNET_ROOT="$HOME/.dotnet"
export DOTNET_TOOLS="$DOTNET_ROOT/tools"
export HOMEBREW_ROOT="/opt/homebrew/bin"
export LOCAL_BIN="$HOME/.local/bin"
export GO_BIN="$(go env GOPATH)/bin"
export LLAMA_PATH="$HOME/.llama"
PATH="$LOCAL_BIN:$LLAMA_PATH:$GO_BIN:$DOTNET_ROOT:$DOTNET_TOOLS:$HOMEBREW_ROOT:$PATH"

whatismyip(){
  curl https://api.ipify.org\?format\=text
  echo "\n"
}

md2slides(){
  if [[ $# -eq 1 ]]; then
    pandoc -s --webtex -i -t slidy "$1" -o "${1%.md}.html"
  else
    echo 'Usage: md2pdf markdown_document.md'
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

imgcat() {
  printf "\033]1337;File=inline=1:$(base64 -w 0 < $1)\007"
}

unquarantine() {
  xattr -rd com.apple.quarantine $1
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

