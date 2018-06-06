#!/usr/bin/env bash
#
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a

ext="jpg"  	# Separadas por virgula.
pasta='.' 	# Diretório para salvar os arquivos.
min='100000' 	# Em bytes
lixeira="${HOME}/.local/share/Trash"

ajuda () {
    echo "Uso: $(basename $0) \"http://site.com/pagina\""
    echo "$(basename $0) \"http://site.com/pagina\""
    echo "$(basename $0) \"http://site.com/pagina\""
	exit
}

if [ $1 ]; then
	url="$1"
	#[[ ! "$url" = ^https?(s)://.* ]] && ajuda
	dominio=$(echo "$1" | awk -F/ '{print $3}')
	wget -P $pasta -nd -r -l 1 -H -D $dominio -A $ext "$url"
else
	ajuda
fi

for a in $pasta/*.$ext; do
	tamanho=$(stat --printf="%s" $a)
	if [[ $tamanho -lt $min ]]; then
		echo "$a tem $tamanho (mínimo: $min), apagando..."
		mv $a $lixeira
	fi
done
