#!/bin/bash

# Opens a repository's origin in browser

url=$(git config --get remote.origin.url)
branch=$(git rev-parse --abbrev-ref HEAD)

if [[ "$url" == "" ]]; then
    echo "No remote found"
    exit 1
fi

if [[ $url =~ ^git\@.* ]]; then
    # ssh protocol
    source=$(printf '%s' "$url" | cut -d ':' -f 2)
    open "https://github.com/${source%.git}/tree/$branch"
elif [[ $url =~ ^https\.* ]]; then
    # http protocol
    open "${url%.git}/tree/$branch"
else
    # Unkown protocol
    echo "Unknown protocol"
fi

