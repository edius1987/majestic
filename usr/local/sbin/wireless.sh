#!/bin/sh

/sbin/rmmod rtl8xxxu
/bin/sleep 1
/sbin/modprobe rtl8xxxu
netctl start wireless
