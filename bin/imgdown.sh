#!/usr/bin/env bash
#
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a

ext="jpg"  		# Separadas por virgula.
pasta="$(pwd)" 	# Diretório para salvar os arquivos.
min='100000' 	# Em bytes
lixeira="${HOME}/.local/share/Trash"
atual=$(date +'%s')
subpasta=$(find "$pasta" -type d | wc -l)

[ "$(ls -ld $pasta/$subpasta 2> /dev/null)" ] && echo "O diretório $pasta/$subpasta já existe. Abortando..." && exit

if [ "$1" == "-h" ] || [ ! $1 ]; then
    echo "Uso: $(basename $0) \"http://site.com/pagina\""
    echo "$(basename $0) \"http://site.com/pagina\""
    echo "$(basename $0) \"http://site.com/pagina\""
	exit
fi

if [ "$1" == "-g" ]; then
	command -v yad 1> /dev/null 2> /dev/null
	if [ $? = 1 ]; then
		echo "yad não instalado."
		exit
	fi

	urls=$(yad --title "IMGdown" --separator=" " --width=400 --form --field="URLs" "")
	[[ -z $urls ]] && exit 1

	for u in $urls; do
		dominio=$(echo "$u" | awk -F/ '{print $3}')
		#(wget --quiet -P "$pasta" -nd -r -l 1 -H -D $dominio -A $ext "$u" 2>&1 | yad --title "IMGdown" --progress --pulsate --auto-close --progress-text "Baixando todos os arquivos com a extensão $ext de $u...")
		(wget --quiet -P "$pasta" -nd -r -l 1 -H -D $dominio -A $ext "$u" 2>&1 | yad --title "IMGdown" --wrap --auto-close --info-text "Baixando todos os arquivos com a extensão" --info-text "$ext de $u...")
	done

else
	if [ $1 ]; then
		for u in $@; do
			echo "Baixando todos os arquivos com a extensão $ext de $u..."
			dominio=$(echo "$u" | awk -F/ '{print $3}')
			wget --quiet -P "$pasta" -nd -r -l 1 -H -D $dominio -A $ext "$u"
		done
	fi
fi

# for a in $pasta/*.$ext; do
for a in *.$ext; do

		#mkdir -p $pasta/$subpasta
		tamanho=$(stat --printf="%s" $a)
		mod=$(stat --printf="%Y" $a)
		echo
		echo "------------------------------- $a -------------------------------"
		if [[ $mod < $atual ]]; then
			echo "$a ($mod) é mais novo que $atual, checando tamanho..."
			if [[ $tamanho < $min ]]; then
				echo "$a tem $tamanho (mínimo: $min), apagando..."
				mv $a $lixeira
			else
				echo "Movendo $a para $subpasta..."
				mv $a $subpasta/
			fi
		else
			echo "$a ($mod) é mais velho que $atual, ignorando..."
		fi

done

rm -f robots.txt*
