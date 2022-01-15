# Quick function that wraps the cd ../ command
_b(){
  re='^[0-9]+$'
  if [[ $# -eq 1 ]] ; then
    if [[ $1 =~ $re ]]; then
      for i in {1..$1}
      do
        cd ../
      done
    else
      echo "Specify the amount of steps you wanna get back"
    fi
  else
    cd ../
  fi
}

alias b='_b'
