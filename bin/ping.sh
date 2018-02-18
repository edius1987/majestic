#!/bin/bash

#host="127.0.0.1"
host=${2:-"8.8.8.8"}
retries=${3:-1}

function pingar {
	ping -q -c$retries $host > /dev/null 2> /dev/null
	if [ $? -eq 0 ]; then
		echo -e "Conexão: \033[0;32mOK\033[0m"
	else
		echo -e "Conexão: \033[0;31mFALHOU\033[0m"
	fi
}

if [ "$1" == "-u" ]; then
	while true; do
		pingar
		sleep 3
	done
else
	pingar
fi
