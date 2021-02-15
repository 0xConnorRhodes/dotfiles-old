#!/bin/bash
pacman -Qqe > /home/connor/.local/dotfiles/laptop/repo_packages.txt
pacman -Qqm > /home/connor/.local/dotfiles/laptop/aur_packages.txt
groups > /home/connor/.local/dotfiles_secret/laptop/user_groups.txt
yay -Syu --noconfirm
nvim --headless +PlugUpgrade +PlugUpdate +PlugInstall +qa
~/.emacs.d/bin/doom -y upgrade
#/home/connor/.local/config_nosync/bin/cron/daily_atomic_notes_log.sh
#sudo backintime backup
backintime backup
#shutdown -h 03:00
#notify-send "The Computer will shut down at 3am"

