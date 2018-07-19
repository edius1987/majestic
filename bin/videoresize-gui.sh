#!/usr/bin/env bash
#
# Arquivo: videoresize-gui.sh
# Descrição: Script usando o YAD e ffmpeg para cortar arquivos de vídeo.
#
# Feito por Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em:        2018-06-09 19:39:27
# Última alteração: 2018-07-19 18:10:18

titulo="Video Resize"

command -v yad 1> /dev/null 2> /dev/null
if [ $? = 1 ]; then
	echo "yad não instalado."
	exit
fi

nome() {
	fl=$(basename -- "$1")
	ext="${fl##*.}"
	echo "${fl%.*}.$2.${ext}"
}

caminho() {
    echo $(dirname "${1}")
}

video=$(yad --title "$titulo" --width=400 --form --field=input:SFL)
[[ -z $video ]] && exit 1

novo=$(nome "$video" "resize")
novo_caminho=$(caminho "$video")
largura=$(ffprobe -v quiet -show_format -show_streams "${video}" | grep '^width' | cut -d "=" -f 2)
altura=$(ffprobe -v quiet -show_format -show_streams "${video}" | grep '^height' | cut -d "=" -f 2)

resolucao=$(yad --width 300 --entry --title "$titulo" --image=gnome-shutdown --button="gtk-ok:0" --button="gtk-close:1" --text "Resolução:" --entry-text "720" "640" "480")
[[ -z $resolucao ]] && exit 1

ffmpeg -i "${novo_caminho}/${video}" -filter:v scale=${resolucao}: -c:a copy "${novo_caminho}/${novo}"
