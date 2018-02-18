autoload -Uz compinit && compinit
autoload -U colors && colors

zstyle ':completion:*' rehash true
zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/lucas/.zshrc'

##############################################################################
# History Configuration
##############################################################################
HISTSIZE=10000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=10000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt incappendhistory #Immediately append to the history file, not just when a term is killed

# Default
WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
#WORDCHARS='*?_.[]~=&;!#$%^(){}<>'
WORDCHARS=$WORDCHARS:s:/:
#WORDCHARS=${WORDCHARS/\/}
#WORDCHARS=${WORDCHARS//[\/]}

setopt extendedglob notify autocd nohashdirs no_auto_remove_slash

bindkey -e
bindkey "^[[1;5C"	forward-word
bindkey "^[[1;5D"	backward-word
bindkey '\e[1~'   beginning-of-line  # Linux console
bindkey '\e[H'    beginning-of-line  # xterm
bindkey '\eOH'    beginning-of-line  # gnome-terminal
bindkey '\e[2~'   overwrite-mode     # Linux console, xterm, gnome-terminal
bindkey '\e[3~'   delete-char        # Linux console, xterm, gnome-terminal
bindkey '\e[4~'   end-of-line        # Linux console
bindkey '\e[F'    end-of-line        # xterm
bindkey '\eOF'    end-of-line        # gnome-terminal

backward-kill-dir () {
    #local WORDCHARS=${WORDCHARS/\/}
	local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
	WORDCHARS=$WORDCHARS:s:/:
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

if [ -d "$HOME/bin/" ] ; then
	export PATH="$HOME/bin/:$PATH"
fi

alias lixo='dd if=/dev/zero of=file.txt count=1024 bs=1048576'
alias cp='cp -iv'
alias rm='rm -iv'
alias mv='mv -iv' 
alias ls='ls --color=auto --group-directories-first'
alias e='exit'
alias s='sudo su'
alias p='sudo pacman'
alias pacman='sudo pacman'
alias sc='sudo systemctl'
alias rsync="rsync --exclude-from=${HOME}/.rsync"
alias mkdir='mkdir -pv'
alias clamscan="clamscan --max-filesize=50M --exclude-dir='^/sys|^/proc|^/dev'"
alias mtn="mtn -w 900 -s 90 -c 4 -h 100 -f /usr/share/fonts/TTF/Ubuntu-L.ttf -T 'Acesse: http://ultratorrent.com.br' -o ' - Thumbs.jpg'"
alias pacman-clean='sudo pacman -Qdtq | pacman -Rs -'
alias copiar='xclip -sel clip <'
alias autogit="git add . && git commit -m 'Alterações automáticas...' && git push origin master"
alias g930='sudo G930Sidetone'
alias showip='curl icanhazip.com'
alias baixarmp3='youtube-dl --extract-audio --audio-format mp3'
alias neofetch="neofetch --config ${HOME}/.neofetch.conf"
alias fullsync='rsync -aAXvz --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/var/tmp/","/lost+found",".vzfifo",".cpt_hardlink*",".autorelabel"}'

source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/git/completion/git-prompt.sh

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

PS1="[%{$fg_bold[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~%{$reset_color%}]:%% "

#. /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
