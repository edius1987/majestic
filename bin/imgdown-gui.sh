#!/usr/bin/env bash
#
# Arquivo: imgdown-gui.sh
# Descrição: Script usando o YAD, xclip e wget
# para baixar múltiplos arquivos de uma determinada
# extensão em um(ou vários) site(s).
#
# Feito por Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
#
# Criado em:        20/09/2018 05:48:46
# Última alteração: 20/09/2018 05:48:53
#
# Referências:
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a
# https://stackoverflow.com/a/19060079

ext="jpg"  		# Separadas por virgula.
pasta="$(pwd)" 	# Diretório para salvar os arquivos.
min='300' 		# Resolução Vertical(em pixels)
lixeira="${HOME}/.local/share/Trash"
atual=$(date +'%s')
subpasta=$(find "$pasta" -type d | wc -l)
#tamanho=$(echo $min | awk '{ byte =$1 /1024; print byte }')

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

for u in $urls; do
	dominio=$(echo "$u" | awk -F/ '{print $3}')
	(wget --quiet -P "$pasta" -nd -r -l 1 -H -D $dominio -A $ext "$u" 2>&1 | yad --title "IMGdown" --progress --pulsate --auto-close --progress-text "Baixando todos os arquivos com a extensão $ext de<br>$u...")
done

mkdir $subpasta

for a in *.$ext; do
	#tamanho=$(stat --printf="%s" $a)
	res=$(convert $a -print "%h" /dev/null)
	if [[ $res -lt $min ]]; then
		mv $a $lixeira
	else
		mv $a $subpasta/
	fi
done

rm -f robots.txt*
