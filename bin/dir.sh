#!/usr/bin/env bash

dia=$(date +'%d')
mes=$(date +'%m')
ano=$(date +'%y')
dir="${ano}/${mes}/${dia}/"

if [ "$1" == "-d" ]; then
	if [ $2 ]; then
		dir="${2}${dir}"
	fi

	mkdir -p $dir

	if [ $3 ]; then
		mv $3 $dir
	fi
fi
