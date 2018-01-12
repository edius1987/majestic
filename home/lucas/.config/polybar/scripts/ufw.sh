#!/bin/bash

status=$(sudo ufw status 2>/dev/null)

# Left click
if [[ "$1" == "toggle" ]]; then
	if [[ "${status}" != *inactive* ]]; then
  	sudo ufw disable
	else
		sudo ufw enable
	fi
fi

if [[ $? -gt 0 ]]; then
  exit
fi

if [[ "${status}" != *inactive* ]]; then
  echo ""
else
  echo ""
fi
