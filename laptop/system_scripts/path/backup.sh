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
~/.emacs.d/bin/doom -y sync
~/.emacs.d/bin/doom -y upgrade
nvim --headless +PlugClean +PlugUpgrade +PlugUpdate +PlugInstall +qa

# push git repos
cd /home/connor/.local/dotfiles
git pull
git add .
git commit -m "nightly backup autocommit"
git push

cd /home/connor/.local/dotfiles_secret
git pull
git add .
git commit -m "nightly backup autocommit"
git push

cd /home/connor/dox/notes
git pull
git add .
git commit -m "nightly backup autocommit"
git push

cd /home/connor/.local/password_store
pass git pull
pass git add .
pass git commit -m "nightly backup autocommit"
pass git push

## runs etckeeper daily autocommit/push
sudo /etc/etckeeper/daily

# backup OS and user data
export RESTIC_REPOSITORY=sftp:gb:/mnt/pool/nosync/restic
export RESTIC_PASSWORD=$(pass sysadmin/restic-laptop-backups-password | head -n1)
restic --limit-upload 20000 --verbose backup /home/connor/.local/virtual_machines/
restic forget --keep-daily 7 --keep-weekly 8 --keep-monthly 24 --keep-yearly 10 --prune

# cleaning up
/home/connor/.local/dotfiles/shared/system_scripts/nopath/cron/daily_atomic_notes_log.sh
shutdown -h +15
notify-send -u critical "The Computer will shut down in 15 minutes"
