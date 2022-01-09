#!/bin/sh


chars="/-\|"

sleep 2 &

while kill -0 $! > /dev/null 2>&1; 
do
  for (( i=0; i<${#chars}; i++ )); do
    sleep 0.5
    printf "\r"
    printf "${chars:$i:1}"
  done
done

printf "\n"
