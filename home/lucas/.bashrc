#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

##################
#### Opções  #####
##################
# Checa o tamanho da janela e redimensiona
shopt -s checkwinsize

# Muda de diretório sem o cd
shopt -s autocd

# Adiciona ao histórico
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

##################
##### ENV ########
##################
if [ -d "$HOME/bin/" ] ; then
	export PATH="$HOME/bin/:$PATH"
fi

##################
#### Aliases #####
##################
# Cria um arquivo de 1GB
alias lixo='dd if=/dev/zero of=file.txt count=1024 bs=1048576'
alias rm='rm -Iv'
alias mv='mv -iv'
alias cp='cp -iv'
alias ls='ls --color=auto --group-directories-first'
alias copiar='xclip -sel clip <'

alias e='exit'
#alias s='sudo su'
alias pacman='sudo pacman'
alias mkdir='mkdir -pv'

alias neofetch='neofetch --config ~/.neofetch.conf'
alias baixarmp3='youtube-dl --extract-audio --audio-format mp3'
alias baixarlista='youtube-dl --username sistematico --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'
alias fullsync='rsync -aAXvz --exclude={"*.mp3","*.MP3","/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"}'

##################
##### Sources ####
##################
if [ -f /etc/cores.inc ]; then
	source /etc/cores.inc
fi

if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
	source /usr/share/doc/pkgfile/command-not-found.bash
fi

if [ -f /usr/share/git/completion/git-prompt.sh ]; then
	source /usr/share/git/completion/git-prompt.sh
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

if [[ $TERM == xterm-termite ]]; then
	. /etc/profile.d/vte.sh
	__vte_prompt_command
fi

##################
##### Prompt #####
##################
# Sem cor
# PS1='[\u@\h \W]\$ '

# Com cor
PS1="\[${Purple}\][\[${Color_Off}\]\u@\h \W\[${Purple}\]]\[${Color_Off}\]:\$ "
