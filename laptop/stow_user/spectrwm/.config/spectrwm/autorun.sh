#!/bin/sh
# autorun script for Lenovo ThinkPad e15 by Connor Rhodes (connorrhodes.com)

#xset r rate 300 45 &
lockargs="--timepos=x+105:h-70 --timestr=%H:%M" betterlockscreen -l
urxvtd &
syncthing -no-browser -logfile=/home/connor/.cache/syncthing/syncthing.log &
unclutter --timeout 1 --jitter 5 --ignore-scrolling &
pcmanfm -d &
emacs --daemon &
playerctld &
#mpd &
#exec ~/.local/config_nosync/bin/autorun_nosync.sh &
#calcurse --daemon &
~/bin/notifications-on.sh &
espanso daemon & #it only works if it's started here. Not in the systemd service.
# set dg80 input colume at 153%
xdotool click 1 # click to enable keys to be captured by spectrwm
systemctl --user restart xcape.service
#~/bin/refbar
