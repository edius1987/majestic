#!/usr/bin/env bash
#
# Arquivo: videoresize-gui.sh
# Descrição: Script usando o YAD e ffmpeg para cortar arquivos de vídeo.
#
# Feito por Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em:        2018-06-09 19:39:27
# Última alteração: 2018-07-19 17:57:04

# ~/.config/Thunar/uca.xml
#<action>
#	<icon>camera-video</icon>
#	<name>VideoCut</name>
#	<unique-id>1528543845224954-1</unique-id>
#	<command>videocut-gui.sh %F</command>
#	<description></description>
#	<patterns>*</patterns>
#	<video-files/>
#</action>

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

video=$(yad --title "$titulo" --width=400 --form --field=input:SFL)
[[ -z $video ]] && exit 1

echo $video

novo=$(nome $video "resize")

largura=$(ffprobe -v quiet -show_format -show_streams "${video}" | grep '^width' | cut -d "=" -f 2)
altura=$(ffprobe -v quiet -show_format -show_streams "${video}" | grep '^height' | cut -d "=" -f 2)

opt=$(yad --width 300 --entry --title "$titulo" --image=gnome-shutdown --button="gtk-ok:0" --button="gtk-close:1" --text "Resolução:" --entry-text $altura $largura)

#[[ -z $opt || -z $res ]] && exit 1
[[ -z $opt ]] && exit 1

#DIFF=$(($(date +%s --date="$END")-$(date +%s --date="$START")))
#OFFSET=""$(($DIFF / 3600)):$(($DIFF / 60 % 60)):$(($DIFF % 60))
#offset="$(show_time $DIFF)"


#ffmpeg -ss "$START" -t "$offset" -i "$INPUT" "$OUTPUT"
#echo "$START -t $OFFSET -i" "$(basename -- "$INPUT")" "$(basename -- "$OUTPUT")"

echo $opt