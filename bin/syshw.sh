#!/bin/bash

clear

# define colors for color-echo
red="\e[31m"
grn="\e[32m"
ylw="\e[33m"
cyn="\e[36m"
blu="\e[34m"
prp="\e[35m"
bprp="\e[35;1m"
rst="\e[0m"

color-echo()
{  # print with colors
  echo -e " $red$1: $rst$2"
}

print-kernel()
{
  color-echo 'KL' "$(uname -r | awk -F'-' '{print $1}')"
}

print-uptime()
{
  up=$(</proc/uptime)
  up=${up//.*}                # string before first . is seconds
  days=$((${up}/86400))       # seconds divided by 86400 is days
  hours=$((${up}/3600%24))    # seconds divided by 3600 mod 24 is hours
  mins=$((${up}/60%60))       # seconds divided by 60 mod 60 is mins
  color-echo "UP" $days'd '$hours'h '$mins'm'
}

print-shell() {
  shell=$(basename $(echo $SHELL))
  color-echo 'SH' "$shell"
}

print-cpu()
{
  arm=$(grep ARM /proc/cpuinfo)    # ARM procinfo uses different format
  if [[ "$arm" != "" ]]; then
    cpu=$(grep -m1 -i 'Processor' /proc/cpuinfo)
  else
    cpu=$(grep -m1 -i 'model name' /proc/cpuinfo)
  fi
  color-echo 'CP' "${cpu#*: }" # everything after colon is processor name
}

print-gpu()
{
  gpu=$(/usr/sbin/lspci | grep VGA | awk -F ': ' '{print $2}' | sed 's/(rev ..)//g')
  color-echo 'GP' "$gpu"
}

print-packages()
{
  packages=$(pacman -Qqs| wc -l)
  color-echo 'PKG' "$packages"
}

print-wm()
{
	color-echo 'WM' $DESKTOP_SESSION
}

print-distro() {
  [[ -e /etc/os-release ]] && source /etc/os-release
  if [[ -n "$NAME" ]]; then
    color-echo 'OS' "$NAME"
  else
    color-echo 'OS' "not found"
  fi
}

print-colors() {
	for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
		cor=$(echo -en "\033[$BG  \033[0m")
		cores=$cores$cor
	done
	echo -ne " ${red}COR: $cores"
}

echo
echo -en "  █▀▀▀▀▀▀▀▀▀▀▀█   |  " && print-distro
echo -en "  █           █   |  " && print-wm
echo -en "  █           █   |  " && print-uptime
echo -en "  █   █   █   █   |  " && print-shell
echo -en "  █           █   |  " && print-kernel
echo -en "  █           █   |  " && print-packages
echo -en "  ▀█▄▄▄▄▄▄▄▄▄█▀   |  " && print-colors
echo
sleep 10
