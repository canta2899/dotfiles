#!/bin/sh

# +-------------------------------------------------
# + A simple shell script made in order to talk		
# + to the philips hue api and perform simple tasks 
# + 												
# +	- hue on		[turns on the lights]			
# + - hue off 		[turns off the lights]			
# + - hue bri 		[sets the brightness]			
# + - hue scenes    [set a new scene]               
# + 												
# + Made by canta2899         						
# +-------------------------------------------------


# command | awk '{print substr($0,1,8);exit}' 

_set_group_state() {
    echo "http://$HUE_IP/api/$HUE/groups/$1/action"
}

_get_group_state() {
    echo "http://$HUE_IP/api/$HUE/groups/$1/"
}

_set_light_state() {
    echo "http://$HUE_IP/api/$HUE/lights/$1/state"
}

_get_scenes() {
    echo "http://$HUE_IP/api/$HUE/scenes"
}

if [[ $# -eq 0 ]]; then
    echo "Usage:"
    echo -e "- hue on  \t[turns your lights on]"
    echo -e "- hue off \t[turns your lights off]"
    echo -e "- bri [%] \t[sets brightness level]"
    echo -e "- scenes  \t[choose the current scene]"
    exit 0;
fi

HUE_GROUP=0
HUE_LIGHT=""
VALUE=""

# Parses arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -g|--group)
            HUE_GROUP=$2
            shift > /dev/null 2>&1
            ;;
        -v|--value)
            VALUE=$2
            shift > /dev/null 2>&1
            shift > /dev/null 2>&1
            ;;
        -l|--light)
            HUE_LIGHT=$2
            shift > /dev/null 2>&1
            shift > /dev/null 2>&1
            ;;
        bri)
            CMD="bri"
            VALUE=$2
            shift > /dev/null 2>&1
            shift > /dev/null 2>&1
            ;;
        *)
            CMD=$1
            shift > /dev/null 2>&1
            ;;
    esac
done

if [ $CMD = "on" ]; then
    [ -n "$HUE_LIGHT" ] && uri=$(_set_light_state $HUE_LIGHT) ||
        uri=$(_set_group_state $HUE_GROUP)

    curl -X PUT -d '{"on": true}' $uri -s > /dev/null
    exit 0
fi

if [ $CMD = "off" ]; then
    [ -n "$HUE_LIGHT" ] && uri=$(_set_light_state $HUE_LIGHT) || 
        uri=$(_set_group_state $HUE_GROUP)
    
    curl -X PUT -d '{"on": false}' $uri -s > /dev/null
    exit 0
fi

if [ $CMD = "bri" ]; then

    ! [ -n "$VALUE" ] && echo "Unknwown value" && exit 1;

    [ -n "$HUE_LIGHT" ] && uri=$(_set_light_state $HUE_LIGHT) ||
        uri=$(_set_group_state $HUE_GROUP)

    brightness=$(($VALUE * 255 / 100))
    
    [ $brightness -gt 255 ] && brightness=255

    curl -X PUT -d '{"bri": '$brightness'}' $uri -s > /dev/null 
    exit 0
fi

if [ $CMD = "scenes" ]; then
    uri=$(_get_scenes)
    scenes=`curl -s -X GET $uri | jq 'keys[] as $k | .[$k] | {name: .name, key: $k}'`
    number_re='^[0-9]+$'

    names=( $(echo "$scenes" | jq '.name' | sed -e 's/ /_/g') )
    ids=( $(echo "$scenes" | jq '.key') )

    echo -e "0 - Do Nothing"
    for ((i=1; i < ${#names[@]}; i++))
    do
        echo -e "$i - ${names[i]}"
    done

    echo -en "\n> "

    read choice

    if ! [[ $choice =~ $number_re ]] || [ $choice -ge $i ]; then
        echo "Invalid number"
        exit 1
    fi

    uri=$(_set_group_state $HUE_GROUP)
    curl -X PUT -s -d'{"scene": '"${ids[$choice]}"'}' $uri > /dev/null
    exit 0;
fi

echo "Unknown command"
exit 1

