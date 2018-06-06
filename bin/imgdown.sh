#!/usr/bin/env bash
#
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a

ext="jpg"  	# Separadas por virgula.
pasta="$(pwd)" 	# Diretório para salvar os arquivos.
min='100000' 	# Em bytes
lixeira="${HOME}/.local/share/Trash"
atual=$(date +'%s')

#[ "$(ls -A $pasta)" ] && echo "Not Empty" || echo "Empty"
[ "$(ls -A $pasta)" ] && echo "Diretório não-vazio. Abortando..." && exit

ajuda () {
    echo "Uso: $(basename $0) \"http://site.com/pagina\""
    echo "$(basename $0) \"http://site.com/pagina\""
    echo "$(basename $0) \"http://site.com/pagina\""
	exit
}

if [ $1 ]; then

	for u in $@; do
		echo "Baixando todos os arquivos com a extensão $ext de $u..."
		#url="$1"
		[[ "$u" = ^http?(s)://.* ]] || echo "Erro, a url deve conter http:// ou https://" && exit
		dominio=$(echo "$u" | awk -F/ '{print $3}')
		wget --quiet -P $pasta -nd -r -l 1 -H -D $dominio -A $ext "$u"
	done

else
	ajuda
fi

for a in $pasta/*.$ext; do
	if [ -f $a ]; then
		tamanho=$(stat --printf="%s" $a)
		mod=$(stat -c "%Y" $a)
		#if [[ $tamanho -lt $min ]]; then
			echo "$a tem $tamanho (mínimo: $min), checando data..."
			if [[ $mod -gt $atual ]]; then
				echo "$a ($mod) é mais novo que $atual, apagando..."
				#mv $a $lixeira
			else
				echo "$a ($mod) é mais velho que $atual, mantendo..."
			fi
		#fi
	fi
done
