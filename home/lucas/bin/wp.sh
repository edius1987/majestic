#!/usr/bin/env bash
# 
# Por: Lucas Saliés Brum, a.k.a. sistematico <lucas@archlinux.com.br>
# Criado em: 23/01/2018 18:08:09
# Última atualização: 23/01/2018 18:08:20

if [ $(whoami) == "root" ]; then
    echo "Esse script precisa de privilégios do usuário root"
    exit
fi

echo -en "Instalação atutomatizada para o Wordpress\nDeseja continuar? [s/N]: "
read -r continuar

if [[ $continuar != [sS] ]]; then
	exit
fi

echo
echo -n "Senha do usuário root do MySQL [Padrão: root]: "
read usuario_root

echo
echo -n "Senha do usuário root do MySQL [Padrão: wordpress]: "
read -r senha_root

echo
echo -n "Nome do host do wordpress [Padrão: localhost]: "
read -r host

echo
echo -n "Nome do banco de dados do wordpress [Padrão: wordpress]: "
read -r banco

echo
echo -n "Nome do usuario do banco de dados do wordpress [Padrão: wordpress]: "
read -r usuario

echo
echo -n "Nome da senha do banco de dados do wordpress [Padrão: wordpress]: "
read -r senha

if [ -z $usuario_root ]; then
	usuario_root="root"
fi

if [ -z $senha_root ]; then
	senha_root="wordpress"
fi

if [ -z $host ]; then
	host="localhost"
fi

if [ -z $banco ]; then
	banco="wordpress"
fi

if [ -z $usuario ]; then
	usuario="wordpress"
fi

if [ -z $senha ]; then
	senha="wordpress"
fi

cat << EOF > /tmp/wp.sql
CREATE DATABASE ${banco};
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
ON ${banco}.*
TO ${usuario}@${host}
IDENTIFIED BY '${senha}';
FLUSH PRIVILEGES;
EOF

cat /tmp/wp.sql | mysql -u $usuario_root -p${senha_root}