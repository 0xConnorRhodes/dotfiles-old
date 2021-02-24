#!/bin/bash
# Backup the root filesystem of my laptop using rsync-time-backup
# Connor Rhodes (connorrhodes.com)

/home/connor/.local/source/rsync-time-backup/rsync_tmbackup.sh \
	-p 45385 \
	--strategy "1:1 14:1 60:7 365:1" \
	--rsync-append-flags "--bwlimit=20000 \
	--exclude-from /home/connor/.config/rsync-time-backup/rsync-time-backup-exclude.txt" \
	/ \
	connor@gb:/mnt/pool/nosync/rsync-time-backup

/home/connor/.local/source/rsync-time-backup/rsync_tmbackup.sh \
	-p 45385 \
	--strategy "1:1 14:1 60:7 365:1" \
	--rsync-append-flags "--bwlimit=20000 \
	--exclude-from /home/connor/.config/rsync-time-backup/rsync-time-backup-exclude.txt" \
	/boot \
	connor@gb:/mnt/pool/nosync/rsync-time-backup
