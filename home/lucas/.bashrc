#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Powerline
#if [[ -f /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh ]]; then
#    powerline-daemon -q
#    POWERLINE_BASH_CONTINUATION=1
#    POWERLINE_BASH_SELECT=1
#    . /usr/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
    #. /usr/lib/python2.7/site-packages/powerline/bindings/shell/powerline.sh
#fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

##################
#### Opções  #####
##################
# Ignora a caixa e alguns erros ao trocar de diretório
shopt -s cdspell

# Checa o tamanho da janela e redimensiona
shopt -s checkwinsize

# Muda de diretório sem o cd
shopt -s autocd

# Adiciona ao histórico
shopt -s histappend

# After each command, save and reload history
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND'\n'};history -a;history -c;history -r"
export PROMPT_COMMAND="history -a; history -n"

##################
##### ENV ########
##################
if [[ -d "$HOME/bin/" ]]; then
	export PATH="$HOME/bin/:$PATH"
fi

##################
#### Aliases #####
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

if [[ $TERM == xterm-termite ]]; then
	. /etc/profile.d/vte.sh
	__vte_prompt_command
fi

##################
#### Funções #####
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

#__prompt_command() {
#    local EXITCODE="$?"
#
#    local HOSTCOLOR="5"
#    local USERCOLOR="3"
#    local PATHCOLOR="4"
#
#    #PS1="\e[3${HOSTCOLOR}m \h  \e[3${USERCOLOR}m \u  \e[3${PATHCOLOR}m \w  \n";
#    PS1="\e[3${HOSTCOLOR}m \h  \e[3${USERCOLOR}m \u  \e[3${PATHCOLOR}m \w  ";
#
#    if [ $EXITCODE == 0 ]; then
#        PS1+="\e[32m\$ \e[0m";
#    else
#        PS1+="\e[31m\$ \e[0m";
#    fi
#}

echo
fortune vimtips
echo

