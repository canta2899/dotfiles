#!/bin/bash

get_protocol() {
  local url="$1"

  if [ -z "$url" ]; then
    echo "Error: No remote found" >&2
    return 1
  fi

  if [[ $url =~ ^(ssh://)?git@ ]]; then
    echo -n "ssh"
    return 0
  elif [[ $url =~ ^https:// ]]; then
    echo -n "http"
    return 0
  else
    echo "Error: Unknown protocol" >&2
    return 1
  fi
}

openrepo() {
  url=$(echo -n "https://$1/tree/$2")
  open $url
}

ORIGIN_URL=$(git config --get remote.origin.url)
ORIGIN_BRANCH=$(git rev-parse --abbrev-ref HEAD)
protocol=$(get_protocol "$ORIGIN_URL")

if [ "$protocol" = "ssh" ]; then
  source=$(printf '%s' "$ORIGIN_URL" | sed -r 's/^ssh:\/\///' | sed -r 's/^git@//' | sed -r "s/:[0-9]*\/?/\//" | sed -r 's/\.git$//')
  openrepo $source $ORIGIN_BRANCH
elif [ "$protocol" = "http" ]; then
  source=$(printf '%s' "$ORIGIN_URL" | sed -r 's/^https:\/\///' | sed -r 's/\.git$//' | sed -r "s/:[0-9]+\//\//")
  openrepo $source $ORIGIN_BRANCH
else
  echo "Nothing to do"
  exit 1
fi
