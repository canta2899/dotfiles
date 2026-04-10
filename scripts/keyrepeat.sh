#!/bin/sh

INTERVAL_MS=2
INITIAL_MS=10
defaults write -g ApplePressAndHoldEnabled -bool true
defaults write NSGlobalDomain KeyRepeat -int $INTERVAL_MS
defaults write NSGlobalDomain InitialKeyRepeat -int $INTERVAL_MS
