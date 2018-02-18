;----------------------------------------------------------
;		        S E T T I N G S
;----------------------------------------------------------
[settings]
screenchange-reload = true

;----------------------------------------------------------
;		        C O L O R S
;----------------------------------------------------------
; 100%: FF - 95%: F2 - 90%: E6 - 85%: D9 - 80%: CC - 75%: BF - 70%: B3 - 65%: A6 - 60%: 99 - 55%: 8C - 50%: 80 - 45%: 73 - 40%: 66 - 35%: 59 - 30%: 4D - 25%: 40 - 20%: 33 - 15%: 26 - 10%: 1A - 5%: 0D - 0%: 00
[colors]
transparente = #66000000
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
;override-redirect = true
;wm-restack = i3

;background = ${colors.transparente}
background = ${colors.background}
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

; Position of the system tray window
; If empty or undefined, tray support will be disabled
; NOTE: A center aligned tray will cover center aligned modules
;
; Available positions:
;   left
;   center
;   right
tray-position = right

; If true, the bar will not shift its
; contents when the tray changes
tray-detached = false

; Tray icon max size
tray-maxsize = 20

; Enable pseudo transparency
; Will automatically be enabled if a fully transparent
; background color is defined using `tray-background`
tray-transparent = false

; Background color for the tray container
; By default the tray container will use the bar
; background color.
; Note: 32 bit alpha blending is not supported.
tray-background = ${colors.background}

; Tray offset defined as pixel value (e.g. 35) or percentage (e.g. 50%)
tray-offset-x = 0
tray-offset-y = 1

; Pad the sides of each tray icon
tray-padding = 0

; Scale factor for tray clients
tray-scale = 1.0

;----------------------------------------------------------
;		        B A R / B O T T O M
;----------------------------------------------------------
[bar/bottom]
width = 100%
height = 30
offset-y = -1
bottom = true
enable-ipc = true

;background = ${colors.transparente}
background = ${colors.background}
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
modules-center = cpu memory network temperature rootfs homefs trash uptime
modules-right = mpd switch

;----------------------------------------------------------
;		        I 3
;----------------------------------------------------------
[module/i3]
type = internal/i3

;                     
;          
ws-icon-0 = 1;
ws-icon-1 = 2;
ws-icon-2 = 3;
ws-icon-3 = 4;
ws-icon-4 = 5;
ws-icon-5 = 6;
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
label-close = " "
label-separator = "  "

menu-0-0 = 
menu-0-0-exec = firefox-developer-edition &

menu-0-1 = 
menu-0-1-exec = thunar &

menu-0-2 = 
menu-0-2-exec = cd ; $TERMINAL &

menu-0-3 = 
menu-0-3-exec = subl &

menu-0-4 = 
menu-0-4-exec = telegram &

menu-0-5 = 
menu-0-5-exec = Whatsapp &

menu-0-6 = 
menu-0-6-exec = steam &

menu-0-7 = 
menu-0-7-exec = ~/apps/DevDocs-0.6.7-x86_64.AppImage &

menu-0-8 = 
menu-0-8-exec = ~/apps/medley-latest.AppImage &

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
type = custom/script
interval = 1
label = %output%
click-left = $TERMINAL -e ~/.local/bin/screencast &
click-right = ~/.local/bin/screencast clear &
exec = ~/.local/bin/screencast status

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
type = custom/script
interval = 1
format = <label>
label = " %output:%%"
exec = ~/.config/polybar/scripts/cpu.sh
click-left = lxtask &

;----------------------------------------------------------
;		        M E M O R Y
;----------------------------------------------------------
[module/memory]
type = custom/script
interval = 1
format = <label>
label = " %output:%%"
exec = ~/.config/polybar/scripts/mem.sh
click-left = lxtask &

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
click-left = ~/.config/polybar/scripts/trash.sh -x ; exec paplay /usr/share/sounds/freedesktop/stereo/trash-empty.oga ; notify-send "Lixeira" "Lixeira limpa!" &
click-middle = ~/.config/polybar/scripts/trash.sh -o &
click-right = ~/.config/polybar/scripts/trash.sh -x ; exec paplay /usr/share/sounds/freedesktop/stereo/trash-empty.oga ; notify-send "Lixeira" "Lixeira limpa!" &

;----------------------------------------------------------
;		        U P T I M E
;----------------------------------------------------------
[module/uptime]
type = custom/script
format-prefix = " "
exec = ~/.config/polybar/scripts/uptime.sh
interval = 60

;----------------------------------------------------------
;			M P D
;----------------------------------------------------------
[module/mpd]
type = internal/mpd
host = 127.0.0.1
port = 6600
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
format-online = <label-song> <label-time> <icon-prev> <icon-seekb> <icon-stop> <toggle> <icon-seekf> <icon-next> <icon-repeat> <icon-repeatone> <icon-random>
;format-playing = ${self.format-online}
;format-paused = ${self.format-online}
;format-stopped = ${self.format-online}

; Available tags:
;   <label-offline>
format-offline = <label-offline>

; Available tokens:
;   %artist%
;   %album%
;   %date%
;   %title%
; Default: %artist% - %title%
label-song =  %artist% - %title%

; Available tokens:
;   %elapsed%
;   %total%
; Default: %elapsed% / %total%
;label-time = %elapsed% / %total%

; Available tokens:
;   None
label-offline = 🎜 MPD

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
icon-consume = ✀

; Used to display the state of random/repeat/repeatone
; Only applies if <icon-[random|repeat|repeatone]> is used
toggle-on-foreground = #ff
toggle-off-foreground = #55

; Only applies if <bar-progress> is used
bar-progress-width = 45
bar-progress-indicator = |
bar-progress-fill = ─
bar-progress-empty = ─

;----------------------------------------------------------
;		        S W I T C H
;----------------------------------------------------------
[module/switch]
type = custom/script
interval = 1
label = %output:0:50:...%
click-left = ~/.config/polybar/scripts/switch.sh s &
exec = ~/.config/polybar/scripts/switch.sh
