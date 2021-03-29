#!/bin/bash
# Script to change settings for a screencast, launch OBS
# and revert to non-screencast settings after OBS exits
# 
# OBS_dotdesktop_name: com.obsproject.Studio.desktop
# Author: Connor Rhodes (connorrhodes.com)

# edit spectrwm to redefine from key presses
## search only public notes in Obsidian
sed -i \
	-e "s/^\#program\[screencast-notes\]/program\[screencast-notes\]/g" \
	-e "s/^\#bind\[screencast-notes\]/bind\[screencast-notes\]/g" \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

## reset spectrwm to apply changes
xdotool key Meta_L+shift+r


killall unclutter
#hhpc -i 1 &
$HOME/.local/dotfiles/shared/system_scripts/nopath/notifications-off.sh

obs

# reset spectrwm config to non-screencast keyboard shortcuts
## search all notes in Obsidian
sed -i \
	-e "s/^program\[screencast-notes\]/\#program\[screencast-notes\]/g" \
	-e "s/^bind\[screencast-notes\]/\#bind\[screencast-notes\]/g" \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

## reset spectrwm to apply changes
xdotool key Meta_L+shift+r

#sleep 1
killall hhpc
#sleep 1
#nohup unclutter --timeout 1 --jitter 5 --ignore-scrolling >/dev/null 2>&1
#sleep 1
$HOME/.local/dotfiles/shared/system_scripts/nopath/notifications-on.sh
#sleep .5
unclutter --timeout 1 --jitter 5 --ignore-scrolling &
#sleep .5



#insert script to convert and process and upload etc. the final file (you will need to have OBS store in a cache directory first.
#also, have the script start this ffmpeg conversion in a tmux window you can access and open a tmux session there (as your previous ffmpeg script

# for f in ~/.cache/screencasts/raw; mv to processing and then process it. then mv it to final when done
