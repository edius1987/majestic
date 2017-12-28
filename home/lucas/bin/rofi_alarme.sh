#!/bin/sh
#
# Script de alarme usando o paplay, dunst e rofi.
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 28/12/17 00:52:08
# Última Atualização: 28/12/17 00:52:16
# Evaluate: ! date +"%d/%m/%y %H:%M:%S"

dependencias=("rofi" "notify-send" "paplay")

for dep in ${dependencias[@]} 
do
	which $dep 1> /dev/null 2> /dev/null
	if [ $? != 0 ]; then
		echo
		echo "O aplicativo $dep não foi encontrado."
		echo "Abortando..."
		echo
		exit 1
	fi
done

data=$(date +%Y-%m-%d_%H-%M-%S)
nome="ss-${data}"
extensao=".png"
atraso=10
icone="/usr/share/icons/Arc/devices/24@2x/video-display.png"
tema="~/.local/share/rofi/themes/sistematico-dark.rasi"
tipo="image/png"

if [ ! -d $dir ]; then
	mkdir -p $dir
fi

hora=$(rofi -theme "$tema" -dmenu -p "Formato: HH:MM (c para cancelar!):" -bw 0 -lines 0 -separator-style none -location 0 -width 10 -hide-scrollbar -padding 5)
date "+%H:%M" -d "$hora" > /dev/null 2>&1

if [ $hora ]; then
	if [ "$hora" == [cC] ]; then
		killall -9 $(basename $0)
		msg="Alarme Cancelado!"
	else
		if [ $? != 0 ]; then
			msg="Hora inválida!\n\nFormato: (HH:MM)"
		else
			notify-send -i $icone "Rofi Alarme" "O alarme irá tocar as:\n\n$(date --date=${hora})"
			sleep $(( $(date --date="$hora" +%s) - $(date +%s) ));
			notify-send -i $icone "Rofi Alarme" "ACORDA!!!"
			while true; do
	  			/usr/bin/mpg123 ~/alarm.mp3
	  			sleep 60
			done
			
			msg="Alarme ajustado para:\n\n${hora}"
		fi
	fi

	notify-send -i $icone "Rofi Alarme" "$msg"
fi