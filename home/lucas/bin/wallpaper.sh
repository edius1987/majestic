#!/bin/bash
#
# wallpaper.sh - Programa para alterar o papel de parede.
# Funciona no i3, OpenBox e outros.
#
# Criador por Lucas Saliés Brum a.k.a. sistematico, <lucas at archlinux dot com dot br>
#
# Criado em: 17/06/2016 13:13:58
# Última alteração: 05/08/2017 01:07:53

. ${HOME}/bin/config.conf

if [ ! -d "$WALL" ]; then
	echo "O diretório $WALL não existe, abortando..."
	exit 1
fi

if [ "$1" ]; then

	if [ "$1" = "-day" ]; then
		feh --bg-fill \"$(shuf -n1 -e ${DIA_PATH}/$(date +\"%A\")*)\"
	elif [ "$1" = "-r" ]; then
		if [ -f "${HOME}/.wall" ]; then
			feh --bg-fill $(cat ${HOME}/.wall)
		else
			echo "O arquivo ${HOME}/.wall não existe."
			exit 1
		fi
	elif [ "$1" = "-d" ]; then
		if [ -f $DEFAULT ]; then
			WALLPAPER=$DEFAULT
		else
			echo "O wallpaper padrão $DEFAULT não existe..."
			exit 1
		fi
	elif [ "$1" = "-o" ]; then
		WALLPAPER=$(cat ${HOME}/.wall)
		viewnior $WALLPAPER
	elif [ "$1" = "-c" ]; then
		hsetroot -solid $COR
	elif [ "$1" != "-r" ] || [ "$1" != "-d" ] || [ "$1" != "-o" ] || [ "$1" != "-c" ] || [ -d "$1" ]; then
		if [ -d $1 ]; then
			WALLPAPER=$(find $1 -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \) | shuf -n1)
		elif [ -f $1 ]; then
			WALLPAPER=$1
		else
			echo "Imagem: $1 não identificada, abortando..."
			exit 1
		fi
	else
		WALL=$(echo $@ | tr ' ' '*')
		WALLPAPER=$(find $WALL -iname "*${WALL}*" | shuf -n1)
	fi
else
	WALLPAPER="$(find $WALL | shuf -n1)"
fi

if [ -f "$WALLPAPER" ]; then
	echo $WALLPAPER > ${HOME}/.wall
fi

if [ "$DESKTOP_SESSION" = "mate" ]; then
	gsettings set org.mate.background picture-filename "$WALLPAPER"
else
	feh --bg-fill "$WALLPAPER"
fi

exit 0
