#!/bin/sh

STATUS=$(cat $HOME/.cache/obs-status.txt)

WINID=$(xdotool search --name "OBS 26")

case $STATUS in

	# Start Recording
	obs_off)
		echo "REC" > $HOME/.cache/obs-status.txt
		amixer -D pulse sset Capture cap
		notify-send -t 500 -u critical "Recording Started"
		xdotool key --window "$WINID" "KP_Divide"
		refbar
		;;

	# Pause Recording
	REC)
		echo "pause" > $HOME/.cache/obs-status.txt
		notify-send -t 1000 -u critical "Recording Paused"
		xdotool key --window "$WINID" "KP_Multiply"
		refbar
		;;

	# Resume Recording
	pause)
		echo "REC" > $HOME/.cache/obs-status.txt
		amixer -D pulse sset Capture cap
		notify-send -t 500 -u critical "Recording Resumed"
		xdotool key --window "$WINID" "KP_Add"
		refbar
		;;

esac
