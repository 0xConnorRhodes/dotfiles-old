#!/bin/bash
# Script to rsync importan configs to a backup directory that is kept in version control.
# These files cannot be stored as symlinks. 
# Daily rsync allows backup and version history of these files.
# 
# Author: Connor Rhodes (connorrhodes.com)

RCMD="rsync -alI"

$RCMD /run/user/1000/connor-firefox-6v3rve6y.default-release/user.js \
	/home/connor/.local/dotfiles/laptop/rsync/firefox/main_profile

$RCMD /run/user/1000/connor-firefox-6v3rve6y.default-release/chrome/* \
	/home/connor/.local/dotfiles/laptop/rsync/firefox/main_profile

$RCMD /run/user/1000/connor-firefox-5perw3vc.App/user.js \
	/home/connor/.local/dotfiles/laptop/rsync/firefox/app_profile

$RCMD /run/user/1000/connor-firefox-5perw3vc.App/chrome/* \
	/home/connor/.local/dotfiles/laptop/rsync/firefox/app_profile

$RCMD /home/connor/.config/obs-studio/basic \
	/home/connor/.local/dotfiles/laptop/rsync/obs-studio/
