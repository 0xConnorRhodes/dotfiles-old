#!/bin/sh

xset r rate 300 45 &
xinput --set-prop "ETPS/2 Elantech Touchpad" "libinput Accel Speed" .3 #t460 setting was .2
xinput --set-prop "ETPS/2 Elantech TrackPoint" "libinput Accel Speed" .3 #the t460 setting was .2
xinput --set-prop "ETPS/2 Elantech TrackPoint" "libinput Natural Scrolling Enabled" 0 #disables reverse scrolling on trackpoint while keeping it set on touchpad per /usr/share/X11/xorg.conf.d/40-libinput.conf
feh --bg-scale /home/connor/.local/share/wallpaper/circlogo.jpg &
dunst &
picom &
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
syncthing -no-browser -logfile=/home/connor/.cache/syncthing/syncthing.log &
unclutter --timeout 1 --jitter 5 --ignore-scrolling &
pcmanfm -d &
emacs --daemon &
urxvtd &
mpd &
redshift &
#exec ~/.local/config_nosync/bin/autorun_nosync.sh &
betterlockscreen --lock
xrdb /home/connor/.config/Xresources/Xresources &
xdotool key meta+shift+r #this refreshes spectrwm which is necessary for the top bar to scale properly
~/bin/notifications-on.sh
~/bin/refbar
xterm -e mplayer -novideo -loop 0 -volume 1 -ao pulse /home/connor/.cache/mplayer/torukia.m4a &
#systemctl --user restart xcape #this used to be necessary, but an update made it unneccessary
