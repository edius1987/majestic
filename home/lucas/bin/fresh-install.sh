#!/bin/sh

sed -i '/TotalDownload/s/^#//g' /etc/pacman.conf

pacman -S wpa_supplicant wpa_actiond dialog iw sudo bash-completion efibootmgr \
intel-ucode grub nvidia-304xx gpm slim links git terminus-font xorg archlinux-themes-slim \
pulseaudio pulseaudio-alsa alsa-{utils,plugins,firmware} firefox-i18n-pt-br firefox pluma \
scratch-text-editor termite arc-icon-theme arc-gtk-theme lxappearance feh thunar gvfs dmenu \
mpv viewnior openssh vino vinagre mosh tmux rsync xorg-xinit wmctrl

dconf write /org/gtk/settings/file-chooser/sort-directories-first true
xfconf-query -c thunar -n -p /misc-full-path-in-title -t bool -s true
