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
    #PATH="$HOME/bin:$PATH"
    export PATH=$PATH:$HOME/bin
fi

export TERMINAL=termite
export EDITOR=pluma
export BROWSER=firefox

# Start a D-Bus session
#source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
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

eval $(dbus-launch --sh-syntax)
export XDG_CURRENT_DESKTOP=GNOME

session=${1:-i3}

case $session in
	i3|i3wm)
		/usr/bin/xautolock -time 1 -locker 'i3lock-fancy -f Iosevka-Thin -t "Tela Bloqueada" -p -- scrot -z' -detectsleep &
		exec i3
	;;
	*)
		exec $1
	;;
esac

