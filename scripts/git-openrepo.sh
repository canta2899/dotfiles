#!/bin/sh

# Opens a repository's origin in browser

url=$(git config --get remote.origin.url)
branch=$(git rev-parse --abbrev-ref HEAD)

if [[ $url == "" ]]; then
    echo "No remote found"
    exit 1
fi

if [[ $url =~ ^git\@.* ]]; then
    protocol="ssh"
elif [[ $url =~ ^https\.* ]]; then
    protocol="http"
else
    protocol="unkown"
fi

case "$protocol" in
    "ssh") 
        source=$(printf $url | cut -d ':' -f 2)
        open "https://github.com/${source%.git}/tree/$branch"
    ;;
    "http") 
        open "${url%.git}/tree/$branch"
    ;;
    *) echo "Unknown protocol" 
    ;;
esac





