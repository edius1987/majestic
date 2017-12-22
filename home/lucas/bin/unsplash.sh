#!/bin/bash
#
# Script para alterar o papel de parede com uma imagem aleatória de unsplash.com
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 20/12/2017 19:27:31 
# Última Atualização: 20/12/2017 19:27:37 
#

which xdpyinfo >/dev/null 2>&1 || { echo >&2 "O programa xdpyinfo não está instalado. Abortando."; exit 1; }
which file >/dev/null 2>&1 || { echo >&2 "O programa file não está instalado. Abortando."; exit 1; }

dir="${HOME}/img/wallpapers/unsplash"
dir_lightdm="/usr/share/backgrounds/lightdm"
data=$(date +'%Y-%m-%d')
nome="unsplash-$data"
rand=$(shuf -i 1000-9999 -n 1)
x=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $3}')
y=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $4}')
# Máximo em MB
max=100

function excesso {
    tamanho=$(du -cm "$1" | tail -1 | grep -o '[0-9]*')
    caminho=$(ls -t1 "$1" | tail -1)
    maximo=$(($2*1024))

    if [ $3 ]; then
        superuser=$3
    fi    
    
    if [ $tamanho -gt $maximo ]; then    
        echo "Resumo:"
        echo "Tamanho: $tamanho"
        echo "Maximo: $max"
        echo "Imagem a ser removida: $caminho" 
        echo "$superuser rm -f $caminho"
    fi
}
	
curl -L -s "https://unsplash.it/${x}/${y}?random" > /tmp/$nome
ext=$(file /tmp/$nome | awk '{print $2}' | tr '[:upper:]' '[:lower:]')
	
[ ! -d $dir ] && mkdir -p $dir
arquivo=$dir/$nome.$ext

while : ; do
	if [ -f $arquivo ]; then
		i=$(($i+1))
		arquivo=$dir/$nome-$i.$ext
		echo "Existe, renomeando para ${arquivo}..."
	else
		break
	fi
done

cp /tmp/$nome $arquivo

if [ -f $arquivo ]; then
	if [ "$DESKTOP_SESSION" == "mate" ]; then 
		gsettings set org.mate.background picture-filename "$arquivo"
	elif [ "$DESKTOP_SESSION" == "i3" ]; then
		which feh >/dev/null 2>&1 && { feh --bg-fill "$arquivo"; }
	fi	

    excesso $dir $max root

    if sudo true; then
        if [ -f /etc/lightdm/lightdm-gtk-greeter.conf ]; then 
            [ ! -d $dir_lightdm ] && sudo mkdir -p $dir_lightdm
            sudo cp $arquivo $dir_lightdm
            nome=$(basename $arquivo)
            
            if [ ! -f /etc/lightdm/lightdm-gtk-greeter-${data}.conf ]; then 
                sudo cp /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter-${data}.conf
            fi

            if grep -q '^#background' /etc/lightdm/lightdm-gtk-greeter.conf; then
                echo "A linha #background= existe!"
                nome_lightdm=$(echo "${dir_lightdm}/${nome}" | sed 's/\//\\\//g')
                sudo sed -i "0,/^#background.*/s//background=${nome_lightdm}/" /etc/lightdm/lightdm-gtk-greeter.conf
            fi

            if grep -q '^background' /etc/lightdm/lightdm-gtk-greeter.conf; then
                echo "A linha background= existe!"
                nome_lightdm=$(echo "${dir_lightdm}/${nome}" | sed 's/\//\\\//g')
                #sudo sed -i "0,|^background.*|background=${nome_lightdm}|" /etc/lightdm/lightdm-gtk-greeter.conf
                sudo sed -i "0,/^background.*/s//background=${nome_lightdm}/" /etc/lightdm/lightdm-gtk-greeter.conf
            fi

            excesso $dir_lightdm $max root
        fi
    fi

fi

