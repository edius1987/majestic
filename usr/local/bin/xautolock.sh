#!/bin/bash
icone="/usr/share/icons/Faience/actions/64/gnome-lockscreen.png"
#/usr/bin/xautolock -time 5 -locker 'i3lock-fancy -n -f Iosevka-Thin -t "Arch Linux" -p -- scrot -z' -detect -notify 30 -notifier "notify-send -i $icone --urgency=critical 'TRAVANDO a tela em 30 segundos'"

[ ! $(pgrep xautolock) ]; /usr/bin/xautolock -time 5 -locker 'i3lock-fancy -t "" -n -p -g -- scrot -z' -detect
