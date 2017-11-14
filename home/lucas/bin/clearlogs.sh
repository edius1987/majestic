#!/bin/sh

if [ $UID = 0 ]; then
	journalctl --flush --rotate
	journalctl --vacuum-size=1K
	journalctl --verify
fi
