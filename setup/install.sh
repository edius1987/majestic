#!/bin/bash

[ "$EUID" -eq 0 ] && echo "É necessário rodar o script como usuário normal, não como root." && exit 1

read -p "ATENÇÃO!!! Esse script irá apagar configurações prévias do i3 e da Polybar!!! Deseja continuar? [s/N]: " confirma

if [[ -z $confirma ]] || [[ $confirma != [sS]* ]]; then
	exit 0
fi

app_ok=1
apps=("i3-gaps" "polybar" "dunst" "xdotool" "ttf-fira-sans" "adobe-source-code-pro-fonts" "jsoncpp" "rofi")

for app in ${apps[@]}; do
	pacman -Q $app 1> /dev/null 2> /dev/null
	if [ $? = 1 ]; then
		echo "$app não instalado. Instale primeiro."
		app_ok=0
	fi
done
[ "$app_ok" -eq 0 ] && echo "Existem dependências, programa abortado." && exit 1

# i3-gaps
[ ! -d ${HOME}/.config/i3 ] && mkdir -p ${HOME}/.config/i3

echo "Instalando as configs do i3..."
curl -s -o ${HOME}/.config/i3/config 'https://raw.githubusercontent.com/sistematico/majestic/master/.config/i3/config'

# PolyBar
[ ! -d ${HOME}/.config/polybar ] && mkdir -p ${HOME}/.config/polybar

echo "Instalando as configs da polybar..."
curl -s -o ${HOME}/.config/polybar/launch.sh 'https://raw.githubusercontent.com/sistematico/majestic/master/.config/polybar/launch.sh'
chmod +x ${HOME}/.config/polybar/launch.sh
curl -s -o ${HOME}/.config/polybar/config "https://raw.githubusercontent.com/sistematico/majestic/master/.config/polybar/config"

# Polybar Scripts
[ ! -d ${HOME}/.config/polybar/scripts ] &&	mkdir -p ${HOME}/.config/polybar/scripts

scripts=("anews.py" "btc.sh" "crypto.py" "janela.sh" "logs.sh" "pkg.sh" "strcut.py" "trash.sh" "weather.py" "clock.sh" "moonphase.py" "wallpaper.sh" "beats.sh" "calendar.sh" "cpu.sh" "mem.sh" "ufw.sh")
gmail=("auth.py"  "client_secrets.json"  "credentials.json"  "launch.py"  "preview.png"  "readme.md")

for script in ${scripts[@]}; do
	curl -s -o ${HOME}/.config/polybar/scripts/${script} "https://raw.githubusercontent.com/sistematico/majestic/master/.config/polybar/scripts/${script}"
done

[ ! -d ${HOME}/.config/polybar/scripts/gmail ] && mkdir -p ${HOME}/.config/polybar/scripts/gmail

for gm in ${gmail[@]}; do
	curl -s -o ${HOME}/.config/polybar/scripts/gmail/${gm} "https://raw.githubusercontent.com/sistematico/majestic/master/.config/polybar/scripts/gmail/${gm}"
done

# Scripts auxiliares
[ ! -d ${HOME}/.local/bin ] && mkdir -p ${HOME}/.local/bin

localbinscripts=("beats.sh" "lockscreen" "lockscreen.firefox" "lockscreen.quotes" "lockscreen.simple" "notification.sh" "otf2ttf.ff" "screencast" "screenshot" "steam-launcher" "xautolock")
for localbinscript in ${localbinscripts[@]}; do
	curl -s -o ${HOME}/.local/bin/${localbinscript} "https://raw.githubusercontent.com/sistematico/majestic/master/.local/bin/${localbinscript}"
done

# dunst
[ ! -d ${HOME}/.config/dunst ] && mkdir -p ${HOME}/.config/dunst
curl -s -o ${HOME}/.config/dunst/dunstrc 'https://raw.githubusercontent.com/sistematico/majestic/master/.config/dunst/dunstrc'

# rofi
if [ -d ${HOME}/.config/rofi ]; then
	if [ -d ${HOME}/.config/rofi/scripts ]; then
		mv ${HOME}/.config/rofi/scripts ${HOME}/.config/rofi/scripts-${backup_date}
	else
		mkdir -p ${HOME}/.config/rofi/scripts
	fi

	if [ -f ${HOME}/.config/rofi/config.rasi ]; then
		mv ${HOME}/.config/rofi/config.rasi ${HOME}/.config/rofi/config-${backup_date}.rasi.bkp
	fi
else
	mkdir -p ${HOME}/.config/rofi/scripts
fi

[ ! -d ${HOME}/.local/share/rofi/themes/ ] && mkdir -p ${HOME}/.local/share/rofi/themes/

curl -s -o ${HOME}/.config/rofi/config.rasi 'https://raw.githubusercontent.com/sistematico/majestic/master/.config/rofi/config.rasi'
curl -s -o ${HOME}/.local/share/rofi/themes/lateral.rasi 'https://raw.githubusercontent.com/sistematico/majestic/master/.local/share/rofi/themes/lateral.rasi'
curl -s -o ${HOME}/.local/share/rofi/themes/dark.rasi 'https://raw.githubusercontent.com/sistematico/majestic/master/.local/share/rofi/themes/dark.rasi'
curl -s -o ${HOME}/.local/share/rofi/themes/default.rasi 'https://raw.githubusercontent.com/sistematico/majestic/master/.local/share/rofi/themes/default.rasi'

rscripts=("alarme" "apps" "configs" "configs.bspwm" "drun" "fap" "git" "janelas" "power" "power.bspwm" "run" "screenshot")
for rscript in ${rscripts[@]}; do
	curl -s -o ${HOME}/.config/rofi/scripts/${rscript} "https://raw.githubusercontent.com/sistematico/majestic/master/.config/rofi/scripts/${rscript}"
done

# fontawesome
fc-list | grep -i feather 1> /dev/null 2> /dev/null
if [ $? -ne 0 ]; then
	echo "Fonte FeatherIcons não encontrado, instalando..."
	if [ ! -d ${HOME}/.local/share/fonts ]; then
		mkdir ${HOME}/.local/share/fonts
	fi
	curl -s "https://raw.githubusercontent.com/sistematico/majestic/master/.local/share/fonts/feather.ttf" > ${HOME}/.local/share/fonts/feather.ttf
	fc-cache -v -f
fi

# Wallpaper
DIR="${HOME}/.local/share/backgrounds"
WALL="${DIR}/carmine-de-fazio-31543.jpg"

if [ ! -f $WALL ]; then
	if [ ! -d $DIR ]; then
		mkdir -p $DIR
	fi
fi

curl -s "https://i.imgur.com/crTC1QR.jpg" > $WALL

if [ "$DESKTOP_SESSION" == "i3" ]; then
	i3-msg restart
fi