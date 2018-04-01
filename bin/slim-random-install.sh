#!/bin/bash
#
# Instalador do Script para alterar o background do slim
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 01/04/2018 15:45:24
# Última Atualização: 01/04/2018 15:45:29

uniturl="http://ix.io/15uO"
unitfile="/etc/systemd/system/slim-background.service"
slimurl=""
slimfile="/usr/local/bin/slim-random.sh"

[ ! -f /etc/slim.conf ] && echo "SLiM não encontrado, abortando..." && exit 1
[ ! -f /etc/slim.conf.backup ] && cp /etc/slim.conf /etc/slim.conf.backup

if [ "$EUID" == 0 ]; then
	if [ ! -d /usr/share/slim/themes/archlinux-retro ] && [ ! -d /usr/share/slim/themes/random ]; then
		echo "Instalando o tema base..."
		pacman -S archlinux-themes-slim
		sudo cp -r /usr/share/slim/themes/archlinux-retro /usr/share/slim/themes/random
	fi
    echo "Instalando a unit $(basename $unitfile) em $(dirname $unitfile)..."
    curl -s -L -o $unitfile "$uniturl"
    echo "Instalando o script $(basename $slimfile) em $(dirname $slimfile)..."
    curl -s -L -o $slimfile "$slimurl"
    systemctl daemon-reload
else
    if sudo true; then
    	if [ ! -d /usr/share/slim/themes/archlinux-retro ] && [ ! -d /usr/share/slim/themes/random ]; then
			echo "Instalando o tema base..."
			sudo pacman -S archlinux-themes-slim
			sudo cp -r /usr/share/slim/themes/archlinux-retro /usr/share/slim/themes/random
		fi
	    echo "Instalando a unit $(basename $unitfile) em $(dirname $unitfile)..."
	    sudo curl -s -L -o $unitfile "$uniturl"
	    echo "Instalando o script $(basename $slimfile) em $(dirname $slimfile)..."
	    sudo curl -s -L -o $slimfile "$slimurl"  
	    sudo systemctl daemon-reload
    else
        echo "Você precisa de permissões de root."
    fi
fi