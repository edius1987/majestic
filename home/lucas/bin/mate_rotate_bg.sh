#!/bin/bash
 
walls_dir="/usr/share/backgrounds/xxx"
selection=$(find $walls_dir -type f -name "*.jpg" -o -name "*.png" | shuf -n1)
gsettings set org.mate.background picture-filename "$selection"

