#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [ -d "$HOME/bin" ] ; then
    export PATH=$PATH:$HOME/bin
fi

export TERMINAL=termite
export EDITOR=nano
export BROWSER=firefox

#eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID
export OOO_FORCE_DESKTOP=gnome
#export LANG="en_US.UTF-8"
#export LC_ALL="en_US.UTF-8"
#export LANGUAGE="en_US.UTF-8"
#export LC_CTYPE="en_US.UTF-8"

#export LIBVA_DRIVER_NAME="vdpau"
#export VDPAU_DRIVER="nvidia"

eval $(dbus-launch --sh-syntax)
#export XDG_CURRENT_DESKTOP=GNOME

# Autostart
#${HOME}/bin/wallpaper.sh -r &
#compton &
#numlockx
#dunst &
#parcellite &
#sudo headsetcontrol 64 &
#/usr/local/bin/xautolock.sh &
#/usr/lib/vino/vino-server &
#xset r rate 300 75 &
#thunar --daemon &

session=${1:-i3}

case $session in
	i3|i3wm)
		exec i3
	;;
	*)
		exec $1
	;;
esac

