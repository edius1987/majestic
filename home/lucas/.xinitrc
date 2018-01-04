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

if [ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services" ] ; then
	mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services"
fi

export TERMINAL=termite
export EDITOR=nano
export BROWSER=brsr

#eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID
#export OOO_FORCE_DESKTOP=gnome
#export XDG_CURRENT_DESKTOP=GNOME
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus
#ibus-daemon -drx


eval $(dbus-launch --sh-syntax)

session=${1:-bspwm}

case $session in
	bspwm)
		ln -sfT "/usr/share/dbus-1/services/org.knopwob.dunst.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"
		exec bspwm
	;;
	i3|i3wm)
		ln -sfT "/usr/share/dbus-1/services/org.knopwob.dunst.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"
		exec i3
	;;
    cinnamon|cinnamon-session)
		ln -sfT "/usr/share/dbus-1/services/org.freedesktop.Notifications.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"
		exec cinnamon-session
	;;
	*)
		exec $1
	;;
esac

