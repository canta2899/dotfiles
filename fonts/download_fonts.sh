#!/bin/sh

DIR_PATH=$(dirname $(realpath $0))
FONTS_DIR_NAME="downloaded_fonts"

mkdir -p $DIR_PATH/$FONTS_DIR_NAME

fonts=(
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip"
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip"
)

for file in ${fonts[*]}; do
    wget $file -O $DIR_PATH/$FONTS_DIR_NAME/$(basename $file)
done

echo "Fonts downloaded"
