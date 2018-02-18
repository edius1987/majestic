;----------------------------------------------------------
;		        C O L O R S
;----------------------------------------------------------
; 100%=FF - 95%=F2 - 90%=E6 - 85%=D9 - 80%=CC - 75%=BF - 70%=B3 - 65%=A6 - 60%=99 - 55%=8C - 50%=80
; 45%=73 - 40%=66 - 35%=59 - 30%=4D - 25%=40 - 20%=33 - 15%=26 - 10%=1A - 5%=0D - 0%=00
[colors]
background = #99000000
fbackground = #B3000000
current-line = #44475a
selection = #44475a
foreground = #eee
cyan = #8be9fd
green = #50fa7b
orange = #ffb86c
pink = #ff79c6
purple = #bd93f9
red = #ff5555
yellow = #f1fa8c
white = #F1F1F1
preto = #2B303B
borders = #4c566a
selected = #191b21

; Nord Theme
azul1 = #5e81ac
azul2 = #81a1c1
vermelho = #bf616a
laranja = #d08770
amarelo = #ebcb8b
verde = #a3be8c
rosa = #ff4279
branco1 = #d8dee9
branco2 = #e5e9f0
branco3 = #eceff4
cinza1 = #2e3440
cinza2 = #3b4252
cinza3 = #434c5e
cinza4 = #4c566a

[settings]
throttle-ms = 50
throttle-limit = 5

;----------------------------------------------------------
;		        B A R / T O P
;----------------------------------------------------------
[bar/top]
monitor = ${env:MONITOR:DVI-I-0}
width = 100%
height = 32
offset-y = -1
top = true

background = ${colors.background}
foreground = ${colors.foreground}

fixed-center = true
;tray-position = right

;overline-size = 2
;overline-color = #bc92f8
underline-size = 2
underline-color = #bc92f8

spacing = 1
padding-right = 2
module-margin-left = 0
module-margin-right = 2

font-0 = NotoSans:pixelsize=11;2
font-1 = FontAwesome:size=10;2
font-2 = Unifont:size=5;-2
font-3 = FontAwesome:size=8;3

modules-left = i3
modules-center = window
modules-right = gmail crypto cpu memory calendar volume powermenu

scroll-up = bspwm-desknext
scroll-down = bspwm-deskprev
;scroll-up = bspc desktop -f prev.local
;scroll-down = bspc desktop -f next.local

;----------------------------------------------------------
;		        B A R / B O T T O M
;----------------------------------------------------------
[bar/bottom]
monitor = ${env:MONITOR:DVI-I-0}
width = 100%
height = 32
offset-y = -1
bottom = true
enable-ipc = true

background = ${colors.background}
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

font-0 = NotoSans:pixelsize=11;3
font-1 = FontAwesome:size=10;2
font-2 = ypn envypn:size=10;0
font-3 = xos4 Terminus:size=8;-10
font-4 = Unifont:size=6;0

modules-left = apps multi
modules-center = network temperature rootfs homefs pkg trash
modules-right = mpd

;----------------------------------------------------------
;		        I 3
;----------------------------------------------------------
[module/i3]
type = internal/i3

; IC              
ws-icon-0 = 1; 
ws-icon-1 = 2; 
ws-icon-2 = 3;
ws-icon-3 = 4; 
ws-icon-4 = 5; 
ws-icon-5 = 6; 
ws-icon-6 = 7; 
ws-icon-7 = 8; 
ws-icon-8 = 9; 
ws-icon-9 = 10; 
;ws-icon-default = 

strip-wsnumbers = true

format = <label-state> <label-mode>
format-spacing = 0

label-focused = %name%
label-focused-padding = 4
;label-focused-margin = 1
label-focused-font = 3
label-focused-foreground = #fff
label-focused-background = ${colors.background}
label-focused-underline= #ddd

label-unfocused = %name%
label-unfocused-padding = 4
;label-unfocused-margin = 1
label-unfocused-background = ${colors.background}
label-unfocused-font = 3

label-urgent = %name%
label-urgent-padding = 4
;label-urgent-margin = 1
label-urgent-font = 3
label-urgent-foreground = ${colors.vermelho}
label-urgent-background = ${colors.background}

label-visible = %name%
label-visible-padding = 4
;label-visible-margin = 1
label-visible-font = 3

;----------------------------------------------------------
;		        W I N D O W
;----------------------------------------------------------
[module/window]
type = custom/script
interval = 0.1
format-prefix = " "
format-prefix-foreground = ${colors.white}
;label = %output:0:40:...%  %{B- -o -u}
label = %output:0:40:...%
;label-font = 3
click-left = ~/.config/polybar/scripts/janela.sh -i
click-middle = ~/.config/polybar/scripts/janela.sh -c
click-right = ~/.config/polybar/scripts/janela.sh -w
exec = ~/.config/polybar/scripts/janela.sh

;----------------------------------------------------------
;		        G M A I L
;----------------------------------------------------------
[module/gmail]
type = custom/script
format = <label>
label = " %output%"
exec = ~/.config/polybar/scripts/gmail/launch.py
tail = true
click-left = $BROWSER https://mail.google.com

;----------------------------------------------------------
;		        C R Y P T O
;----------------------------------------------------------
[module/crypto]
type = custom/script
interval = 300
format = <label>
label = " %output% "
exec = ~/.config/polybar/scripts/btc.sh

;----------------------------------------------------------
;		        C P U
;----------------------------------------------------------
[module/cpu]
type = internal/cpu
interval = 0.5
format = <label> <ramp-coreload>
label = 

ramp-coreload-0 = ▁
ramp-coreload-0-font = 3
ramp-coreload-0-foreground = ${colors.foreground}
ramp-coreload-1 = ▂
ramp-coreload-1-font = 3
ramp-coreload-1-foreground = ${colors.foreground}
ramp-coreload-2 = ▃
ramp-coreload-2-font = 3
ramp-coreload-2-foreground = ${colors.foreground}
ramp-coreload-3 = ▄
ramp-coreload-3-font = 3
ramp-coreload-3-foreground = ${colors.foreground}
ramp-coreload-4 = ▅
ramp-coreload-4-font = 3
ramp-coreload-4-foreground = #eee
ramp-coreload-5 = ▆
ramp-coreload-5-font = 3
ramp-coreload-5-foreground = #eee
ramp-coreload-6 = ▇
ramp-coreload-6-font = 3
ramp-coreload-6-foreground = #ff3b51
ramp-coreload-7 = █
ramp-coreload-7-font = 3
ramp-coreload-7-foreground = #ff3b51

;----------------------------------------------------------
;		        M E M O R Y
;----------------------------------------------------------
[module/memory]
type = internal/memory
format = <label> <bar-used>
label = 
bar-used-width = 8
bar-used-indicator = |
bar-used-indicator-font = 2
;bar-used-indicator-foreground = ${colors.vermelho}
bar-used-fill = ─
bar-used-fill-font = 2
;bar-used-fill-foreground = ${colors.vermelho}
bar-used-empty = ─
bar-used-empty-font = 2
;bar-used-empty-foreground = #000

;----------------------------------------------------------
;			 C A L E N D A R
;----------------------------------------------------------
[module/calendar]
type = custom/script
interval = 60.0
exec =  ~/.local/bin/beats.sh 3
click-left = notify-send "Data" "$(date +"%A, %d de %B de %Y")" &
click-right = gsimplecal &
click-middle = ~/.config/rofi/scripts/alarme &
label = " %output%"
format = <label>

;----------------------------------------------------------
;		        V O L U M E
;----------------------------------------------------------
[module/volume]
type = internal/volume
label-volume =  %percentage%%
label-muted = 

;----------------------------------------------------------
;		    P O W E R   M E N U
;----------------------------------------------------------
;#b48ead
[module/powermenu]
type = custom/menu

label-font = 3
format-spacing = 1
format-padding = 1

label-open = " "
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

label-open = "  "
;label-open-foreground = ${colors.foreground}
;label-open-background = ${colors.background}

label-close = " "
label-close-foreground = ${colors.yellow}
label-separator = " "
label-separator-foreground = ${colors.white}

menu-0-0 = ""
menu-0-0-font = 5
menu-0-0-exec = firefox-developer &

menu-0-1 = ""
menu-0-1-font = 5
menu-0-1-exec = thunar &

menu-0-2 = ""
menu-0-2-font = 5
menu-0-2-exec = termite &

menu-0-3 = ""
menu-0-3-font = 5
menu-0-3-exec = telegram &

menu-0-4 = " "
menu-0-4-font = 5
menu-0-4-exec = Whatsapp &

menu-0-5 = " "
menu-0-5-font = 5
menu-0-5-exec = termite -e screencast.sh &

;----------------------------------------------------------
;			M U L T I
;----------------------------------------------------------
[module/multi]
type = custom/ipc
interval = 30
hook-0 = ~/.config/polybar/scripts/anews.py
hook-1 = ~/.config/polybar/scripts/weather.py
hook-2 = ~/.config/polybar/scripts/logs.sh
initial = 1
click-left = polybar-msg -p %pid% hook multi 1
click-right = polybar-msg -p %pid% hook multi 2
click-middle = polybar-msg -p %pid% hook multi 3
tail = true

;----------------------------------------------------------
;			L A U N C H E R S
;----------------------------------------------------------
[module/firefox]
type = custom/text
content = "  "
click-left = firefox-developer &

[module/thunar]
type = custom/text
content = "  "
click-left = thunar &

[module/termite]
type = custom/text
content = "  "
click-left = termite &

[module/telegram]
type = custom/text
content = "  "
click-left = telegram &

[module/whatsapp]
type = custom/text
content = "  "
click-left = Whatsapp &

;----------------------------------------------------------
;			    W E A T H E R
;----------------------------------------------------------
[module/weather]
type = custom/script
interval = 10
format = <label>
exec = ~/.config/polybar/scripts/weather.py

;----------------------------------------------------------
;		        N E T W O R K
;----------------------------------------------------------
[module/network]
type = internal/network
interface = wlan0
interval = 3.0

format-connected = <label-connected>

format-disconnected = <label-disconnected>

label-connected = "%{F#F1F1F1} %{F-}%signal%% %{F#F1F1F1} %{F-}%downspeed% %{F#F1F1F1} %{F-}%upspeed%"
label-connected-foreground = ${colors.foreground}

label-disconnected = desconectado
label-disconnected-foreground = #66ffffff

;----------------------------------------------------------
;		        T E M P 
;----------------------------------------------------------
[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 60

format = <ramp><label>
format-warn = <ramp><label-warn>

label = %temperature%
label-warn = "%temperature% "
label-warn-foreground = ${colors.red}

ramp-0 = " "
ramp-1 = " "
ramp-2 = " "
ramp-foreground = ${colors.white}

;----------------------------------------------------------
;		        F I L E S Y S T E M - /
;----------------------------------------------------------
[module/rootfs]
interval = 400
type = custom/script
exec = df -h / | awk 'NR==2 {print $5}'
;exec = df -h / | awk 'NR==2 {total=$2; used=$3; print used" / "total}'
format =  <label>
format-prefix = " " 
format-prefix-foreground = ${colors.white}

;----------------------------------------------------------
;		    F I L E S Y S T E M - H O M E
;----------------------------------------------------------
[module/homefs]
interval = 400
type = custom/script
exec = df -h /home | awk 'NR==2 {print $5}'
format =  <label>
format-prefix = " "
format-prefix-foreground = ${colors.white}

;----------------------------------------------------------
;		           U P D A T E S
;----------------------------------------------------------
[module/pkg]
type = custom/script
interval = 1200
format = <label>
format-prefix = " "
;format-prefix-foreground = ${colors.white}
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
format-prefix = " "
format-prefix-foreground = ${colors.white}
label = "%output:0:30%"
exec = ~/.config/polybar/scripts/trash.sh
click-left = ~/.config/polybar/scripts/trash.sh -x && notify-send "Lixeira" "Lixeira limpa!"

;----------------------------------------------------------
;			M P D
;----------------------------------------------------------
[module/mpd]
type = internal/mpd

host = 127.0.0.1
port = 6600
;password = mysecretpassword

; Seconds to sleep between progressbar/song timer sync
; Default: 1
interval = 2

; Available tags:
;   <label-song> (default)
;   <label-time>
;   <bar-progress>
;   <toggle> - gets replaced with <icon-(pause|play)>
;   <toggle-stop> - gets replaced with <icon-(stop|play)>
;   <icon-random>
;   <icon-repeat>
;   <icon-repeatone>
;   <icon-consume>
;   <icon-prev>
;   <icon-stop>
;   <icon-play>
;   <icon-pause>
;   <icon-next>
;   <icon-seekb>
;   <icon-seekf>
;format-online = <label-song> <label-time> <icon-prev> <icon-seekb> <icon-stop> <toggle> <icon-seekf> <icon-next>  <icon-repeat> <icon-random> <bar-progress>
format-online = <label-song> <label-time> <icon-prev> <icon-stop> <toggle> <icon-next> <icon-repeat> <icon-random>
;format-playing = ${self.format-online}
;format-paused = ${self.format-online}
format-paused = " <toggle>"
;format-stopped = ${self.format-online}
format-stopped = " <toggle>"

; Available tags:
;   <label-offline>
format-offline = <label-offline>

; Available tokens:
;   %artist%
;   %album%
;   %date%
;   %title%
; Default: %artist% - %title%
label-song = " %artist% - %title%"

; Available tokens:
;   %elapsed%
;   %total%
; Default: %elapsed% / %total%
label-time = "%elapsed% / %total%"

; Available tokens:
;   None
label-offline = 

; Only applies if <icon-X> is used
icon-play = 
icon-pause = 
icon-stop = 
icon-prev = 
icon-next = 
icon-seekb = 
icon-seekf = 
icon-random = 🔀
icon-repeat = 
icon-repeatone = 🔂
icon-consume = ✀

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
