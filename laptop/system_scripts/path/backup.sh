#!/bin/bash
# nightly backup script running a variety of daily maintainance tasks
# Connor Rhodes (connorrhodes.com)

# updates
pacman -Qqe > /home/connor/.local/dotfiles_secret/laptop/repo_packages.txt
pacman -Qqm > /home/connor/.local/dotfiles_secret/laptop/aur_packages.txt
pip list --user > /home/connor/.local/dotfiles_secret/laptop/pip_user_packages.txt
pip list > /home/connor/.local/dotfiles_secret/laptop/pip_all_packages.txt
groups > /home/connor/.local/dotfiles_secret/laptop/user_groups.txt
yay -Syu --noconfirm
~/.emacs.d/bin/doom -y upgrade
nvim --headless +PlugUpgrade +PlugUpdate +PlugInstall +qa

# backups
sudo rm /tmp/backintime.lock
rm /home/connor/.local/share/backintime/worker.lock
sudo backintime backup
sudo rm /tmp/backintime.lock
rm /home/connor/.local/share/backintime/worker.lock
backintime backup
rm /tmp/backintime/backup
# TODO
#emborg create

# cleaning up
/home/connor/.local/dotfiles/shared/system_scripts/nopath/cron/daily_atomic_notes_log.sh
shutdown -h +15
notify-send -u critical "The Computer will shut down in 15 minutes"
