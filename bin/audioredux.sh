
#!/usr/bin/env bash

titulo="Audio Redux"
[ $1 ] && dir="$1" || dir="$(pwd)"
novo="${dir}/${$}"

ext=$(dialog --stdout --title "$titulo" --menu 'Extensão:' 0 0 0   'mp3' '' 'm4a' '')
if [ $(ls -1 *.$ext 2>/dev/null | wc -l) != 0 ]; then
	mkdir $dir
	qualidade=$(dialog --stdout --title "$titulo" --menu 'Qualidade:' 0 0 0   1 '' 2 '' 3 '')

	for f in *.$ext; do
		ffmpeg -i "$f" -codec:v copy -codec:a libmp3lame -q:a $qualidade $novo/"${f%.m4a}.mp3"
	done
else
	dialog --title "$titulo" --msgbox "Nenhum arquivo com a extensão: $ext foi encontrado!" 0 0
	exit 0
fi

dialog --title "$titulo" --msgbox "Arquivos reduzidos com sucesso!" 0 0
