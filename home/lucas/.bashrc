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
if [ -f .bash_aliases ]; then
    source .bash_aliases
fi

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

echo
fortune vimtips
echo

PATH="/home/lucas/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/lucas/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lucas/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lucas/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lucas/perl5"; export PERL_MM_OPT;
