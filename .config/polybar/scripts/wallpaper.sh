#!/usr/bin/env bash

[ -f ~/.config/user-dirs.dirs ] && source ~/.config/user-dirs.dirs

dir="${XDG_PICTURES_DIR:-${HOME}/img}/wallpapers/unsplash"
ultima="/home/lucas/img/wallpapers/unsplash/christin-hume-588780-unsplash.jpg"
modo="--bg-fill"
indice=0
i=0

if [ "$2" ]; then
	if [ -d $2 ]; then
		dir=$2
	fi
else
	if [ ! -d $dir ]; then 
		mkdir -p $dir
	fi
fi

if ! ls $dir/* 1> /dev/null 2>&1; then
	curl -s -L 'https://unsplash.com/photos/mEV-IXdk5Zc/download?force=true' > $dir/alex-block-354270-unsplash.jpg
	curl -s -L 'https://unsplash.com/photos/qNri0Cz_zkQ/download?force=true' > $dir/desmond-simon-468218-unsplash.jpg
fi

if [ "$1" == "d" ]; then
	img="$dir/unsplash-$$.jpg"
	curl -L -s "https://unsplash.it/${x}/${y}?random" > $img
fi

while read linha; do
    imagens[$i]="$linha"
    ((i++))
done < <(find "$dir" -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \))

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

if [ "$1" == "rr" ]; then
	if [ ! -f $HOME/.wall ] || [ ! -f $(cat $HOME/.wall) ]; then
		echo $default > $HOME/.wall
	fi
	img="$(cat $HOME/.wall)"
elif [ "$1" == "x" ]; then
	hsetroot -solid "#2e3440"
elif [ "$1" == "a" ]; then
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
elif [ "$1" != "d" ]; then
	img=${imagens[$RANDOM % ${#imagens[@]}]}	
fi

if [ -f "$img" ]; then
	sed -i "s|^ultima=.*|ultima=\"${img}\"|g" $0
	feh $modo "$img"
	echo "$img" > ~/.wall
fi
