#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d "$HOME/bin" ] ; then
    #PATH="$HOME/bin:$PATH"
	export PATH=$PATH:$HOME/bin
fi

alias rm='rm -Iv'
alias mv='mv -iv'
alias cp='cp -iv'
alias ls='ls --color=auto --group-directories-first'

alias e='exit'
alias s='sudo su'
alias pacman='sudo pacman'
alias mkdir='mkdir -pv'
alias baixarmp3='youtube-dl --extract-audio --audio-format mp3'

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
