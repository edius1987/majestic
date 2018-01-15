;----------------------------------------------------------
;		        C O L O R S
;----------------------------------------------------------
; 100%: FF - 95%: F2 - 90%: E6 - 85%: D9 - 80%: CC - 75%: BF - 70%: B3 - 65%: A6 - 60%: 99 - 55%: 8C - 50%: 80 - 45%: 73 - 40%: 66 - 35%: 59 - 30%: 4D - 25%: 40 - 20%: 33 - 15%: 26 - 10%: 1A - 5%: 0D - 0%: 00
[colors]
trans = #66000000
foreground = ${xrdb:foreground}
background = ${xrdb:background}
unfocused = ${xrdb:color16}
urgent = ${xrdb:color1}

;----------------------------------------------------------
;		        B A R / T O P
;----------------------------------------------------------
[bar/top]
;monitor = ${env:MONITOR:DVI-I-0}
width = 100%
height = 30
offset-y = -1
top = true

background = ${colors.trans}
foreground = ${colors.foreground}

fixed-center = true
;tray-position = right

overline-size = 2
overline-color = #bc92f8
underline-size = 2
underline-color = #bc92f8

;spacing = 1
;padding-right = 2
module-margin-left = 0
module-margin-right = 2

font-0 = Fira:pixelsize=10;2
font-1 = FontAwesome:size=10;2
font-2 = NotoSans:pixelsize=10;2
font-3 = Fira:pixelsize=6;-2
font-4 = icomoon:size=11;3
font-5 = Moon Phases:size=11;3

modules-left = i3
modules-center = window
modules-right = gmail crypto cpu memory calendar moonphase volume wallpaper ufw powermenu

scroll-up = bspwm-desknext
scroll-down = bspwm-deskprev
;scroll-up = bspc desktop -f prev.local
;scroll-down = bspc desktop -f next.local

;----------------------------------------------------------
;		        B A R / B O T T O M
;----------------------------------------------------------
[bar/bottom]
;monitor = ${env:MONITOR:DVI-I-0}
width = 100%
height = 30
offset-y = -1
bottom = true
enable-ipc = true

background = ${colors.trans}
foreground = ${colors.foreground}

fixed-center = true

overline-size = 2
overline-color = #bc92f8
;underline-size = 2
;underline-color = #bc92f8

spacing = 1
padding-right = 2
module-margin-left = 0
module-margin-right = 2

font-0 = Fira:pixelsize=10;3
font-1 = FontAwesome:size=10;3
font-2 = NotoSans:pixelsize=10;3
font-3 = icomoon:pixelsize=11;3

modules-left = apps launch screenshot multi
modules-center = network temperature rootfs homefs pkg trash
modules-right = mpd

;----------------------------------------------------------
;		        I 3
;----------------------------------------------------------
[module/i3]
type = internal/i3

; IC              
ws-icon-0 = 1;
ws-icon-1 = 2;
ws-icon-2 = 3;
ws-icon-3 = 4;
ws-icon-4 = 5;
ws-icon-5 = 6;
ws-icon-6 = 7;
ws-icon-7 = 8;
ws-icon-8 = 9;
ws-icon-9 = 10;
;ws-icon-default = 

strip-wsnumbers = true

format = <label-state> <label-mode>
format-spacing = 0
label-font = 5

label-focused-font = 5
label-focused = %name%
label-focused-padding = 4
label-focused-foreground = #fff

label-unfocused-font = 5
label-unfocused = %name%
label-unfocused-padding = 4
label-unfocused-foreground = ${colors.unfocused}

label-urgent-font = 5
label-urgent = %name%
label-urgent-padding = 4
label-urgent-foreground = ${colors.urgent}

label-visible-font = 5
label-visible = %name%
label-visible-padding = 4

;----------------------------------------------------------
;		        B I T C O I N
;----------------------------------------------------------
[module/bitcoin]
type = custom/script
interval = 300
format = <label>
label =  %output%
exec = ~/.config/polybar/scripts/crypto.py bitcoin BRL

;----------------------------------------------------------
;		        B C A S H
;----------------------------------------------------------
[module/bcash]
type = custom/script
interval = 300
format = <label>
label =  %output%
exec = ~/.config/polybar/scripts/crypto.py bitcoin-cash BRL

;----------------------------------------------------------
;		        L I T E C O I N
;----------------------------------------------------------
[module/litecoin]
type = custom/script
interval = 300
format = <label>
label =  %output%
exec = ~/.config/polybar/scripts/crypto.py litecoin BRL

;----------------------------------------------------------
;		        E T H E R E U M
;----------------------------------------------------------
[module/ethereum]
type = custom/script
interval = 300
format = <label>
label =  %output%
exec = ~/.config/polybar/scripts/crypto.py ethereum BRL

;----------------------------------------------------------
;		        I O T A
;----------------------------------------------------------
[module/iota]
type = custom/script
interval = 300
format = <label>
label =  %output%
exec = ~/.config/polybar/scripts/crypto.py iota BRL

;----------------------------------------------------------
;		        W I N D O W
;----------------------------------------------------------
[module/window]
type = custom/script
interval = 0.1
format-prefix = " "
format-prefix-foreground = ${colors.foreground}
;label = %output:0:40:...%  %{B- -o -u}
label = %output:0:40:...%
click-left = ~/.config/polybar/scripts/janela.sh -i
click-middle = ~/.config/polybar/scripts/janela.sh -c
click-right = ~/.config/polybar/scripts/janela.sh -w
exec = ~/.config/polybar/scripts/janela.sh

;----------------------------------------------------------
;		        G M A I L
;----------------------------------------------------------
[module/gmail]
type = custom/script
interval = 300
format = <label>
label = " %output%"
exec = ~/.config/polybar/scripts/gmail/launch.py
tail = true
click-left = $BROWSER https://mail.google.com &

;----------------------------------------------------------
;		        C R Y P T O
;----------------------------------------------------------
[module/crypto]
type = custom/script
interval = 300
format = <label>
label = %output%
;exec = ~/.config/polybar/scripts/btc.sh
exec = ~/.config/polybar/scripts/crypto.py

;----------------------------------------------------------
;		        C P U
;----------------------------------------------------------
[module/cpu]
type = internal/cpu
interval = 0.5
format =  <ramp-coreload>

ramp-coreload-0-font = 4
ramp-coreload-1-font = 4
ramp-coreload-2-font = 4
ramp-coreload-3-font = 4
ramp-coreload-4-font = 4
ramp-coreload-5-font = 4
ramp-coreload-6-font = 4
ramp-coreload-7-font = 4

ramp-coreload-0 = ▁
ramp-coreload-1 = ▂
ramp-coreload-2 = ▃
ramp-coreload-3 = ▄
ramp-coreload-4 = ▅
ramp-coreload-4-foreground = #eee
ramp-coreload-5 = ▆
ramp-coreload-5-foreground = #eee
ramp-coreload-6 = ▇
ramp-coreload-6-foreground = #ff3b51
ramp-coreload-7 = █
ramp-coreload-7-foreground = #ff3b51

;----------------------------------------------------------
;		        M E M O R Y
;----------------------------------------------------------
[module/memory]
type = internal/memory
format = <label> <bar-used>
label = 
label-font = 5
bar-used-width = 8
bar-used-indicator = |
bar-used-indicator-font = 0
bar-used-fill = ─
bar-used-fill-font = 0
bar-used-empty = ─
bar-used-empty-font = 0

;----------------------------------------------------------
;			 C A L E N D A R
;----------------------------------------------------------
[module/calendar]
type = custom/script
interval = 60.0
label-font = 5
exec =  ~/.local/bin/beats.sh 3
click-left = notify-send "Data" "$(date +"%A, %d de %B de %Y")" &
click-right = gsimplecal &
click-middle = ~/.config/rofi/scripts/alarme &
label = " %output%"
format = <label>

;----------------------------------------------------------
;			 M O O N P H A S E
;----------------------------------------------------------
[module/moonphase]
type = custom/script
interval = 60.0
label-font = 6
exec =  ~/.config/polybar/scripts/moonphase.py
click-left = notify-send -i ~/.config/dunst/icons/moon.svg "Fases Lunares" "$(python2 ~/.config/polybar/scripts/moonphase.py desc)" &
label = %output%
format = <label>

;----------------------------------------------------------
;		        V O L U M E
;----------------------------------------------------------
[module/volume]
type = internal/volume
format-volume = <ramp-volume> <label-volume>
label-volume = %percentage%%
label-muted =  mudo
label-font = 5
ramp-volume-0 = 
ramp-volume-1 = 
ramp-volume-2 = 

;----------------------------------------------------------
;		        W A L L P A P E R
;----------------------------------------------------------
[module/wallpaper]
type = custom/text
content = 
click-left = ~/.local/bin/wallpaper-cycle p
click-middle = ~/.local/bin/wallpaper-cycle r
click-right = ~/.local/bin/wallpaper-cycle a
scroll-up = ~/.local/bin/wallpaper-cycle p
scroll-down = ~/.local/bin/wallpaper-cycle a

;----------------------------------------------------------
;		        U F W
;----------------------------------------------------------
[module/ufw]
type = custom/script
interval = 1
label-font = 5
exec =  ~/.config/polybar/scripts/ufw.sh
click-left = ~/.config/polybar/scripts/ufw.sh toggle
label = %output%
format = <label>

;----------------------------------------------------------
;		    P O W E R   M E N U
;----------------------------------------------------------
;#b48ead
[module/powermenu]
type = custom/menu

;label-font = 3
format-spacing = 1
format-padding = 1

label-open = ""
label-close = 
label-separator = |

menu-0-0 = "suspender"
menu-0-0-exec = menu-open-1

menu-0-1 = "reiniciar"
menu-0-1-exec = menu-open-2

menu-0-2 = "desligar"
menu-0-2-exec = menu-open-3

menu-0-3 = "sair"
menu-0-3-exec = menu-open-4

menu-1-0 = "SUSPENDER?"
menu-1-0-exec = systemctl suspend

menu-2-0 = "REINICIAR?"
menu-2-0-exec = systemctl reboot

menu-3-0 = "DESLIGAR?"
menu-3-0-exec = systemctl poweroff

menu-4-0 = "SAIR?"
menu-4-0-exec = i3-msg exit

[settings]
screenchange-reload = true

;----------------------------------------------------------
;			A P P S
;----------------------------------------------------------
[module/apps]
type = custom/menu
expand-right = true
;label-open-font = 5
;label-close-font = 5
format-spacing = 1

label-open = " "
;label-open-foreground = ${colors.foreground}
;label-open-background = ${colors.background}

label-close = " "
label-separator = " "

menu-0-0 = ""
menu-0-0-font = 5
menu-0-0-exec = firefox-developer-edition &

menu-0-1 = ""
menu-0-1-font = 5
menu-0-1-exec = thunar &

menu-0-2 = ""
menu-0-2-font = 5
menu-0-2-exec = termite &

menu-0-3 = ""
menu-0-3-font = 5
menu-0-3-exec = subl &

menu-0-4 = ""
menu-0-4-font = 5
menu-0-4-exec = telegram &

menu-0-5 = ""
menu-0-5-font = 5
menu-0-5-exec = Whatsapp &

menu-0-6 = ""
menu-0-6-font = 5
menu-0-6-exec = termite -e screencast.sh &

menu-0-7 = ""
menu-0-7-font = 5
menu-0-7-exec = steam-runtime &

menu-0-8 = ""
menu-0-8-font = 5
menu-0-8-exec = ~/apps/DevDocs-0.6.7-x86_64.AppImage &

menu-0-9 = ""
menu-0-9-font = 5
menu-0-9-exec = ~/apps/medley-latest.AppImage &


;----------------------------------------------------------
;			L A U N C H E R
;----------------------------------------------------------
[module/launch]
type = custom/text
;format = <label>
content = 
click-left = ~/.config/rofi/scripts/drun &
click-middle = ~/.config/rofi/scripts/drun &
click-right = ~/.config/rofi/scripts/drun &
;scroll-up
;scroll-down

;----------------------------------------------------------
;			S C R E E N S H O T
;----------------------------------------------------------
[module/screenshot]
type = custom/text
content = 
click-left = ~/.local/bin/screenshot &
click-right = ~/.local/bin/screenshot clear &

;----------------------------------------------------------
;			M U L T I
;----------------------------------------------------------
[module/multi]
type = custom/ipc
interval = 30
hook-0 = ~/.config/polybar/scripts/weather.py
hook-1 = ~/.config/polybar/scripts/anews.py
hook-2 = ~/.config/polybar/scripts/logs.sh
initial = 1
click-left = polybar-msg -p %pid% hook multi 1
click-right = polybar-msg -p %pid% hook multi 2
click-middle = polybar-msg -p %pid% hook multi 3
tail = true

;----------------------------------------------------------
;		        N E T W O R K
;----------------------------------------------------------
[module/network]
type = internal/network
interface = wlan0
interval = 3.0

format-connected = <label-connected>
format-disconnected = <label-disconnected>

label-connected = "%{F#F1F1F1} %{F-}%signal%% %{F#F1F1F1} %{F-}%downspeed% %{F#F1F1F1} %{F-}%upspeed%"
label-connected-foreground = ${colors.foreground}

label-disconnected = 
label-disconnected-foreground = #66ffffff

;----------------------------------------------------------
;		        T E M P 
;----------------------------------------------------------
[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 55

format = <label>
format-warn = <label-warn>

label =  %temperature%
label-warn =  %temperature%
label-warn-foreground = ${colors.urgent}

;----------------------------------------------------------
;		        F I L E S Y S T E M - /
;----------------------------------------------------------
[module/rootfs]
interval = 400
type = custom/script
exec = df -h / | awk 'NR==2 {print $5}'
;exec = df -h / | awk 'NR==2 {total=$2; used=$3; print used" / "total}'
format =  <label>
format-prefix = " " 

;----------------------------------------------------------
;		    F I L E S Y S T E M - H O M E
;----------------------------------------------------------
[module/homefs]
interval = 400
type = custom/script
exec = df -h /home | awk 'NR==2 {print $5}'
format =  <label>
format-prefix = " "

;----------------------------------------------------------
;		           U P D A T E S
;----------------------------------------------------------
[module/pkg]
type = custom/script
interval = 1200
format = <label>
format-prefix = " "
;format-prefix-foreground = ${colors.foreground}
label = "%output:0:30%"
exec = ~/.config/polybar/scripts/pkg.sh
click-left = pamac-updater &
click-middle = pamac-installer &
click-right = pamac-manager &

;----------------------------------------------------------
;		        T R A S H
;----------------------------------------------------------
[module/trash]
type = custom/script
interval = 1
format = <label>
label = "%output:0:30%"
exec = ~/.config/polybar/scripts/trash.sh
click-left = ~/.config/polybar/scripts/trash.sh -x ; exec paplay /usr/share/sounds/freedesktop/stereo/trash-empty.oga ; notify-send "Lixeira" "Lixeira limpa!"

;----------------------------------------------------------
;			M P D
;----------------------------------------------------------
[module/mpd]
type = internal/mpd
host = 127.0.0.1
port = 6600
interval = 2

format-online = <label-song> <label-time> <icon-prev> <icon-stop> <toggle> <icon-next> <icon-repeat> <icon-random>

label-song = " %artist% - %title%"
label-time = "%elapsed% / %total%"
label-stopped = 🎜
label-paused = 🎜
label-offline = 🎜

;format-playing = ${self.format-online}
;format-paused = ${self.format-stopped}
;format-stopped = ${self.format-stopped}
;format-offline = ${self.format-offline}

; Only applies if <icon-X> is used
icon-play = 
icon-pause = 
icon-stop = 
icon-prev = 
icon-next = 
icon-seekb = 
icon-seekf = 
icon-random = 
icon-repeat = 
icon-repeatone = 🔂
icon-consume = 

; Used to display the state of random/repeat/repeatone
; Only applies if <icon-[random|repeat|repeatone]> is used
toggle-on-foreground = #ff
toggle-off-foreground = #55

; Only applies if <bar-progress> is used
bar-progress-width = 8
bar-progress-indicator = |
bar-progress-fill = ─
bar-progress-empty = ─

scroll-up = mpc next
scroll-down = mpc prev
