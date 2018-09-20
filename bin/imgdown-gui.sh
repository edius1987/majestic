#!/usr/bin/env bash
#
# Arquivo: imgdown-gui.sh
# Descrição: Script usando o YAD, xclip e wget para baixar múltiplos arquivos de uma determinada
# extensão em um(ou vários) site(s).
#
# Feito por Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em:        20/09/2018 05:48:46
# Última alteração: 20/09/2018 14:38:55
#
# Referências:
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a
# https://stackoverflow.com/a/19060079

ext="jpg"  		# Separadas por virgula.
pasta="$(pwd)" 	# Diretório para salvar os arquivos.
min='300' 		# Resolução Vertical(em pixels)
lixeira="${HOME}/.local/share/Trash"
subpasta=$(find "$pasta" -type d | egrep -v 'tmp-' | wc -l)
temp="tmp-$$"

command -v yad 1> /dev/null 2> /dev/null
if [ $? = 1 ]; then
	echo "yad não instalado."
	exit
fi

command -v xclip 1> /dev/null 2> /dev/null
if [ $? = 0 ]; then
	turl="$(xclip -o)"
fi

eval $(yad --title "IMGdown" --width=400 --form --field="URLs" --field="Resolução Vertical Mínima:" "$turl" "$min" | awk -F'|' '{printf "urls=\"%s\"\nres=%s\n", $1, $2}')
[[ -z $urls || -z $res ]] && exit 1

mkdir $subpasta && mkdir $temp

for u in $urls; do
	dominio=$(echo "$u" | awk -F/ '{print $3}')
	(wget --quiet -P "$temp" -nd -r -l 1 -H -D $dominio -A $ext "$u" 2>&1 | yad --title "IMGdown" --progress --wrap --width=300 --auto-close --window-icon=gnome-shutdown --button="gtk-close:0" --image=gnome-shutdown --text "Baixando todos os arquivos com a extensão $ext de $u")
	#(wget -P "$pasta" -nd -r -l 1 -H -D $dominio -A $ext "$u" 2>&1 | sed -u 's/.*\ \([0-9]\+%\)\ \+\([0-9.]\+\ [KMB\/s]\+\)$/\1\n# Downloading \2/' | yad --title "IMGdown" --progress --wrap --width=350 --auto-close --window-icon=gnome-shutdown --button="gtk-close:0" --image=gnome-shutdown --text "Baixando todos os arquivos com a extensão $ext de $u")
done

for a in $temp/*.$ext; do
	#tamanho=$(stat --printf="%s" $a)
	res=$(convert $a -print "%h" /dev/null)
	if [[ $res -lt $min ]]; then
		mv $temp/$a $lixeira
	else
		mv $temp/$a $subpasta/
	fi
done

rm -rf robots.txt* $temp

exit 0