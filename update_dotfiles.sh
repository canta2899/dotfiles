#!/bin/sh

DIR_PATH=$(dirname $(realpath $0))

# Add new folders here

sqlite3_dir=$DIR_PATH/sqlite3 
tmux_dir=$DIR_PATH/tmux 
vim_dir=$DIR_PATH/nvim
zsh_dir=$DIR_PATH/zsh
extra_dir=$DIR_PATH/extra 
lvim_dir=$DIR_PATH/lvim
scripts_dir=$DIR_PATH/scripts

mkdir -p $sqlite3_dir $tmux_dir $vim_dir $zsh_dir $extra_dir $lvim_dir $scripts_dir

# Sqlite3
cp ~/.sqliterc $sqlite3_dir/.sqliterc

# Tmux
cp ~/.tmux.conf $tmux_dir/.tmux.conf

# Using both neovim and lunarvim

# Lunar vim 

cp -r ~/.config/lvim/ $lvim_dir

# nvim
cp ~/.config/nvim/init.vim $vim_dir/init.vim
cp -r ~/.config/nvim/after $vim_dir/
cp -r ~/.config/nvim/snippets $vim_dir/

# zsh dotfiles

cp ~/.zshrc $zsh_dir/.zshrc
cp ~/.zprofile $zsh_dir/.zprofile

cp -r $HOME/development/scripts/ $scripts_dir

# EXTRA
cp ~/.notes_makefile $extra_dir/
cp ~/development/projects/realpath/realpath.c $extra_dir/
cp $HOME/development/projects/endianess_c/endianess.c $extra_dir/

# Performs eventual git commit 

echo "All files updated. Would you like to commit your changes? (y/n)"
read ans

case $ans in
  y|Y|yes)
    git init . > /dev/null
    git add $DIR_PATH/.gitignore > /dev/null
    git add $DIR_PATH/* > /dev/null
    printf "Your commit message: "
    read commit_message
    git commit -m"$commit_message" 
    ;;
  *) 
    echo "Skipping commit"
    ;;
esac


