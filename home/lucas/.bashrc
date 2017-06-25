#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias e='exit'
alias s='sudo su'
alias pacman='sudo pacman'
alias mkdir='mkdir -pv'

PS1='[\u@\h \W]\$ '

if [ -f /etc/cores.inc ]; then
        . /etc/cores.inc
fi

if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
        . /usr/share/doc/pkgfile/command-not-found.bash
fi

if [[ $TERM == xterm-termite ]]; then
    . /etc/profile.d/vte.sh
    __vte_prompt_command
fi
