#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do
	killall -9 -q polybar
	sleep 1;
done

#polybar -c ~/.config/polybar/bspwm top -q &
#polybar -c ~/.config/polybar/nord nord -q &
#polybar -c ~/.config/polybar/gamehelp top -q &
polybar top -q &
