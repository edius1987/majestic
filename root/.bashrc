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
#### Env     #####
##################
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;36m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'

##################
#### Aliases #####
##################
# Cria um arquivo de 1GB
alias lixo='dd if=/dev/zero of=file.txt count=1024 bs=1048576'
alias cp='cp -iv'
alias rm='rm -Iv'
alias mv='mv -iv' 
alias ls='ls --color=auto --group-directories-first'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias e='exit'
alias p='sudo pacman'
alias rsync="rsync --exclude-from=${HOME}/.rsync"
alias mkdir='mkdir -pv'
alias clamscan="clamscan -i --max-filesize=50M --exclude-dir='^/sys|^/proc|^/dev'"
alias mtn="mtn -w 900 -s 90 -c 4 -h 100 -f /usr/share/fonts/TTF/Ubuntu-L.ttf -T 'Acesse: http://ultratorrent.com.br' -o ' - Thumbs.jpg'"
alias copiar='xclip -sel clip <'
alias autogit="git add . && git commit -m 'Alterações automáticas...' && git push origin master"
alias g930='G930Sidetone'
alias showip='curl icanhazip.com'
alias baixarmp3='youtube-dl --extract-audio --audio-format mp3'

# Pacman alias examples
alias pacman-clean='sudo pacman -Qdtq | pacman -Rs -'
alias pacupg='pacman -Syu'		# Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacdl='pacman -Sw'		# Download specified package(s) as .tar.xz ball
alias pacin='pacman -S'		# Install specific package(s) from the repositories
alias pacins='pacman -U'		# Install specific package not from the repositories but from a file 
alias pacre='pacman -R'		# Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='pacman -Rns'		# Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'		# Display information about a given package in the repositories
alias pacreps='pacman -Ss'		# Search for package(s) in the repositories
alias pacloc='pacman -Qi'		# Display information about a given package in the local database
alias paclocs='pacman -Qs'		# Search for package(s) in the local database
alias paclo="pacman -Qdt"		# List all packages which are orphaned
alias pacc="pacman -Scc"		# Clean cache - delete all the package files in the cache
alias paclf="pacman -Ql"		# List all files installed by a given package
alias pacown="pacman -Qo"		# Show package(s) owning the specified file(s)
alias pacexpl="pacman -D --asexp"	# Mark one or more installed packages as explicitly installed 
alias pacimpl="pacman -D --asdep"	# Mark one or more installed packages as non explicitly installed
# Additional pacman alias examples
alias pacupd='pacman -Sy && abs'         # Update and refresh the local package and ABS databases against repositories
alias pacinsd='pacman -S --asdeps'            # Install given package(s) as dependencies
alias pacmir='pacman -Syy'                    # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

##################
#### Funções #####
##################
# Man colorido
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

##################
##### Sources ####
##################
if [ -f /etc/cores.inc ]; then
	. /etc/cores.inc
fi

if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
	. /usr/share/doc/pkgfile/command-not-found.bash
fi

if [ -f /usr/share/git/completion/git-prompt.sh ]; then
	. /usr/share/git/completion/git-prompt.sh
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
    
##################
##### Prompt  ####
##################   
# Sem cor
# PS1='[\u@\h \W]\$ '

# Com cor
PS1="\[${Red}\][\[${Color_Off}\]\u@\h \W\[${Red}\]]\[${Color_Off}\]:\$ "

echo
fortune brasil
echo
