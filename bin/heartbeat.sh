#!/usr/bin/env bash
#
# Source: http://askubuntu.com/a/721919
#

interval=30
lock="/tmp/heartbeat.lck"
[ -f $lock ] && rm -f $lock && exit

for pid in $(pidof -x $0); do
    if [ $pid != $$ ]; then
        kill -9 $pid
		echo "Já existe uma instancia."
    fi
done

echo $$ > $lock

while :
do
	# grep RUNNING /proc/asound/card0/pcm0p/sub0/status
    if [[ ! -z $(pacmd list-sink-inputs | grep RUNNING) ]] ; then
        xdotool key shift ;
    else
		break
	fi

    sleep $interval
done

exit 0
