#!/bin/bash
icone=""
log=$(journalctl | tail -1 | ~/.config/polybar/strcut.py)
echo "$icone $log"
