#!/bin/bash
LINES=30
case "$1" in
	*.png|*.jpg|*.jpeg|*.mkv|*.mp4|*.webm) mediainfo "$1";;
	*.md|*.org|*.txt|*.css|*.log|*.sh|*.yml|*.conf) glow -s dark "$1";;
	*.pdf) pdftotext "$1" -;;
	*.tex) cat "$1";;
	*.zip) zipinfo "$1";;
	*tar.gz) tar -ztvf "$1";;
	*tar.bz2) tar -jtvf "$1";;
	*tar) tar -tvf "$1";;
	*.rar) unrar l "$1";;
	*.7z) 7z l "$1";;
	*.html|*.xml) w3m -dump "$1";; #brodie has this commented, probably because he used highlight for them
	*.zsh*|*.bash*|*.git*) pistol "$1";;
	*.docx) pandoc -f docx -t markdown "$1";;
	*.xlsx) xlsx2csv "$1";;
	*) highlight "$1" -0 ansi --force;;
esac
