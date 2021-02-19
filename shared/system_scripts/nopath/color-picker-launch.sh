#!/bin/bash
# script to launch `color-picker` (elementary OS color picker) and to stop and restart OS configs that interfere with it.

DISPLAY=:0

killall unclutter

# use sed to disable picom dimming of inactive windows and relaunch
# picom must be running to get color picker overlay, but if inactive dim is enabled, the colors will change when dimmed

killall picom
sed -i -E "s/^inactive-dim\ =\ /\#inactive-dim\ =\ /g" /home/connor/.config/picom/picom.conf
picom &

color-picker

sed -i -E "s/^\#inactive-dim\ =\ /inactive-dim\ =\ /g" /home/connor/.config/picom/picom.conf
unclutter --timeout 1 --jitter 5 --ignore-scrolling &
killall picom
picom &
