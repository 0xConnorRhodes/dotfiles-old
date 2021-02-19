#!/bin/bash
# color picker script to undo settings that interfere with the color picker and redo them after it's done
# Connor Rhodes (connorrhodes.com)

killall unclutter

killall picom
sed -i -E "s/^inactive-dim\ =\ /\#inactive-dim\ =\ /g" /home/connor/.config/picom/picom.conf
picom &

CHOICE=$(xcolor)

echo $CHOICE | xclip -selection primary
echo $CHOICE | xclip -selection secondary
echo $CHOICE | xclip -selection clipboard

notify-send $CHOICE


sed -i -E "s/^\#inactive-dim\ =\ /inactive-dim\ =\ /g" /home/connor/.config/picom/picom.conf
unclutter --timeout 1 --jitter 5 --ignore-scrolling &
killall picom
picom &
