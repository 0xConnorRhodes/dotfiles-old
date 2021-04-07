#!/bin/bash
# Script to change settings for a screencast, launch OBS
# and revert to non-screencast settings after OBS exits
# 
# OBS_dotdesktop_name: com.obsproject.Studio.desktop
# Author: Connor Rhodes (connorrhodes.com)


echo "obs_off" > $HOME/.cache/obs-status.txt

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

# enable obs-control
sed -Ei \
	-e "s/^\#program\[obs-control\]/program\[obs-control\]/g" \
	-e "s/^\#bind\[obs-control\]/bind\[obs-control\]/g" \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

# disable screen off script
sed -Ei \
	-e "s/^bind\[screenoff\]/\#bind\[screenoff\]/g" \
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

# obs-control only works if the recording has been started. you can stop and start again or you can r
obs --startrecording

for movie in /home/connor/.cache/screencasts/raw/*.mkv
do
	duration=$(ffprobe "$movie" -show_entries format=format=duration 2>&1| grep DURATION | awk 'NR==1{print $3}')
	duration_float=$(echo "$duration" | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
	duration_integer=${duration_float%.*}


 if [ $duration_integer -lt 30 ];then
 	trash-put $movie
 fi
done

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

# disable OBS control script
sed -Ei \
	-e "s/^program\[obs-control\]/\#program\[obs-control\]/g" \
	-e "s/^bind\[obs-control\]/\#bind\[obs-control\]/g" \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

# enable screen off script
sed -Ei \
	-e "s/\#bind\[screenoff\]/bind\[screenoff\]/g" \
	$HOME/.local/dotfiles/laptop/stow_user/spectrwm/.config/spectrwm/spectrwm.conf

## reset spectrwm to apply changes
xdotool key Meta_L+shift+r

# re-enable all notifications by commenting screencast settings in dunstrc
sed -Ei 's/^(.*#screencast_setting$)/#\1/g' $HOME/.config/dunst/dunstrc

killall dunst
notify-send -u normal "Notifications ON"

killall hhpc

echo "" > $HOME/.cache/obs-status.txt
refbar

#$HOME/.local/dotfiles/shared/system_scripts/nopath/notifications-on.sh
unclutter --timeout 1 --jitter 5 --ignore-scrolling &

#insert script to convert and process and upload etc. the final file (you will need to have OBS store in a cache directory first.
#also, have the script start this ffmpeg conversion in a tmux window you can access and open a tmux session there (as your previous ffmpeg script

# for f in ~/.cache/screencasts/raw; mv to processing and then process it. then mv it to final when done
