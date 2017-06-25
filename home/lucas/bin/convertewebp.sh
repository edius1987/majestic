#!/bin/sh
for arquivo in $(ls *.webp)
do
	saida="${arquivo%.*}"
  	dwebp "$arquivo" -o "${saida}.png"
done
