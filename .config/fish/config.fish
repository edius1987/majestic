#################
###   ENV     ###
#################
set -x -g PATH $HOME/bin/ $PATH
set -x -g BROWSER chromium
set -x -g WALLPAPERS ~/img/elementary
set -x -g GH $HOME/github/caos
set -x -g TIMESTAMP (date +"%Y-%m-%d_%H-%M-%S")
set -x -g STEAM_FRAME_FORCE_CLOSE 1

# Man colorido
set -x -g LESS_TERMCAP_md (printf "\e[01;31m")
set -x -g LESS_TERMCAP_me (printf "\e[0m")
set -x -g LESS_TERMCAP_se (printf "\e[0m")
set -x -g LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x -g LESS_TERMCAP_ue (printf "\e[0m")
set -x -g LESS_TERMCAP_us (printf "\e[01;32m")

#if status --is-login
#    set PATH $HOME/bin/ $PATH
#end

#################
### OPTIONS   ###
#################
set fish_greeting ""

#################
### ALIASES   ###
#################
# Cria um arquivo de 1GB
alias lixo='dd if=/dev/zero of=file.txt count=1024 bs=1048576'
alias cp='acp -ivg'
alias rm='rm -Iv'
alias mv='amv -ivg' 
alias ls='ls --color=auto --group-directories-first'
alias e='exit'
alias s='sudo su'
alias p='sudo pacman'
alias pacman='sudo pacman'
alias sc='sudo systemctl'
alias rsync="rsync --exclude-from=$HOME/.rsync"
alias mkdir='mkdir -pv'
alias clamscan="clamscan --max-filesize=50M --exclude-dir='^/sys|^/proc|^/dev'"
alias mtn="mtn -w 900 -s 90 -c 4 -h 100 -f /usr/share/fonts/TTF/Ubuntu-L.ttf -T 'Acesse: http://ultratorrent.com.br' -o ' - Thumbs.jpg'"
alias pacman-clean="sudo pacman -Rns (pacman -Qtdq)"
alias paclean="sudo pacman -Rns (pacman -Qtdq)"
alias copiar='xclip -sel clip <'
alias autogit="git add . ; git commit -m 'Alterações automáticas...' ; git push origin master"
alias g930='sudo G930Sidetone'
alias showip='curl icanhazip.com'
alias baixarmp3='youtube-dl --extract-audio --audio-format mp3'
alias fullsync='rsync -aAXvz --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/var/tmp/","/lost+found",".vzfifo",".cpt_hardlink*",".autorelabel"}'

# Pacman alias examples
alias pacupg='sudo pacman -Syu'		# Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacdl='pacman -Sw'		# Download specified package(s) as .tar.xz ball
alias pacin='sudo pacman -S'		# Install specific package(s) from the repositories
alias pacins='sudo pacman -U'		# Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'		# Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'		# Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'		# Display information about a given package in the repositories
alias pacreps='pacman -Ss'		# Search for package(s) in the repositories
alias pacloc='pacman -Qi'		# Display information about a given package in the local database
alias paclocs='pacman -Qs'		# Search for package(s) in the local database
alias paclo="pacman -Qdt"		# List all packages which are orphaned
alias pacc="sudo pacman -Scc"		# Clean cache - delete all the package files in the cache
alias paclf="pacman -Ql"		# List all files installed by a given package
alias pacown="pacman -Qo"		# Show package(s) owning the specified file(s)
alias pacexpl="pacman -D --asexp"	# Mark one or more installed packages as explicitly installed 
alias pacimpl="pacman -D --asdep"	# Mark one or more installed packages as non explicitly installed
# Additional pacman alias examples
alias pacupd='sudo pacman -Sy ; sudo abs'         # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps'            # Install given package(s) as dependencies
alias pacmir='sudo pacman -Syy'                    # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

# Yaourt
alias yupdate='yaourt -Syu --aur --noconfirm'

# Orfãos
alias orfaos='sudo lostfiles strict | egrep -vi "^/etc/ca-certificates|^/etc/ssl/certs|^/usr/share/mime|^/var/cache|/usr/share/fonts|/usr/share/icons|/usr/lib/python3.6|/usr/lib/python2.7|/etc/X11|/etc/systemd/user|^/default|^/boot|^/usr/share/locale"'

# SystemD
alias systemd-failed='systemctl list-units --state=failed'

# LibTrash
alias mc='env LD_PRELOAD=/usr/lib/libtrash.so.3.3 mc'

#################
### FUNCTIONS ###
#################
function fish_greeting
    echo
	fortune vimtips    
	#fortune brasil
    echo
end

# goo.gl
function goo
    curl 'https://www.googleapis.com/urlshortener/v1/url?key=AIzaSyBHZxWX6xn7kQSpS3wuAqjUj4fzaDpzr34' \
	-H 'Content-Type: application/json' \
	-d '{"longUrl": {$argv}}'
end  

# ix.io
function ix
    cat {$argv} | curl -F 'f:1=<-' ix.io
end

# Delete
function ixdel
    curl -n -X DELETE ix.io/{$argv}
end

function gitio
    curl -i https://git.io -F "url={$argv}"
end

function bitly
	curl 'http://api.bit.ly/v3/shorten?login=sistematico&apiKey=R_45aedce35bf656b5cd65510d2043dc5a&longURL={$argv}&format=txt'
end

function mma
    mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$argv"
end

function mm
    mpv --profile=ytb2 ytdl://ytsearch10:"$argv"
end


