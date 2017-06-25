#!/bin/sh

options="-p 2211 -o allow_other"

sshfs radio@artemis:/usr/local/musicas /home/lucas/sshfs/artemis $options
mc /home/lucas/audio /home/lucas/sshfs/artemis
fusermount -u /home/lucas/sshfs/artemis
