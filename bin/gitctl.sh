#!/usr/bin/env bash
#
# Arquivo: gitctl.sh
#
# Feito por Lucas Saliés Brum, lucas@archlinux.com.br
#
# Criado em: 2018-05-24 16:09:58
# Última alteração: 2018-05-24 16:12:48
#
# Source: https://gist.github.com/alexpchin/dc91e723d4db5018fef8
#
# Copie sua chave pública para o github.

novo() {
	touch README.md
	git init
	git add README.md
	git commit -m "first commit"
	git remote add origin git@github.com:alexpchin/<reponame>.git
	git push -u origin master
}

existente() {
	git remote add origin git@github.com:alexpchin/<reponame>.git
	git push -u origin master
}

curl "https://api.github.com/users/sistematico/repos?per_page=100" | grep -o 'git@[^"]*'