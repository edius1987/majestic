#!/bin/bash

inibe=0
apps=( "mpv" "Stremio-runtime" "Popcorn-Time" )
icone="/usr/share/icons/Faience/actions/64/gnome-lockscreen.png"

for app in ${apps[@]}
do
	if [[ $(pgrep $app) ]]; then
		inibe=1
	fi
done

if [ $inibe -eq 0 ]; then
	/usr/bin/xautolock -time 5 -locker 'i3lock-fancy -f Iosevka-Thin -t "Arch Linux" -p -- scrot -z' -detect -notify 30 -notifier "notify-send -i $icone --urgency=critical 'TRAVANDO a tela em 30 segundos'"
fi
