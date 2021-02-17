#!/bin/sh
# add item to daily log in Obsidian with timestamp in html comment
# Connor Rhodes (connorrhodes@gmail.com)

read -p "daily log: " LOGITEM
DAY=$(date +%Y-%m-%d)
TIMESTAMP=$(date +%H:%M)

echo "- [x] $LOGITEM <!--$TIMESTAMP-->" >> /home/connor/dox/notes/mind/daily_notes/$DAY.md
