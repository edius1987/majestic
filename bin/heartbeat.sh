#!/bin/bash
#
# Source: http://askubuntu.com/a/721919
#

while :
do
    if [[ ! -z $(pacmd list-sink-inputs | grep RUNNING) ]] ; then
	#if [[ ! -z $(grep RUNNING /proc/asound/card0/pcm0p/sub0/status) ]] ; then
        xdotool key shift ;
    fi
    
    #if [[ ! -z $(grep RUNNING /proc/asound/card1/pcm7p/sub0/status) ]] ; then    
    #    xdotool key shift ;
    #fi
    
    sleep 60
done
