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
pacmd set-source-volume alsa_input.usb-0a12_Avantree_DG80-00.mono-fallback 100000
systemctl --user restart xcape.service
#~/bin/refbar
