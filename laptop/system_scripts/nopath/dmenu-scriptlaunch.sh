#!/bin/zsh
# laptop version of dmenu launcher script by Connor Rhodes (connorrhodes@gmail.com) 2021-02-15

NAME=$(ls \
	~/.local/dotfiles/shared/system_scripts/dmenu-scripts/* \
	~/.local/dotfiles/laptop/system_scripts/dmenu-scripts | xargs -n 1 basename | rofi -dmenu)

FULLPATH=$(ls -d \
	~/.local/dotfiles/shared/system_scripts/dmenu-scripts/* \
	~/.local/dotfiles/laptop/system_scripts/dmenu-scripts/* | grep $NAME)

exec urxvtc -e "$FULLPATH"
