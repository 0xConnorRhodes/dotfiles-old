#!/bin/sh

# Feed script a url or file location.
# If an image, it will view in sxiv,
# if a video or gif, it will view in mpv
# if a music file or pdf, it will download,
# otherwise it opens link in browser.

nohup /home/connor/.local/dotfiles/shared/system_scripts/nopath/vidwn.sh "$1" >/dev/null 2>&1 &


#case "$1" in
#	#*mkv|*webm|*mp4|*youtube.com/watch*|*youtube.com/playlist*|*youtu.be*|*hooktube.com*|*bitchute.com*|*videos.lukesmith.xyz*)
#	*)
#		;;
##	*png|*jpg|*jpe|*jpeg|*gif)
##		curl -sL "$1" > "/tmp/$(echo "$1" | sed "s/.*\///")" && sxiv -a "/tmp/$(echo "$1" | sed "s/.*\///")"  >/dev/null 2>&1 & ;;
##	*mp3|*flac|*opus|*mp3?source*)
##		setsid tsp curl -LO "$1" >/dev/null 2>&1 & ;;
#esac
