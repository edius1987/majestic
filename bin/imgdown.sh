#!/usr/bin/env sh
#
# https://gist.github.com/tayfie/6dad43f1a452440fba7ea1c06d1b603a

# Separadas por virgula.
ext="jpg"
pasta='.'

if [ $1 ]; then
	url="$1"
	dominio=$(echo "$1" | awk -F/ '{print $3}')
	wget -P $pasta -nd -r -l 1 -H -D $dominio -A $ext
else
	echo "Uso: $(basename $0) \"http://site.com/pagina\""
	echo "$(basename $0) \"http://site.com/pagina\""
	echo "$(basename $0) \"http://site.com/pagina\""
fi
