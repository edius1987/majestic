#!/bin/bash
#
# Script para alterar o papel de parede e o background do lightdm
# com uma imagem aleatória de unsplash.com
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 20/12/2017 19:27:31 
# Última Atualização: 02/01/2018 12:37:36

which xdpyinfo >/dev/null 2>&1 || { echo >&2 "O programa xdpyinfo não está instalado. Abortando."; exit 1; }
which file >/dev/null 2>&1 || { echo >&2 "O programa file não está instalado. Abortando."; exit 1; }

nome="unsplash-$(date +'%Y-%m-%d').jpg"
dir="${HOME}/img/wallpapers/unsplash"
ultima=$(ls -t1 "$dir" | tail -1)
arquivo="${dir}/${nome}"
x=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $3}')
y=$(xdpyinfo | awk -F '[ x]+' '/dimensions:/{print $4}')

function unsplash_grab {
    [ ! -d $dir ] && mkdir -p $dir
    [ ! -f /tmp/$nome ] && curl -L -s "https://unsplash.it/${x}/${y}?random" > /tmp/${nome}
    
    if [ -f $arquivo ]; then
        while : ; do
            if [ -f $arquivo ]; then
                i=$(($i+1))
                arquivo="${dir}/unsplash-$(date +'%Y-%m-%d')-${i}.jpg"
                #echo "Existe, renomeando para ${arquivo}..."
            else
                break
            fi
        done
    fi
    [ -f /tmp/$nome ] && mv /tmp/${nome} $arquivo
    echo $arquivo > ~/.unsplash
}

function unsplash {
    [ -f ~/.unsplash ] && arquivo=$(cat ~/.unsplash)

    if [ -f $arquivo ]; then
        if [ "$DESKTOP_SESSION" == "mate" ]; then 
            gsettings set org.mate.background picture-filename "$arquivo"
        elif [ "$DESKTOP_SESSION" == "i3" ]; then
            which feh >/dev/null 2>&1 && { feh --bg-fill "$arquivo"; }
        elif [ "$DESKTOP_SESSION" == "bspwm" ]; then
            which feh >/dev/null 2>&1 && { feh --bg-fill "$arquivo"; }
        fi  
    fi  
}

if [ "$1" == "-u" ]; then
    unsplash_grab
    unsplash
else
    unsplash
fi





