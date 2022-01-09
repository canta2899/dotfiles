#!/bin/sh

# Rewords a git commit in order to change commit mnessage 

REV=$1
MESSAGE=$2
FILTER="test $(echo '$GIT_COMMIT') = $(git rev-parse $REV) && echo $MESSAGE || cat"
git filter-branch --msg-filter "$FILTER" -- --all
