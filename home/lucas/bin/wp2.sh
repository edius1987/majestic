#!/usr/bin/env bash

if [ $(whoami) == "root" ]; then
    echo "Esse script precisa de privilégios do usuário root"
    exit
fi

echo -en "Instalação atutomatizada para o Wordpress\nDeseja continuar? [s/N]: "
read -r continuar

if [ "$continuar" != [sS] ]; then
	exit
fi

echo -n "Senha do usuário root do MySQL [Padrão: root]: "
read usuario_root

if [ -z $usuario_root ]; then
	usuario_root="root"
fi

echo
echo -n "Senha do usuário root do MySQL: "
read -r senha_root


cat << EOF > /tmp/wp.sql
CREATE DATABASE banco;
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
ON banco.*
TO user@localhost
IDENTIFIED BY 'senha';
FLUSH PRIVILEGES;
EOF

cat /tmp/wp.sql | mysql -u root -psenha