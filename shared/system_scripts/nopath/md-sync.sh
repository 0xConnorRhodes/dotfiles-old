#!/bin/bash
cd /home/connor/dox/notes
FILE=$(fzf)

case $FILE in
	*.md) nvim "$FILE";;
	*.org) emacsclient -c -n "$FILE";;
	*.ods) devour env GTK_THEME=Adwaita libreoffice --calc "$FILE";;
	*pdf) devour zathura "$FILE";;
	*.txt) nvim "$FILE";;
	*) echo -n "unknown filetype";;
esac
