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
preset="superfast" # ultrafast,superfast,veryfast,faster,fast,medium,slow,slower,veryslow,placebo
caminho="${HOME}/video"
data=$(date +%Y-%m-%d_%H-%M-%S)
icone="/usr/share/icons/Arc/devices/24@2x/video-display.png"
arquivo="${caminho}/${nome}-${data}.${extensao}"
resolucao=$(xrandr | grep '*' | awk 'NR==1{print $1}')
# alsa_output.usb-Logitech_Logitech_G930_Headset-00.analog-stereo.monitor
audio=$(pacmd list-sinks | grep -A 1 'index: 1' | awk 'NR==2{print $2}' | awk '{print substr($0,2,length($0)-2)}') # list-sources, list-sinks
ativo=$(tmux ls 2> /dev/null | grep $nome | cut -d ':' -f 1)
ativo2=$(ps -A | grep ffmpeg 2>&1)

if [ "$1" == "-s" ]; then
	if [ "$ativo" == "$nome" ]; then
		tmux kill-session -t $nome
		killall ffmpeg
		notify-send -i $icone "ScreenCast" "O vídeo <b>$arquivo</b> foi terminado."
	elif [ "$ativo2" ]; then
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
		if [ ! $ativo2 ]; then
			notify-send -i $icone "ScreenCast" "O vídeo <b>$arquivo</b> foi iniciado..."

			# tmux new-session -d -s $nome "ffmpeg -f x11grab -video_size $resolucao -framerate 30 -i :0.0 -f pulse -i default -preset $preset -crf 18 -pix_fmt yuv420p $arquivo"
			# tmux new-session -d -s $nome "ffmpeg -f pulse -i $audio -f x11grab -r 30 -s $resolucao -i :0.0 -acodec pcm_s16le -vcodec libx264 -preset $preset -crf 0 -threads 0 $arquivo"
			if [ "$2" == "-t" ]; then
				#tmux new-session -d -s $nome "ffmpeg -f x11grab -r 30 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -crf 0 -threads 0 -probesize 10M $arquivo"
				#tmux new-session -d -s $nome "ffmpeg -f x11grab -r 30 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -crf 0 -c:v libx264 -b:v 464k -c:a aac -b:a 128k -thread_queue_size 16 -probesize 50M $arquivo"
				tmux new-session -d -s $nome "ffmpeg -thread_queue_size 512 -f x11grab -r 30 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k -probesize 50M $arquivo"
			else
				#ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -crf 0 -threads 0 -probesize 10M $arquivo
				#ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k -probesize 50M $arquivo
				#ffmpeg -f x11grab -r 25 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k -probesize 50M $arquivo
				ffmpeg -thread_queue_size 512 -f x11grab -r 30 -s $resolucao -i :0.0 -f pulse -i default -preset $preset -c:v libx264 -c:a aac -b:a 128k $arquivo -probesize 50M
			fi
		else
			notify-send -i $icone "ScreenCast" "Uma sessão já está ativa, digite <b>$0 -s</b> para parar!"
		fi
	else
		notify-send -i $icone "ScreenCast" "Uma sessão já está ativa, digite <b>$0 -s</b> para parar!"
	fi
fi
