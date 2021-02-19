#!/bin/sh
# autorun script for Lenovo ThinkPad e15 by Connor Rhodes (connorrhodes.com)

#xset r rate 300 45 &
xrdb /home/connor/.config/Xresources/Xresources &
lockargs="--timepos=x+105:h-70 --timestr=%H:%M" betterlockscreen -l
xrdb /home/connor/.config/Xresources/Xresources &
xdotool key meta+shift+r #this refreshes spectrwm which is necessary for the top bar to scale properly
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
urxvtd &
redshift &
playerctld &
#mpd &
emacs --daemon
#exec ~/.local/config_nosync/bin/autorun_nosync.sh &
#calcurse --daemon &
picom &
~/bin/notifications-on.sh
#~/bin/refbar
#xterm -e mplayer -novideo -loop 0 -volume 1 -ao pulse /home/connor/.cache/mplayer/torukia.m4a &
#systemctl --user restart xcape #this used to be necessary, but an update made it unneccessary
