#!/bin/bash
# Script to change settings for a screencast, launch OBS
# and revert to non-screencast settings after OBS exits
# 
# OBS_dotdesktop_name: com.obsproject.Studio.desktop
# Author: Connor Rhodes (connorrhodes.com)


echo "off" > $HOME/.cache/obs-status.txt

# edit spectrwm to redefine from key presses
## search only public notes in Obsidian
sed -i \
	-e "s/^\#program\[screencast-notes\]/program\[screencast-notes\]/g" \
	-e "s/^\#bind\[screencast-notes\]/bind\[screencast-notes\]/g" \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

# comment private search
sed -Ei \
	's/^(program\[zk-vim-search\].*md-sync\.sh$)/#\1/g' \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

# uncomment public-search
sed -Ei \
	's/^#(program\[zk-vim-search\].*zk-vimsearch-screencast\.sh$)/\1/g' \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

# enable notification scripts for OBS notifications
sed -Ei \
	-e "s/^\#program\[obs-(.*)\]/program\[obs-\1\]/g" \
	-e "s/^\#bind\[obs-(.*)\]/bind\[obs-\1\]/g" \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf


## reset spectrwm to apply changes
xdotool key Meta_L+shift+r

# disable all non-critical dunst messages by 
sed -Ei 's/^#(.*#screencast_setting$)/\1/g' $HOME/.config/dunst/dunstrc

killall dunst
notify-send -u critical "screencast" "ready"

killall unclutter
#hhpc -i 1 &
#$HOME/.local/dotfiles/shared/system_scripts/nopath/notifications-off.sh

killall obsidian
xdg-open obsidian:///"/home/connor/dox/notes/engineers_notes/000 Engineers Notes.md" &

obs

# reset spectrwm config to non-screencast keyboard shortcuts
## search all notes in Obsidian
sed -i \
	-e "s/^program\[screencast-notes\]/\#program\[screencast-notes\]/g" \
	-e "s/^bind\[screencast-notes\]/\#bind\[screencast-notes\]/g" \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

# uncomment private search
sed -Ei \
	's/^#(program\[zk-vim-search\].*md-sync\.sh$)/\1/g' \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

# comment public-search
sed -Ei \
	's/^(program\[zk-vim-search\].*zk-vimsearch-screencast\.sh$)/#\1/g' \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

# disable spectrwm obs shortcut notification scripts
sed -Ei \
	-e "s/^program\[obs-(.*)\]/\#program\[obs-\1\]/g" \
	-e "s/^bind\[obs-(.*)\]/\#bind\[obs-\1\]/g" \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

## reset spectrwm to apply changes
xdotool key Meta_L+shift+r

# re-enable all notifications by commenting screencast settings in dunstrc
sed -Ei 's/^(.*#screencast_setting$)/#\1/g' $HOME/.config/dunst/dunstrc

killall dunst
notify-send -u normal "Notifications ON"

killall hhpc

echo "off" > $HOME/.cache/obs-status.txt

#$HOME/.local/dotfiles/shared/system_scripts/nopath/notifications-on.sh
unclutter --timeout 1 --jitter 5 --ignore-scrolling &

#insert script to convert and process and upload etc. the final file (you will need to have OBS store in a cache directory first.
#also, have the script start this ffmpeg conversion in a tmux window you can access and open a tmux session there (as your previous ffmpeg script

# for f in ~/.cache/screencasts/raw; mv to processing and then process it. then mv it to final when done
