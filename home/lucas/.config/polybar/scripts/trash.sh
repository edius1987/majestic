#!/bin/bash

. ~/.config/i3blocks/cores.conf

TRASH_DIRECTORY="${HOME}/.local/share/Trash"
TRASH_TEMP="/tmp/lixo"

if [[ "${TRASH_DIRECTORY}" = "" ]]; then
  TRASH_DIRECTORY=${XDG_DATA_HOME:-"${HOME}/.local/share/Trash"}
fi

if [[ "${1}" == "-x" ]]; then
	if [ ! -d $TRASH_TEMP ]; then
		mkdir $TRASH_TEMP
	fi

	cp -rf ${TRASH_DIRECTORY}/files ${TRASH_TEMP}/
	cp -rf ${TRASH_DIRECTORY}/info ${TRASH_TEMP}/

	rm -rf ${TRASH_DIRECTORY}/files
	rm -rf ${TRASH_DIRECTORY}/info

	mkdir ${TRASH_DIRECTORY}/files
	mkdir ${TRASH_DIRECTORY}/info
fi

TRASH_COUNT=$(ls -U -1 "${TRASH_DIRECTORY}/files" | wc -l)

if [[ ${TRASH_COUNT} -gt 0 ]]; then
	s=" ${TRASH_COUNT}"
else
	s=""
fi

echo "${s}"