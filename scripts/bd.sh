#!/bin/sh

# https://github.com/vigneshwaranr/bd

# The MIT License (MIT)
# 
# Copyright (c) 2013 Vigneshwaran Raveendran
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

_bd() {
    _help_msg () {
      printf "Usage: bd [OPTION]... [PATTERN]\n"
      printf "Quickly go back to a specific parent directory in bash.\n\n"

      printf "\e[1mOPTIONS\e[0m\n"
      printf "  %-28s %s\n" "-s" "PATTERN can match part of directory name"
      printf "  %-28s %s\n" "-si" "PATTERN is Case Insensitve and can be partial"
      printf "  %-28s %s\n" "-?, --help" "Display this message"

      printf "\n\e[1mALTERNATE USAGE EXAMPLES\e[0m\n"
      printf "  %-28s %s\n" "\`bd -si som\`/script.sh" "Execute \"script.sh\" in matching path"

      return 0
    }


    _newpwd() {
      oldpwd=$1
      case "$2" in
        -s)
          pattern=$3
          NEWPWD=$(echo $oldpwd | sed 's|\(.*/'$pattern'[^/]*/\).*|\1|')
          ;;
        -si)
          pattern=$3
          NEWPWD=$(echo $oldpwd | perl -pe 's|(.*/'$pattern'[^/]*/).*|$1|i')
          ;;
        -?|--help)
          help_msg
          ;;
        *)
          pattern=$2
          NEWPWD=$(echo $oldpwd | sed 's|\(.*/'$pattern'/\).*|\1|')
      esac
    }

    if [ $# -eq 0 ] || [ "${@: -1}" = -v ]; 
    then
      _help_msg
    else
      oldpwd=$(pwd)

      _newpwd "$oldpwd" "$@"
      
      if [ "$NEWPWD" = "$oldpwd" ]
      then
        echo "No such occurrence."
      else
        echo $NEWPWD
        cd "$NEWPWD"
      fi
      unset NEWPWD
    fi
}

alias bd='_bd 2>&1'

