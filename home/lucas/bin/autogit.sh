#!/bin/sh

if [ -z "$1" ]
then
	echo "Número errado de parâmetros."
	exit 1
fi

GIT_FOLDER="/home/lucas/configs"
GIT=$(which git)

cd $GIT_FOLDER
$GIT add .
$GIT commit -am "$*"
$GIT push origin master
