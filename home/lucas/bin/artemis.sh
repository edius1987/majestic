#!/bin/bash

options="-p 2211 -o allow_other"

#sshfs radio@artemis:/usr/local/musicas /home/lucas/sshfs/artemis $options
#mc /home/lucas/audio /home/lucas/sshfs/artemis
#fusermount -u /home/lucas/sshfs/artemis

os=$(dialog --menu "OS info" 10 40 3 1 "Linux" 2 "Solaris" 3 "HPUX" 3>&1 1>&2 2>&3)

echo $os
