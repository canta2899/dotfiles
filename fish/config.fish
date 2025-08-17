set -x CLICOLOR 1
set -x LSCOLORS GxFxCxDxBxegedabagaced
set -x LANG en_US.UTF-8
set -x EDITOR nvim

fish_add_path --path $HOME/.local/bin
fish_add_path --path /usr/local/sbin
fish_add_path --path /usr/local/opt/python/libexec/bin
fish_add_path --path /usr/local/opt/ruby/bin
fish_add_path --path /usr/local/texlive/2021/bin/universal-darwin
fish_add_path --path /usr/local/opt/libpq/bin
fish_add_path --path /usr/local/opt/php/bin /usr/local/opt/php/sbin
fish_add_path --path /usr/local/opt/httpd/bin
fish_add_path --path $HOME/.cargo/bin
fish_add_path --path $HOME/go/bin
fish_add_path --path $HOME/.ghcup/bin

test -f ~/.secrets.fish; and source ~/.secrets.fish
