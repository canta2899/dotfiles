#!/usr/bin/env bash
# Symlinks this folder's zsh config into place.
#
# ~/.zshenv is always sourced first by zsh and sets ZDOTDIR to
# ~/.config/zsh, so .zshenv lives directly in $HOME while .zprofile and
# .zshrc live inside ZDOTDIR.

set -euo pipefail

DOTFILES_ZSH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZDOTDIR="$HOME/.config/zsh"

mkdir -p "$ZDOTDIR"

ln -sfv "$DOTFILES_ZSH_DIR/zshenv" "$HOME/.zshenv"
ln -sfv "$DOTFILES_ZSH_DIR/zprofile" "$ZDOTDIR/.zprofile"
ln -sfv "$DOTFILES_ZSH_DIR/zshrc" "$ZDOTDIR/.zshrc"
