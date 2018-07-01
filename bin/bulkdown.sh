#!/usr/bin/env bash
#
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a

ext="$1"  	# Separadas por virgula.
pasta="$(pwd)" 	# Diretório para salvar os arquivos.
min='1000' 	# Em bytes
lixeira="${HOME}/.local/share/Trash"
atual=$(date +'%s')
subpasta=$(find $pasta -type d | wc -l)

[ "$(ls -ld $pasta/$subpasta 2> /dev/null)" ] && echo "O diretório $pasta/$subpasta já existe. Abortando..." && exit

ajuda() {
    echo "Uso: $(basename $0) [EXT] \"http://site.com/pagina\""
}

if [ "$#" -lt 2 ]; then
	ajuda
	exit 1
fi

shift

for u in $@; do
	echo "Baixando todos os arquivos com a extensão $ext de $u..."
	dominio=$(echo "$u" | awk -F/ '{print $3}')
	wget --quiet -P $pasta -nd -r -l 1 -H -D $dominio -A $ext "$u"
done

for a in $pasta/*.$ext; do
	if [ -f $a ]; then
		mkdir -p $pasta/$subpasta
		tamanho=$(stat --printf="%s" $a)
		mod=$(stat --printf="%Y" $a)
		echo
		echo "------------------------------- $a -------------------------------"
		if [[ $mod > $atual ]]; then
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

	fi
done
