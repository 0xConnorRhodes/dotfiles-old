#!/bin/bash
case $(file --mime-type $1 -b) in
    text/*) $EDITOR $1;;
    image/*) ~/.config/lf/draw_img.sh $1;;
    video/*) devour mpv --player-operation-mode=pseudo-gui --osd-level=3 --load-stats-overlay=yes $1;;
    *) xdg-open $1;;
esac
