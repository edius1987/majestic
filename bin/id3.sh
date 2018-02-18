#!/bin/bash
#
# id3.sh: Um script para ajustar a tag id3 de várias músicas ao mesmo tempo.
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em:           16-09-2017 12:37:00 AMT
# Última alteração em: 16-09-2017 12:37:00 AMT
#
# Uso: id3.sh /caminho/para/as/mp3s

which id3 1> /dev/null 2> /dev/null
if [ $? != 0 ]; then
	echo "O aplicativo id3 não foi encontrado. Abortando..."
    exit 1
fi

extensao="mp3"
dir="$1"

ls $dir/*.${extensao} 1> /dev/null 2> /dev/null
if [ $? != 0 ]; then
    echo "Nenhum arquivo com a extensão: $extensao foi encontrado em ${dir}. Abortando..."
    exit 1
fi

echo "Tem certeja que deseja alterar todas as tags id3 dos arquivos em ${dir}? [s/N]"
read resposta

if [[ "$resposta" != [Ss]* ]]; then
	echo "Programa abortado pelo usuário..."
	exit 1
fi

for arquivo in ${dir}/*.${extensao}; do
	nome=$(basename -s .${extensao} "$arquivo")
	artista=$(echo "$nome" | awk -F'-' '{print $1}' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
	faixa=$(echo "$nome" | awk -F'-' '{$1=""; print}' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
	echo "Gravando a id3 de ${arquivo}..."
	echo "Artista: $artista"
	echo "Faixa: $faixa"
	id3 -a "$artista" -t "$faixa" "$arquivo"
done
