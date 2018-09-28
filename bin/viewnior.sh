#!/usr/bin/env bash

if [ $1 ]; then
	dir="$1"
else
	dir="$(pwd)"
fi

echo ${dir}

viewnior "$(find \"${dir}\" -iname '*.jpg')"
