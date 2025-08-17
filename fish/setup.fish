#!/usr/bin/env fish

# figure out where this repo lives
set DOTFILES (realpath (dirname (status --current-filename)))
set CFG $HOME/.config/fish

mkdir -p $CFG/conf.d $CFG/functions

# symlinks
ln -sf $DOTFILES/conf.d/aliases.fish $CFG/conf.d/aliases.fish
ln -sf $DOTFILES/config.fish $CFG/config.fish

for f in $DOTFILES/functions/*.fish
    ln -sf $f $CFG/functions/(basename $f)
end

# fisher + plugins
if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
end

fisher install jorgebucaran/nvm.fish
fisher install jethrokuan/z
fisher install IlanCosman/tide@v6
