#!/bin/bash

destino=$(basename $(readlink -f ${HOME}/.config/polybar/i3))
cd ${HOME}/.config/polybar/

if [ ${destino} == "trans-clean.i3" ]; then
	s=""
	if [ $1 ]; then
		ln -sf trans.i3 i3
		~/.config/polybar/i3.sh
	fi
else
	s="%{F#d08770}%{F-}"
	if [ $1 ]; then
		ln -sf trans-clean.i3 i3
		~/.config/polybar/i3.sh
	fi	
fi

echo "${s}"