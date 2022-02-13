#!/bin/sh

# Opens a repository's origin in browser

url=$(git remote -v 2>/dev/null | grep "fetch" | grep -o 'https:\/\/.* ')
branch=$(git rev-parse --abbrev-ref HEAD)


if [[ $? -eq 0 ]]; then
    base_url=${url%.git }
    final_url="$base_url/tree/$branch"
    open $final_url
else
    echo "Use this inside a repository that has a remote configured"
fi
