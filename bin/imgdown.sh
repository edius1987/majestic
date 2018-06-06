#!/usr/bin/env bash
#
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a

ext="jpg"  	# Separadas por virgula.
pasta="$(pwd)" 	# Diretório para salvar os arquivos.
min='100000' 	# Em bytes
lixeira="${HOME}/.local/share/Trash"
atual=$(date +'%s')
subpasta=$(find $pasta -type d | wc -l)

#[ "$(ls -A $pasta)" ] && echo "Diretório não-vazio. Abortando..." && exit
[ "$(ls -ld $pasta/$subpasta 2> /dev/null)" ] && echo "O diretório $pasta/$subpasta já existe. Abortando..." && exit

mkdir -p $pasta/$subpasta

if [ "$1" == "-h" ]; then
    echo "Uso: $(basename $0) \"http://site.com/pagina\""
    echo "$(basename $0) \"http://site.com/pagina\""
    echo "$(basename $0) \"http://site.com/pagina\""
	exit
fi

if [ $1 ]; then
	for u in $@; do
		echo "Baixando todos os arquivos com a extensão $ext de $u..."
		dominio=$(echo "$u" | awk -F/ '{print $3}')
		wget --quiet -P $pasta -nd -r -l 1 -H -D $dominio -A $ext "$u"
	done
fi

for a in $pasta/*.$ext; do
	if [ -f $a ]; then
		tamanho=$(stat --printf="%s" $a)
		mod=$(stat -c "%Y" $a)
		if [[ $tamanho -lt $min ]]; then
			echo "$a tem $tamanho (mínimo: $min), checando data..."
			if [ $mod -ge $atual ]; then
				echo "$a ($mod) é mais novo que $atual, apagando..."
				mv $a $lixeira
			else
				echo "$a ($mod) é mais velho que $atual"
			fi
		else
			echo "Movendo $a para $subpasta..."
			mv $a $subpasta/
		fi
	fi
done
