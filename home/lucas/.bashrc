#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias e='exit'
alias s='sudo su'
alias pacman='sudo pacman'
PS1='[\u@\h \W]\$ '
