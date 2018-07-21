#!/usr/bin/env bash
#
# Arquivo: videocut-gui.sh
# Descrição: Script usando o YAD e ffmpeg para cortar arquivos de vídeo.
#
# Feito por Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em:        2018-06-09 19:39:27
# Última alteração: 2018-07-21 19:40:32

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

function show_time () {
    num=$(LC_ALL=C; echo $(printf '%.*f\n' 0 "$1"))
    min=0
    hour=0
    day=0
    if ((num>59)); then
        ((sec=num%60))
        ((num=num/60))
        if((num>59));then
            ((min=num%60))
            ((num=num/60))
            if((num>23));then
                ((hour=num%24))
                ((day=num/24))
            else
                ((hour=num))
            fi
        else
            ((min=num))
        fi
    else
        ((sec=num))
    fi

	[[ ${#hour} -lt 2 ]] && hour="0$hour"
	[[ ${#min} -lt 2 ]] && min="0$min"
	[[ ${#sec} -lt 2 ]] && sec="0$sec"

    echo "${hour}:${min}:${sec}"
}

if [ "$1" ]; then
	t=$(ffprobe -i "$1" -show_entries format=duration -v quiet -of csv="p=0")
	total="$(show_time $t)"
	nome=$(nome "$1" "novo")
else
	total="00:00:00"
fi

eval $(yad --title "VideoCut" --width=400 --form --field="Arquivo\::SFL" --field="Início:" --field="Fim:" --field="Saída:" "$1" "00:00:00" "$total" "$nome" | awk -F'|' '{printf "INPUT=\"%s\"\nSTART=%s\nEND=%s\nOUTPUT=\"%s\"\n", $1, $2, $3, $4}')
[[ -z $INPUT || -z $START || -z $END || -z $OUTPUT ]] && exit 1

DIFF=$(($(date +%s --date="$END")-$(date +%s --date="$START")))
#OFFSET=""$(($DIFF / 3600)):$(($DIFF / 60 % 60)):$(($DIFF % 60))
offset="$(show_time $DIFF)"


ffmpeg -ss "$START" -t "$offset" -i "$INPUT" "$OUTPUT"
#echo "$START -t $OFFSET -i" "$(basename -- "$INPUT")" "$(basename -- "$OUTPUT")"
