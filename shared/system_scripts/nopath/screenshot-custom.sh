#!/bin/bash
killall unclutter
#import ~/pix/shots/$(date +"%Y-%m-%d_%H-%M-%S").png
flameshot gui -p ~/pix/shots
#notify-send "screenshot saved"

unclutter --timeout 1 --jitter 5 --ignore-scrolling &

echo ~/pix/shots/$(ls -t ~/pix/shots | head -1) | xclip -r -sel primary
echo ~/pix/shots/$(ls -t ~/pix/shots | head -1) | xclip -r -sel clipboard
