#!/usr/bin/env bash
#
# syncmon.sh - Um programa para sincronizar automáticamente arquivos alterados em alguma pasta
# usando o rsync e inotifywait.
# 
# Criador por Lucas Saliés Brum a.k.a. sistematico, <lucas at archlinux dot com dot br>
#
# Criado em: 15/03/2018 18:15:04
# Última alteração: 16-03-2018 18:04:10

RSYNC=$(which rsync)
command -v inotifywait >/dev/null 2>&1 || { echo >&2 "O aplicativo inotifywait não está instalado. Abortando."; exit 1; }

if [ $2 ]; then
 	[ -d $1 ] || { echo >&2 "$1 não é uma pasta. Abortando."; exit 1; }
	param=$1
	tam=${#param}
	ult=${param:tam-1:1}
	[[ $ult != "/" ]] && param="$param/"; :

	while true; do
		inotifywait -q -e modify,create,delete -r $param && $RSYNC -avz $param $2
	done
else
	echo "Uso: $(basename $0) /pasta/local/ usuario@host:/pasta/remota/"
fi
