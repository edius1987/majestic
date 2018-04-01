#!/bin/bash
#
# Instalador do Script para alterar o background do slim
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 01/04/2018 15:45:24
# Última Atualização: 01/04/2018 15:45:29

uniturl="http://ix.io/15uO"
unitfile="/etc/systemd/system/slimbackground.service"
slimurl="http://ix.io/15vv"
slimfile="/usr/local/bin/slim-random.sh"

[ ! -f /etc/slim.conf ] && echo "SLiM não encontrado, abortando..." && exit 1
[ ! -f /etc/slim.conf.backup ] && cp /etc/slim.conf /etc/slim.conf.backup
[ ! -d $(dirname $slimfile) ] && mkdir -p $(dirname $slimfile)

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
    sed -i "0,/^current_theme.*/s//current_theme random/" /etc/slim.conf
    systemctl disable lightdm gdm nodm kdm
    systemctl enable slim-background
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
	    sed -i "0,/^current_theme.*/s//current_theme random/" /etc/slim.conf
	    sudo systemctl disable lightdm gdm nodm kdm
	    sudo systemctl enable slim-background
    else
        echo "Você precisa de permissões de root."
    fi
fi