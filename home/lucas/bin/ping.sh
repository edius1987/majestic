#!/bin/bash

#host="127.0.0.1"
host="8.8.8.8"
retries=1

ping -q -c${retries} $host > /dev/null 2> /dev/null

if [ $? -eq 0 ]; then
	echo -e "Conexão: \033[0;32mOK\033[0m"
else
	echo -e "Conexão: \033[0;31mFALHOU\033[0m"
fi
