#!/bin/bash

RCMD="rsync -alI"

$RCMD /run/user/1000/connor-firefox-6v3rve6y.default-release/user.js \
	/home/connor/.local/dotfiles/laptop/rsync/firefox

$RCMD /run/user/1000/connor-firefox-6v3rve6y.default-release/chrome/* \
	/home/connor/.local/dotfiles/laptop/rsync/firefox
