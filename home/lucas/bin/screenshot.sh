#!/bin/sh

dir="${HOME}/img/shots/"
data=$(date +%Y-%m-%d_%H-%M-%S)
nome="ss-${data}.png"

if [ "$1" == "-a" ]; then
	scrot -m $nome
elif [ "$1" == "-w" ]; then
	scrot -u -m $nome
else
	scrot -m $nome
	mogrify -crop 1920x1080+0+0 +repage $nome
fi

if [ $(pwd) != $dir ]; then
	mv $nome $dir
fi

xclip -selection clipboard -t image/png -i $dir$nome
