#!/bin/bash

RCMD="rsync -alI"

$RCMD /run/user/1000/connor-firefox-6v3rve6y.default-release/user.js \
	/home/connor/.local/dotfiles/laptop/rsync/firefox/main_profile

$RCMD /run/user/1000/connor-firefox-6v3rve6y.default-release/chrome/* \
	/home/connor/.local/dotfiles/laptop/rsync/firefox/main_profile

$RCMD /run/user/1000/connor-firefox-5perw3vc.App/user.js \
	/home/connor/.local/dotfiles/laptop/rsync/firefox/app_profile

$RCMD /run/user/1000/connor-firefox-5perw3vc.App/chrome/* \
	/home/connor/.local/dotfiles/laptop/rsync/firefox/app_profile
