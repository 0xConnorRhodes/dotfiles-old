#!/bin/zsh
# Script presents an fzf list of my favorite directories and opens pcmanfm in the selected directory
# new directories can be added to the favorites list with dmenu-scripts/add-foldopen

devour pcmanfm -n $(cat ~/.config/foldopen/foldopen_dirs.txt | fzf)
exit
