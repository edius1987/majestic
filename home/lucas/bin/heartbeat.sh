#!/bin/bash
#
# Source: http://askubuntu.com/a/721919
#

while :
do
    #if [[ ! -z $(pacmd list-sink-inputs | grep RUNNING) ]] ; then
	if [[ ! -z $(grep RUNNING /proc/asound/card0/pcm0p/sub0/status) ]] ; then
        #echo 'Audio is playing. Inhibiting screensaver'
        #nice -n 1 xdotool key shift ;
        xdotool key shift ;
    #else
        #echo 'No audio detected'
    fi
    #date +%T ## show some sign of life
    sleep 60
done
