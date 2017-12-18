#!/bin/bash

DISPLAY=:0 caja -n
#dbus-launch dconf write /org/mate/desktop/background/show-desktop-icons false
#sleep 3
dbus-launch dconf write /org/mate/desktop/background/show-desktop-icons true
#sleep 3
#DISPLAY=:0 caja -q

exit 0
#sleep 1
#dconf write /org/mate/desktop/background/show-desktop-icons false
#sleep 1
#dconf write /org/mate/desktop/background/show-desktop-icons true
#sleep 1
#DISPLAY=:0 caja -q &
