#!/usr/bin/env bash

# ls /usr/share/sounds/freedesktop/stereo/
online=""
offline=""

#h="127.0.0.1"
#h=${4:-"8.8.8.8"}
#r=${3:-1}

h="8.8.8.8"
r=1
v=0
l=0

function pingar {
	ping -q -c$r $h > /dev/null 2> /dev/null
	if [ $? -eq 0 ]; then
		if [ "$v" == 1 ]; then
			#echo -e "Conexão: \033[0;32mOK\033[0m"
			echo -e "\033[0;32monline\033[0m"
		fi
		export DISPLAY=:0 ; canberra-gtk-play -i phone-incoming-call 2>&1
	else
		if [ "$v" == 1 ]; then
			#echo -e "Conexão: \033[0;31mFALHOU\033[0m"
			echo -e "\033[0;31moffline\033[0m"
		fi
	fi
}

if [ $l = 1 ]; then
	while true; do
		pingar
		sleep 3
	done
else
	pingar
fi
