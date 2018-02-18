#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do
	killall -9 -q polybar
	sleep 1;
done

if [ ! -L ${HOME}/.config/polybar/principal ]; then
	ln -s ${HOME}/.config/polybar/clean ${HOME}/.config/polybar/principal
fi

tamanho=$(cat ${HOME}/.config/polybar/config | wc -l)

if [ "$tamanho" -lt 30 ]; then
	cat ${HOME}/.config/polybar/cores/branco > ${HOME}/.config/polybar/config
	cat ${HOME}/.config/polybar/clean >> ${HOME}/.config/polybar/config
fi

# Launch bar1 and bar2
polybar bottom -q &
polybar top -q &


