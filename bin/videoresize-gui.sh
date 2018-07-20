#!/usr/bin/env bash
#
# Arquivo: videoresize-gui.sh
# Descrição: Script usando o YAD e ffmpeg para redimensionar arquivos de vídeo.
#
# Feito por Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em:        2018-06-09 19:39:27
# Última alteração: 2018-07-20 12:26:27

titulo="Video Resize"
resolucoes=("1280" "1080" "720" "640" "480" "320")

command -v yad 1> /dev/null 2> /dev/null
if [ $? = 1 ]; then
	echo "yad não instalado."
	exit
fi

nome() {
	fl=$(basename -- "$1")
	ext="${fl##*.}"
	echo "${fl%.*}.$2.$$.${ext}"
}

caminho() {
    echo $(dirname "${1}")
}

echo "$(echo "${res}" | awk '{$1=$1};1')"
video=$(yad --title "$titulo" --separator=" " --width=400 --form --field="Arquivo:SFL" "$1" | awk '{$1=$1};1')
[[ -z $video ]] && exit 1

novo=$(dirname "${video}")/$(nome "$video" "resize")
largura=$(ffprobe -v quiet -show_format -show_streams "${video}" | grep '^width' | cut -d "=" -f 2)

for r in ${resolucoes[@]}; do
    if [ $r -lt $largura ]; then
        res+="${r}!"
    fi
done

resolucao=$(yad --form --width=400 --separator="!" --title "$titulo" --image=gnome-shutdown --button="gtk-close:1" --button="gtk-ok:0" --field="Arquivo:SFL" --field="Resolução:CB" "$novo" "$(echo ${res%?} | awk '{$1=$1};1')")
[[ -z $resolucao ]] && exit 1

 #| awk -F'!' '{printf "saida=\"%s\"\nre=%s", $1, $2}'

saida=$(echo $resolucao | awk -F'!' '{printf "%s", $1}')
resolucao=$(echo $resolucao | awk -F'!' '{printf "%s", $2}')

#[ -f $novo ] && mv "$novo" "$(dirname $novo)/$(nome $novo $$)"
#ffmpeg -vn -i "${video}" -filter:v scale=${resolucao}:-1 -c:a copy "${novo}" 2>&1 | yad --progress --pulsate

ffmpeg -vn -y -i "${video}" -filter:v scale=$resolucao:-1 -c:a copy "${saida}" | yad --title "$titulo" --text="Redimensionando video..." --width=400 --progress --pulsate --auto-close

if [ $? -eq 0 ]; then
	yad --text "Video: $saida redimensionado com sucesso." --button=gtk-no:1
else
	yad --text "Falha no redimensionamento de: ${saida}." --button=gtk-no:1
fi


