#!/bin/bash

killall -9 -q polybar
sleep 1
killall -9 -q polybar

while pgrep -x polybar > /dev/null; do
	killall -9 -q polybar
	sleep 1
done

polybar -c ~/.config/polybar/config.galdino bottom -q &
polybar -c ~/.config/polybar/config.galdino top -q &

