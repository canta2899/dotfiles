#!/bin/sh

if [[ $# -lt 1 ]]; then
    echo "Please provide a download link"
    exit 1
fi

FILENAME=$(basename $1)

curl $1 -Lo $FILENAME

