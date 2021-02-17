#!/bin/bash
# This script temporarily kills obsidian when I open my daily note file in vim (due to autocmd in vimrc)
# This allows me to edit my daily note without the Day Planner plugin stomping all over my edits.
# Connor Rhodes (connorrhodes.com)


# if listing the processes of obsidian is more lines than 0, kill it
if [ "$(pgrep obsidian | wc -l)" -ne 0 ]; then
	pkill obsidian
else
	# else (obsidian is not running) so exit the script. No need to re-launch a program that wasn't launched
	exit 0
fi


VIMSTATUS=$(lsof -u connor -a -c nvim | grep "daily_notes" | grep -v "deleted" | wc -l)

# while vim is editing the file, wait 1 second and check again if vim is editing the file
while [[ "$VIMSTATUS"  != "0" ]]
do 
	sleep 1
        VIMSTATUS=$(lsof -u connor -a -c nvim | grep "daily_notes" | grep -v "deleted" | wc -l)
done

# launching obsidian this way is the only way I could get it to go to my x server
urxvtc -e nohup obsidian &!
