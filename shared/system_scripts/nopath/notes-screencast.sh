#!/bin/sh
# Script to present menu of public Engineer's Notes during a screencast and open selected
# note in Obsidian.
# Author: Connor Rhodes (connorrhodes.com)

cd /home/connor/dox/notes/Engineers_Notes
FILE=$(fd --extension md . | rofi -dmenu -i)

# Only run the open command if there is a selection. Otherwise exit.
if [ -z $FILE ];
then
    exit 0
else
    xdg-open obsidian:///"/home/connor/dox/notes/Engineers_Notes/$FILE"
fi
