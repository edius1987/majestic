#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#	source /etc/profile.d/vte.sh
#fi

##################
##### Opções  ####
##################
# Ignora a caixa e alguns erros ao trocar de diretório
shopt -s cdspell

# Checa o tamanho da janela e redimensiona
shopt -s checkwinsize

# Muda de diretório sem o cd
shopt -s autocd

##################
##### History  ###
##################
# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups

# Size
export HISTSIZE=10000
export HISTFILESIZE=10000

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
#export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

##################
##### ENV ########
##################
# New path -> /etc/systemd/user.conf
#if [[ -d "$HOME/bin/" ]]; then
#	export PATH="$HOME/bin/:$PATH"
#fi

##################
##### Aliases ####
##################
if [[ -f ~/.bash_aliases ]]; then
    source ~/.bash_aliases
fi

##################
##### Sources ####
##################
if [[ -f /etc/cores.inc ]]; then
	source /etc/cores.inc
fi

if [[ -f /usr/share/doc/pkgfile/command-not-found.bash ]]; then
	source /usr/share/doc/pkgfile/command-not-found.bash
fi

if [[ -f /usr/share/git/completion/git-prompt.sh ]]; then
	source /usr/share/git/completion/git-prompt.sh
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

#if [[ $TERM == xterm-termite ]]; then
#	. /etc/profile.d/vte.sh
#	__vte_prompt_command
#fi

#if [[ -f /etc/profile.d/autojump.sh ]]; then
#	source /etc/profile.d/autojump.sh
#fi
##################
##### Funções ####
##################
function mm() {
    mpv --profile=youtube ytdl://ytsearch10:"$@"
}

function mma() {
    mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$@"
}

##################
##### Prompt #####
##################
# Sem cor
#PS1='[\u@\h \W]\$ '

# Com cor
PS1="\[${Purple}\][\[${Color_Off}\]\u@\h \W\[${Purple}\]]\[${Color_Off}\]:\$ "

# PS1 Setup
#PROMPT_COMMAND=__prompt_command

##################
##### Powerline ##
##################

#echo
#fortune vimtips
#echo

