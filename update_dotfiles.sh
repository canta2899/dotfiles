#!/bin/sh

# --- DIRECTORIES ----

if [ $(uname) != "Darwin" ]; then
    echo "On OSX realpath is not available. Compile extra/realpath.c."
    exit 1
fi;

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



# ---- SQLITE -------------

cp $HOME/.sqliterc $sqlite3_dir/.sqliterc 



# ---- TMUX ---------------

cp $HOME/.tmux.conf $tmux_dir/.tmux.conf



# --- NEOVIM ---------------

# Using both neovim and lunarvim
cp -r $HOME/.config/lvim/ $lvim_dir  # LunarVim
cp -r $HOME/.config/nvim/after $vim_dir/  # Neovim
cp -r $HOME/.config/nvim/init.vim $vim_dir/
cp -r $HOME/.config/nvim/snippets $vim_dir/



# --- ZSH ------------------

cp $HOME/.zshrc $zsh_dir/.zshrc
cp $HOME/.zprofile $zsh_dir/.zprofile



# --- SCRIPTS --------------

# Scripts are all kept in the script folder and eventually
# sourced or symlinked somewhere in the path
cp -r $HOME/development/scripts/ $scripts_dir



# --- EXTRA ----------------

cp $HOME/development/projects/realpath/realpath.c $extra_dir/
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


