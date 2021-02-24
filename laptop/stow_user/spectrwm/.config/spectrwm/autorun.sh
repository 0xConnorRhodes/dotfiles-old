#!/bin/sh
# autorun script for Lenovo ThinkPad e15 by Connor Rhodes (connorrhodes.com)

#xset r rate 300 45 &
lockargs="--timepos=x+105:h-70 --timestr=%H:%M" betterlockscreen -l
urxvtd &
xrdb /home/connor/.config/Xresources/Xresources &
xset r rate 155 75 & # this is the best if I can manage to adjust to it.
#xset r rate 200 50 & # I think this is the perfect one.
xinput --set-prop "ETPS/2 Elantech Touchpad" "libinput Accel Speed" .3 #t460 setting was .2
xinput --set-prop "ETPS/2 Elantech TrackPoint" "libinput Accel Speed" .3 #the t460 setting was .2
xinput --set-prop "ETPS/2 Elantech TrackPoint" "libinput Natural Scrolling Enabled" 0 #disables reverse scrolling on trackpoint while keeping it set on touchpad per /usr/share/X11/xorg.conf.d/40-libinput.conf
feh --bg-scale /home/connor/.local/share/wallpaper/circlogo.jpg &
dunst &
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
syncthing -no-browser -logfile=/home/connor/.cache/syncthing/syncthing.log &
unclutter --timeout 1 --jitter 5 --ignore-scrolling &
pcmanfm -d &
emacs --daemon &
redshift &
playerctld &
#mpd &
#exec ~/.local/config_nosync/bin/autorun_nosync.sh &
#calcurse --daemon &
picom &
~/bin/notifications-on.sh
espanso daemon & #it only works if it's started here. Not in the systemd service.
#~/bin/refbar
