#!/bin/bash

if ! pgrep -x xautolock > /dev/null; then
	/usr/bin/xautolock -time 5 -locker 'i3lock-fancy -t " " -n -p -g -- scrot -z' -detect
fi
