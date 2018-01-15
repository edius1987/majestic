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
width = 100%
height = 30
offset-y = -1
top = true

background = ${colors.trans}
foreground = ${colors.foreground}

fixed-center = true

overline-size = 2
overline-color = #bc92f8
underline-size = 2
underline-color = #bc92f8

;spacing = 1
;padding-right = 2
module-margin-left = 0
module-margin-right = 2

font-0 = Fira:size=10;2
font-1 = feather:pixelsize=11;3
font-2 = Moon Phases:size=10;4

modules-left = i3
modules-center = window
modules-right = calendar clock beats moonphase volume wallpaper ufw powermenu

;scroll-up = bspwm-desknext
;scroll-down = bspwm-deskprev

;----------------------------------------------------------
;		        B A R / B O T T O M
;----------------------------------------------------------
[bar/bottom]
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

spacing = 1
padding-right = 2
module-margin-left = 0
module-margin-right = 2

font-0 = Fira:size=10;2
font-1 = feather:pixelsize=11;2
font-2 = Fira:size=7;-2

modules-left = apps launch screencast screenshot
modules-center = cpu memory network temperature rootfs homefs trash
modules-right = mpd

;----------------------------------------------------------
;		        I 3
;----------------------------------------------------------
[module/i3]
type = internal/i3

ws-icon-0 = 1;
ws-icon-1 = 2;
ws-icon-2 = 3;
ws-icon-3 = 4;
ws-icon-4 = 5;
ws-icon-5 = 6;
ws-icon-6 = 7;
ws-icon-7 = 8;
ws-icon-8 = 9;
ws-icon-9 = 10;
;ws-icon-default = 

strip-wsnumbers = true

format = <label-state> <label-mode>
format-spacing = 0
label-font = 2

label-focused-font = 2
label-focused = %name%
label-focused-padding = 4
label-focused-foreground = #fff

label-unfocused-font = 2
label-unfocused = %name%
label-unfocused-padding = 4
label-unfocused-foreground = ${colors.unfocused}

label-urgent-font = 2
label-urgent = %name%
label-urgent-padding = 4
label-urgent-foreground = ${colors.urgent}

label-visible-font = 2
label-visible = %name%
label-visible-padding = 4

;----------------------------------------------------------
;		        W I N D O W
;----------------------------------------------------------
[module/window]
type = custom/script
interval = 0.1
format-prefix = " "
format-prefix-foreground = ${colors.foreground}
;label = %output:0:45:...%  %{B- -o -u}
label = %output:0:50:...%
click-left = ~/.config/polybar/scripts/janela.sh -i
click-middle = ~/.config/polybar/scripts/janela.sh -c
click-right = ~/.config/polybar/scripts/janela.sh -w
exec = ~/.config/polybar/scripts/janela.sh

;----------------------------------------------------------
;			 C A L E N D A R
;----------------------------------------------------------
[module/calendar]
type = custom/script
interval = 60.0
exec =  ~/.config/polybar/scripts/calendar.sh short
click-left = notify-send "Data" "$(date +"%A, %d de %B de %Y")" &
click-right = gsimplecal &
click-middle = ~/.config/rofi/scripts/alarme &
label = " %output%"
format = <label>

;----------------------------------------------------------
;			 C L O C K
;----------------------------------------------------------
[module/clock]
type = custom/script
interval = 1
exec =  ~/.config/polybar/scripts/clock.sh 1
click-left = ~/.config/rofi/scripts/alarme &
label = " %output%"
format = <label>

;----------------------------------------------------------
;			 B E A T S
;----------------------------------------------------------
[module/beats]
type = custom/script
exec =  ~/.config/polybar/scripts/beats.sh
click-left = ~/.config/rofi/scripts/alarme &
label = " %output%"
format = <label>

;----------------------------------------------------------
;			 M O O N P H A S E
;----------------------------------------------------------
[module/moonphase]
type = custom/script
interval = 60.0
label-font = 3
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
label-muted =  mudo
ramp-volume-0 = 
ramp-volume-1 = 
ramp-volume-2 = 

;----------------------------------------------------------
;		        W A L L P A P E R
;----------------------------------------------------------
[module/wallpaper]
type = custom/text
content = 
click-left = ~/.config/polybar/scripts/wallpaper.sh p &
click-middle = ~/.config/rofi/scripts/wallpaper &
click-right = ~/.config/polybar/scripts/wallpaper.sh a &
scroll-up = ~/.config/polybar/scripts/wallpaper.sh p &
scroll-down = ~/.config/polybar/scripts/wallpaper.sh a &

;----------------------------------------------------------
;		        U F W
;----------------------------------------------------------
[module/ufw]
type = custom/script
interval = 1
;label-font = 3
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
format-spacing = 1
;format-padding = 1

label-open = " "
label-close = " "
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
;format-spacing = 1

label-open = " "
label-close = " "
label-separator = " "

menu-0-0 = 
menu-0-0-exec = firefox-developer-edition &

menu-0-1 = 
menu-0-1-exec = thunar &

menu-0-2 = 
menu-0-2-exec = termite &

menu-0-3 = 
menu-0-3-exec = subl &

menu-0-4 = 
menu-0-4-exec = telegram &

menu-0-5 = 
menu-0-5-exec = Whatsapp &

menu-0-7 = 
menu-0-7-exec = steam-runtime &

menu-0-8 = 
menu-0-8-exec = ~/apps/DevDocs-0.6.7-x86_64.AppImage &

menu-0-9 = 
menu-0-9-exec = ~/apps/medley-latest.AppImage &

;----------------------------------------------------------
;			L A U N C H E R
;----------------------------------------------------------
[module/launch]
type = custom/text
content = 
click-left = ~/.config/rofi/scripts/drun &
click-middle = ~/.config/rofi/scripts/drun &
click-right = ~/.config/rofi/scripts/drun &

;----------------------------------------------------------
;			S C R E E N C A S T
;----------------------------------------------------------
[module/screencast]
type = custom/text
content = 
click-left = termite -e screencast.sh &

;----------------------------------------------------------
;			S C R E E N S H O T
;----------------------------------------------------------
[module/screenshot]
type = custom/text
content = 
click-left = ~/.local/bin/screenshot &
click-right = ~/.local/bin/screenshot clear &

;----------------------------------------------------------
;		        C P U
;----------------------------------------------------------
[module/cpu]
type = internal/cpu
interval = 0.5
format = <label> <ramp-coreload>
label = 

ramp-coreload-0-font = 3
ramp-coreload-1-font = 3
ramp-coreload-2-font = 3
ramp-coreload-3-font = 3
ramp-coreload-4-font = 3
ramp-coreload-5-font = 3
ramp-coreload-6-font = 3
ramp-coreload-7-font = 3

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
label = 
bar-used-width = 7
bar-used-indicator = |
bar-used-indicator-font = 0
bar-used-fill = ─
bar-used-fill-font = 0
bar-used-empty = ─
bar-used-empty-font = 0

;----------------------------------------------------------
;		        N E T W O R K
;----------------------------------------------------------
[module/network]
type = internal/network
interface = wlan0
interval = 3.0

format-connected = <label-connected>
format-disconnected = <label-disconnected>

label-connected = "%{F#F1F1F1} %{F-}%signal%% %{F#F1F1F1} %{F-}%downspeed% %{F#F1F1F1} %{F-}%upspeed%"
label-connected-foreground = ${colors.foreground}

label-disconnected = 
label-disconnected-foreground = #66ffffff

;----------------------------------------------------------
;		        T E M P 
;----------------------------------------------------------
[module/temperature]
type = internal/temperature
thermal-zone = 0
warn-temperature = 50

format = <label>
format-warn = <label-warn>

label = " %temperature%"
label-warn = " %temperature%"
label-warn-foreground = ${colors.urgent}

;----------------------------------------------------------
;		        F I L E S Y S T E M - /
;----------------------------------------------------------
[module/rootfs]
interval = 400
type = custom/script
exec = df -h / | awk 'NR==2 {print $5}'
format =  <label>
format-prefix = " " 

;----------------------------------------------------------
;		    F I L E S Y S T E M - H O M E
;----------------------------------------------------------
[module/homefs]
interval = 400
type = custom/script
exec = df -h /home | awk 'NR==2 {print $5}'
format =  <label>
format-prefix = " "

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

format-online = <label-song> <label-time> <icon-prev> <icon-stop> <toggle> <icon-next> <icon-repeat> <icon-repeatone> <icon-random> <icon-consume>
format-stopped = <toggle>

label-song = " %artist% - %title%"
label-time = "%elapsed% / %total%"
label-stopped = 
label-paused = 
label-offline = 

;format-playing = ${self.format-online}
;format-paused = ${self.format-stopped}
;format-stopped = ${self.format-stopped}
;format-offline = ${self.format-offline}

; Only applies if <icon-X> is used
icon-play = 
icon-pause = 
icon-stop = 
icon-prev = 
icon-next = 
icon-seekb = 
icon-seekf = 
icon-random = 
icon-repeat = 
icon-repeatone = 
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
