#!/bin/sh
cd /home/connor/dox/notes/Engineers_Notes
FILE=$(fd --extension md . | rofi -dmenu -i)

#nvim "$FILE"
xdg-open obsidian:///"/home/connor/dox/notes/Engineers_Notes/$FILE"
