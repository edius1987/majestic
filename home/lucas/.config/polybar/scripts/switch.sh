#!/bin/bash

destino=$(basename $(readlink -f ${HOME}/.config/polybar/principal))
cd ${HOME}/.config/polybar/

if [ ${destino} == "clean" ]; then
	s=""
	if [ $1 ]; then
		ln -sf full principal
		~/.config/polybar/launch.sh
	fi
else
	s="%{F#d08770}%{F-}"
	if [ $1 ]; then
		ln -sf clean principal
		~/.config/polybar/launch.sh
	fi
fi

echo "${s}"
