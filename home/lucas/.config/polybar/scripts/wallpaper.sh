#!/bin/bash

[ -f ~/.config/user-dirs.dirs ] && source ~/.config/user-dirs.dirs

default="${XDG_PICTURES_DIR:-${HOME}/.local/share/backgrounds}"
dir="/home/lucas/img/wallpapers/unsplash"
ultima="/home/lucas/img/wallpapers/unsplash/lucian-moldovan-180777.jpg"
modo="--bg-fill"
indice=0
i=0

[ $2 ] && dir=$2

while read linha; do
    imagens[$i]="$linha"
    ((i++))
done < <(find "$dir" -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \))
#done < <(ls -1 $dir/*{jpg,png})

cont=${#imagens[@]}
total=$(($cont-1))

if [ $total -gt 0 ]; then
	for i in "${!imagens[@]}"; do
   		if [[ "${imagens[$i]}" = "${ultima}" ]]; then
       		indice=${i}
   		fi
	done
else
	echo "Nenhuma imagem."
	exit 1
fi

if [ "$1" == "a" ]; then
	if [ $indice -gt 0 ]; then
		((indice--))
	else
		indice=$total
	fi
	img=${imagens[$indice]}
elif [ "$1" == "p" ]; then
	if [ $indice -lt $total ]; then
		((indice++))
	else
		indice=0
	fi
	img=${imagens[$indice]}
elif [ "$1" == "r" ]; then
	img=${imagens[$RANDOM % ${#imagens[@]}]}
fi

#echo "$img"
#echo "$img" > ~/.wall
sed -i "s|^ultima=.*|ultima=\"${img}\"|g" $0

if [ -f "$img" ]; then
	feh $modo "$img"
	echo "$img" > ~/.wall
fi
