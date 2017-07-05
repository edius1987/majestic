#!/bin/sh

dir="${HOME}/img/shots/"
data=$(date +%Y-%m-%d_%H-%M-%S)
nome="ss-${data}"
extensao=".png"
icone="/usr/share/icons/Arc/devices/24@2x/video-display.png"

if [ ! -d $dir ]; then
	mkdir -p $dir
fi

if [ "$1" == "-a" ]; then
	arquivo="${nome}-full${extensao}"
	scrot -m ${arquivo}
elif [ "$1" == "-w" ]; then
	arquivo="${nome}-window${extensao}"
	scrot -u -m ${arquivo}
else
	arquivo="${nome}-crop${extensao}"
	scrot -m ${arquivo}
	mogrify -crop 1920x1080+0+0 +repage ${arquivo}
fi

if [ $(pwd) != $dir ]; then
	mv $arquivo $dir
fi

notify-send -i $icone "ScreenShot" "A screenshot <b>$arquivo</b> foi salva em <b>$dir</b>..."

xclip -selection clipboard -t image/png -i $dir$nome
