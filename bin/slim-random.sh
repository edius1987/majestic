#!/bin/bash
#
# Script para alterar o background do slim
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 01/04/2018 15:23:38
# Última Atualização: 01/04/2018 15:23:50

dir="/usr/share/backgrounds/slim"
dirslim="/usr/share/slim/themes/random"
rand=$(ls $dir/*.jpg | shuf -n 1)

[ ! -d $dir ] && echo "A pasta $dir não existe, abortando..." && exit 1
[ ! -d $dirslim ] && echo "A pasta $dirslim não existe, abortando..." && exit 1
[ ! -f $rand ] && echo "O arquivo $rand não existe, abortando..." && exit 1
[ ! -f /etc/slim.conf ] && echo "SLiM não encontrado, abortando..." && exit 1
[ ! -f /etc/slim.conf.backup ] && cp /etc/slim.conf /etc/slim.conf.backup

if [ "$EUID" == 0 ]; then
    cp -f $rand $dirslim/background.jpg
else
    if sudo true; then
        sudo cp -f $rand $dirslim/background.jpg
    else
        echo "Você precisa de permissões de root."
    fi
fi