
#!/usr/bin/env bash

dir="$(pwd)"
novo="${dir}/${$}"
titulo="Audio Redux"

ext=$(dialog --stdout --title "$titulo" --menu 'Extensão:' 0 0 0   'mp3' '' 'm4a' '')
if [ $(ls -1 *.$ext 2>/dev/null | wc -l) != 0 ]; then
	mkdir $dir
	qualidade=$(dialog --stdout --title "$titulo" --menu 'Qualidade:' 0 0 0   1 '' 2 '' 3 '')

	for f in *.$ext; do
		ffmpeg -i "$f" -codec:v copy -codec:a libmp3lame -q:a $qualidade $novo/"${f%.m4a}.mp3"
	done
fi