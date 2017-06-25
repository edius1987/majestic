#!/bin/sh

TIMESTAMP=$(date +"%T")
#CRONTMP="/tmp/crontab-${TIMESTAMP}"
#crontab -l -u $USER > ${CRONTMP}

ccroncommand () {
	if [ $(cat $CRONTMP | grep 'wallpaper') ]; then
		echo "Já existe um cron, alterando..."
		sed -i "/wallpaper/c\1 * * * * export DISPLAY=:0 ; /home/lucas/bin/wallpaper.sh $WALLPAPER #wallpaper" ${CRONTMP}
	else
		echo "Adicionando trabalho ao crontab..."
		echo "1 * * * * export DISPLAY=:0 ; /home/lucas/bin/wallpaper.sh $wall #wallpaper" >> ${CRONTMP}
	fi

	if [ $wall ]; then
		echo "Alterando o crontab..."
		crontab -u $USER ${CRONTMP}
	else
		echo "Cron inalterado..."
	fi
}


if [ "$1" ]; then
	if [ "$1" = "-d" ]; then
		#sed -i '/wallpaper/d' ${CRONTMP}
		WALLPAPER="/usr/share/backgrounds/default"
	elif [ "$1" = "-o" ]; then
		WALLPAPER=$(cat ${HOME}/.wall)
		viewnior $(cat ${HOME}/.wall)
	else
		WALL=$(echo $@ | tr ' ' '*')
		WALLPAPER=$(find /usr/share/backgrounds/modelos -iname "*${WALL}*" | shuf -n1)
	fi
else
	WALLPAPER="$(find /usr/share/backgrounds/modelos | shuf -n1)"
fi

#ccroncommand( $WALLPAPER )
echo $WALLPAPER > ${HOME}/.wall

if [ "$DESKTOP_SESSION" = "mate" ]; then
	gsettings set org.mate.background picture-filename "$WALLPAPER"
else
	feh --bg-fill "$WALLPAPER"
fi

exit 0
