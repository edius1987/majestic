#!/usr/bin/env bash
#
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a

ext="jpg"  		# Separadas por virgula.
pasta="$(pwd)" 	# Diretório para salvar os arquivos.
min='100000' 	# Em bytes
lixeira="${HOME}/.local/share/Trash"
pasta="$HOME/tmp"

#[ "$(ls -ld $pasta/$subpasta 2> /dev/null)" ] && echo "O diretório $pasta/$subpasta já existe. Abortando..." && exit

if [ "$1" == "-h" ] || [ ! $1 ]; then
    echo "Uso: $(basename $0) \"http://site.com/pagina\""
    echo "$(basename $0) \"http://site.com/pagina\""
    echo "$(basename $0) \"http://site.com/pagina\""
	exit
fi


if [ $1 ]; then
	for u in $@; do
		echo "Baixando todos os arquivos com a extensão $ext de $u..."
		dominio=$(echo "$u" | awk -F/ '{print $3}')
		wget --quiet -P "$pasta" -nd -r -l 1 -H -D $dominio -A $ext "$u"
	done
else
	command -v xclip 1> /dev/null 2> /dev/null
	if [ $? = 0 ]; then
		turl="$(xclip -o)"
	fi

	#dominio=$(echo "$turl" | awk -F/ '{print $3}')
	dominio=$(echo "$turl" | sed -e "s/[^/]*\/\/\([^@]*@\)\?\([^:/]*\).*/\2/" | sed "s/^www\.//")
	wget --quiet -P "$pasta" -nd -r -l 1 -H -D $dominio -A $ext "$turl"
fi

for a in $pasta/*.$ext; do
	if [[ $(convert $a -print "%h" /dev/null) -lt $min ]]; then
		mv $a $lixeira
	fi
done

rm -rf $pasta/robots.txt*
