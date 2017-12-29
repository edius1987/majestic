#!/bin/bash
icone=""
log=$(journalctl | tail -1 | ~/.config/polybar/scripts/strcut.py)
echo "$icone $log"
