#!/usr/bin/env fish

# figure out where this repo lives
set DOTFILES (realpath (dirname (status --current-filename)))
set CFG $HOME/.config/fish

mkdir -p $CFG/conf.d $CFG/functions

# symlinks
ln -sf $DOTFILES/conf.d/aliases.fish $CFG/conf.d/aliases.fish
ln -sf $DOTFILES/config.fish $CFG/config.fish
ln -sf $DOTFILES/conf.d/abbreviations.fish $CFG/conf.d/abbreviations.fish

for f in $DOTFILES/functions/*.fish
    ln -sf $f $CFG/functions/(basename $f)
end

# fisher + plugins
if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
end

set -l wanted_plugins jorgebucaran/nvm.fish jethrokuan/z ilancosman/tide@v6
set -l installed (fisher list)

for p in $wanted_plugins
    if not contains -- $p $installed
        fisher install $p
    end
end
