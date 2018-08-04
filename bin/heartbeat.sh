#!/usr/bin/env bash
#
# Source: http://askubuntu.com/a/721919
#

[ $(pidof -x $0) ] && echo rodando && exit

#for pid in $(pidof -x my_script.sh); do
#    if [ $pid != $$ ]; then
#        kill -9 $pid
#    fi
#done

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
