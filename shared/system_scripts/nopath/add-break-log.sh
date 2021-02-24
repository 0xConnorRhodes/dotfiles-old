#!/bin/sh
# add item to daily log in Obsidian with timestamp in html comment
# Connor Rhodes (connorrhodes@gmail.com)

read -p "break log: " LOGITEM
echo "- [ ] $LOGITEM" >> /home/connor/dox/notes/pomodoro-break.md
