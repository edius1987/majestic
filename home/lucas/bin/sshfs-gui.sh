#!/bin/sh

# mc, thunar, caja, nautilus, etc...
app=mc
porta=2211

which sshfs >/dev/null 2>&1 || { echo >&2 "O programa sshfs não está instalado. Abortando."; exit 1; }
which $app >/dev/null 2>&1 || { echo >&2 "O programa $app não está instalado. Abortando."; exit 1; }

if grep -Fxq "#user_allow_other" /etc/fuse.conf
then
    echo "A opção user_allow_other está comentada no arquivo /etc/fuse.conf. Abortando..."
		exit 1
else
    echo "A opção user_allow_other está descomentada no arquivo /etc/fuse.conf. Continuando..."
fi

options="-p ${porta} -o allow_other"

read -p "Usuario: " usuario
usuario=${usuario:-$(whoami)}

num=0

while [ ! ${host} ] || [ ! $ok ]; do
	let num="num + 1"
	read -p "Host: " host

	if [ "$num" -gt 10 ]; then
		echo "Abortando..."
		exit 1
	fi

	if [ "${host}" ]; then

		ping -q -c5 $host > /dev/null 2> /dev/null

		if [ $? -eq 0 ]
		then
			ok=true
			echo "Host: $host encontrado."
			echo "Prosseguindo..."

		#while [ ! ${checa_porta} ] && [ ! $porta ]; do

		#	exec 6<>/dev/tcp/${host}/${porta} && "Porta do SSH encontrada!" && checa_porta=true || echo "Porta do SSH não encontrada. Digite uma nova porta."
		#	exec 6>&- # close output connection
		#	exec 6<&- # close input connection

		#	if [ ! ${checa_porta} ]; then
		#		read -p "Porta: " porta
		#	fi

		#done

		else
			echo "Host: $host não encontrado."
			echo "Tente novamente..."
			echo "${num}ª tentativa..."
		fi

	else
		echo "Host não digitado, digite um host..."
		echo "${num}ª tentativa..."
	fi
done

dir="${HOME}/sshfs/${host}"

if [ ! -d ${dir} ]; then
	echo "Criando ${dir}..."
	mkdir -p ${HOME}/sshfs/${host}
fi

read -p "Caminho remoto: " remoto
remoto=${remoto:-"/"}

sshfs ${usuario}@${host}:${remoto} $dir $options
$app ~ $dir
fusermount -u ${dir}
