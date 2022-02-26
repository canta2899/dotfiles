#!/bin/sh

# Opens a repository's origin in browser

url=$(git remote -v 2>/dev/null | grep "fetch" | grep -o 'https:\/\/.* ')
branch=$(git rev-parse --abbrev-ref HEAD)


if [[ $? -eq 0 ]]; then
    open "${url%.git }/tree/$branch"
else
    echo "Use this inside a repository that has a remote configured"
fi
