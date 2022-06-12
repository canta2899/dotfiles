#!/bin/sh

DIR_PATH=$(dirname $(realpath $0))

# -- SETTINGS --------------
cp $HOME/Library/Application\ Support/Code/User/settings.json $DIR_PATH
cp -r $HOME/Library/Application\ Support/Code/User/snippets/ $DIR_PATH
cp $HOME/Library/Application\ Support/Code/User/keybindings.json $DIR_PATH

