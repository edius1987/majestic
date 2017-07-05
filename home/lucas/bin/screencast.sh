#!/bin/sh
#
# Script para criar screencasts(vídeos da captura de tela) usando o ffmpeg.
#
# Desenvolvido por Lucas Saliés Brum <lucas@archlinux.com.br>
#
# Criado em: 09/06/2017
# Última Atualização: 10/06/2017 09:36:56
#

nome="screencast"
extensao="mp4"
preset="fast" # ultrafast,superfast,veryfast,faster,fast,medium,slow,slower,veryslow,placebo
caminho="${HOME}/video"
data=$(date +%Y-%m-%d_%H-%M-%S)
icone="/usr/share/icons/Arc/devices/48@2x/video-display.png"
arquivo="${caminho}/${nome}-${data}.${extensao}"
resolucao=$(xrandr | grep '*' | awk 'NR==1{print $1}')
# alsa_output.usb-Logitech_Logitech_G930_Headset-00.analog-stereo.monitor
audio=$(pacmd list-sinks | grep -A 1 'index: 1' | awk 'NR==2{print $2}' | awk '{print substr($0,2,length($0)-2)}') # list-sources, list-sinks
ativo=$(tmux ls 2> /dev/null | grep $nome | cut -d ':' -f 1)

if [ "$1" == "-s" ]; then
	if [ "$ativo" == "screencast" ]; then
		tmux kill-session -t $nome
		killall ffmpeg
		notify-send -i $icone "ScreenCast" "O vídeo <b>$arquivo</b> foi terminado."
	else
		notify-send -i $icone "ScreenCast" "Nenhuma sessão ativa, digite <b>$0</b> para iniciar!"
	fi
elif [ "$1" == "-a" ]; then
	tmux a -t $nome
elif [ "$1" == "-h" ]; then
	echo
	echo "Uso: $0 [-hs]"
	echo
else
	if [ "$ativo" != "screencast" ]; then
		# tmux new-session -d -s $nome "ffmpeg -f x11grab -video_size $resolucao -framerate 30 -i :0.0 -f pulse -i default -preset $preset -crf 18 -pix_fmt yuv420p $arquivo"
		# tmux new-session -d -s $nome "ffmpeg -f pulse -i $audio -f x11grab -r 30 -s $resolucao -i :0.0 -acodec pcm_s16le -vcodec libx264 -preset $preset -crf 0 -threads 0 $arquivo"
		if [ "$2" == "-t" ]; then
			tmux new-session -d -s $nome "ffmpeg -f x11grab -r 30 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -crf 0 -threads 0 -probesize 10M $arquivo"
		else
			#ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -crf 0 -threads 0 -probesize 10M $arquivo
			ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -vcodec libx264 -probesize 30M $arquivo
		fi
		notify-send -i $icone "ScreenCast" "O vídeo <b>$arquivo</b> foi iniciado..."
	else
		notify-send -i $icone "ScreenCast" "Uma sessão já está ativa, digite <b>$0 -s</b> para parar!"
	fi
fi
