#!/bin/bash

# Opens a repository's origin in browser

url=$(git config --get remote.origin.url)
branch=$(git rev-parse --abbrev-ref HEAD)
service="github"

if [[ "$url" == "" ]]; then
    echo "No remote found"
    exit 1
fi

remote=$(printf '%s' "$url" | cut -d ':' -f 1)

if [[ $remote =~ ^.*gitlab.* ]]; then
  service="gitlab"
fi;


# remote=$(printf '%s' "$(git config --get remote.origin.url)" | cut -d ':' -f 1)

if [[ $url =~ ^git\@.* ]]; then
    # ssh protocol
    source=$(printf '%s' "$url" | cut -d ':' -f 2)
    open "https://${service}.com/${source%.git}/tree/$branch"
elif [[ $url =~ ^https\.* ]]; then
    # http protocol
    open "${url%.git}/tree/$branch"
else
    # Unkown protocol
    echo "Unknown protocol"
fi

