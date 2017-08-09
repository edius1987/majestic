#!/bin/sh

/sbin/rmmod rtl8xxxu
/bin/sleep 1
/sbin/modprobe rtl8xxxu
/bin/sleep 10
netctl start lucas
