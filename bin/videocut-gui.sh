#!/bin/bash

command -v yad 1> /dev/null 2> /dev/null 
if [ $? = 1 ]; then 
	echo "yad não instalado."
	exit
fi

function show_time () {
	#LC_ALL=C
    num=$(LC_ALL=C; echo $(printf '%.*f\n' 0 '475.229000'))
    #(printf '%.*f' 0 $1)
    min=0
    hour=0
    day=0
    if ((num>59)); then
        ((sec=num%60))
        ((num=num/60))
        if((num>59));then
            ((min=num%60))
            ((num=num/60))
            if((num>23));then
                ((hour=num%24))
                ((day=num/24))
            else
                ((hour=num))
            fi
        else
            ((min=num))
        fi
    else
        ((sec=num))
    fi

	[[ ${#hour} -lt 2 ]] && hour="0$hour"
	[[ ${#min} -lt 2 ]] && min="0$min"
	[[ ${#sec} -lt 2 ]] && sec="0$sec"

    echo "${hour}:${min}:${sec}"
}

video=$1

t=$(ffprobe -i "$video" -show_entries format=duration -v quiet -of csv="p=0")
total="$(show_time $t)"

fl=$(basename -- "$video")
ext="${fl##*.}"
fl="${fl%.*}.new.${ext}"

eval $(yad --width=400 --form --field=input:FL --field=start --field=end --field=output:SFL "" "00:00:00" "$total" "$fl" | awk -F'|' '{printf "INPUT=\"%s\"\nSTART=%s\nEND=%s\nOUTPUT=\"%s\"\n", $1, $2, $3, $4}')
[[ -z $INPUT || -z $START || -z $END || -z $OUTPUT ]] && exit 1

DIFF=$(($(date +%s --date="$END")-$(date +%s --date="$START")))
OFFSET=""$(($DIFF / 3600)):$(($DIFF / 60 % 60)):$(($DIFF % 60))

#ffmpeg -ss "$START" -t "$OFFSET" -i "$INPUT" "$OUTPUT"
echo "$START -t $OFFSET -i $INPUT $OUTPUT"
