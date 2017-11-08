#!/bin/bash

homedir="${HOME}/.local/share/applications"
sysdir="/usr/share/applications"
apps=("cinnamon*" "*qt4*" "mate-color-select*")
nd='NoDisplay'

function nodisp {
	if [ $1 = '-r' ]; then
        if [ -f $2 ]; then
			grep 'NoDisplay' $2 1> /dev/null
        	if [ $? = 0 ]; then
            	echo "Removendo NoDisplay de $2"
				sed -i.bak "/$nd/d" $2
        	fi
		fi
	else
		grep 'NoDisplay' $1 1> /dev/null
		if [ $? = 1 ]; then
			echo "Inserindo NoDisplay em $1"
			echo 'NoDisplay=true' >> $1
		fi
	fi
}

if [ $1 ]; then
	if [ $1 = '-s' ]; then
		if [ $2 ]; then
			arquivo=$(grep -r $2 /usr/share/applications/ | awk -F':' '{print $1}' | uniq | head -n1)
			if [ ! -z $arquivo ]; then
				echo $arquivo
				echo $arquivo | xclip -r -selection c
			else
				echo "Nenhum arquivo encontrado."
			fi
		fi

	elif [ $1 = '-r' ]; then
		if [ -f $homedir/$(basename $2) ]; then
			nodisp -r $homedir/$(basename $2)
		fi
	elif [ -f $homedir/$(basename $1) ]; then
		nodisp $homedir/$(basename $1)
	elif [ -f $sysdir/$(basename $1) ]; then
		cp $sysdir/$(basename $1) $homedir/
		nodisp $homedir/$(basename $1)
	fi
	exit 0
fi

for app in ${apps[@]}; do
	if [ ! -f ${homedir}/${app} ]; then
		if [ -f $sysdir/$app ]; then
        	cp $sysdir/$app ${homedir}/
		fi
	fi

	[ -f ${homedir}/${app} ] && nodisp ${homedir}/${app}
done
