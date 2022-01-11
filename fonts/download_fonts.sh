#!/bin/sh

DIR_PATH=$(dirname $(realpath $0))
FONTS_DIR_NAME="Downloads"

mkdir -p $DIR_PATH/$FONTS_DIR_NAME

echo "Downloading fonts in $FONTS_DIR_NAME directory"

fonts=(
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip"
)

for file in ${fonts[*]}; do
    curl $file -o $DIR_PATH/$FONTS_DIR_NAME/$(basename $file)
done

echo "Fonts downloaded"
