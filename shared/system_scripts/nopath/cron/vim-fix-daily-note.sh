#!/bin/bash
# This script temporarily kills obsidian when I open my daily note file in vim (due to autocmd in vimrc)
# This allows me to edit my daily note without the Day Planner plugin stomping all over my edits.
# Connor Rhodes (connorrhodes.com)


if [ "$(pgrep obsidian | wc -l)" -ne 0 ]; then
	pkill obsidian
fi

# I would like the script to also launch obsidian after editing IFF obsidian was already running. Code currently doesn't work. WIP

#VIMSTATUS=$(lsof -u connor -a -c nvim | grep daily_notes | wc -l)
#
#while [ -n "$VIMSTATUS" ];
#do 
#	sleep 1
#done
#
#DISPLAY=:0
#pcmanfm &!
