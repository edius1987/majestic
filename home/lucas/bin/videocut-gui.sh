#!/bin/bash

#video=$1

#total=$(ffprobe -i $video -show_entries format=duration -v quiet -of csv="p=0")

eval $(yad --width=400 --form --field=input:FL --field=start --field=end --field=output:SFL "" "00:00:00" "00:00:00" "" | awk -F'|' '{printf "INPUT=\"%s\"\nSTART=%s\nEND=%s\nOUTPUT=\"%s\"\n", $1, $2, $3, $4}')
[[ -z $INPUT || -z $START || -z $END || -z $OUTPUT ]] && exit 1

DIFF=$(($(date +%s --date="$END")-$(date +%s --date="$START")))
OFFSET=""$(($DIFF / 3600)):$(($DIFF / 60 % 60)):$(($DIFF % 60))

ffmpeg -ss "$START" -t "$OFFSET" -i "$INPUT" "$OUTPUT"
