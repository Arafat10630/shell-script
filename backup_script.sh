#!/bin/bash

# Load configuration from external file

CONFIG_FILE="/home/arafa/backup.conf"
if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
else
        echo "Configuration file not found!"
fi

# Defining variables

BACKUP_DATE=$(date +%Y%m%dH%M%S)
BACKUP_FILENAME="backup_$BACKUP_DATE.tar.gz"
LOG_FILE="$BACKUP_DST/backup_$BACKUP_DATE.log"

mkdir -p "$BACKUP_DST/backup_$BACKUP_DATE"

# Start logging

exec >> >(tee -a "$LOG_FILE") 2>&1
tar -czf "$BACKUP_DST/backup_$BACKUP_DATE/$BACKUP_FILENAME" -C "$BACKUP_SRC" .

# Verify successful backup creation

if [ $? -eq 0 ]; then
        echo "Backup successful: $BACKUP_FILENAME"
        ssmtp teaandcookie123@gmail.com < success_email.txt
else
        echo "Backup failed!"
        ssmtp teaandcookie123@gmail.com < failure_email.txt
        exit 1
fi

# Implement backup rotation to keep last 2 backups

NUM_BACKUPS=2
cd "$BACKUP_DST"
find . -maxdepth 1 -name "backup_*" -type d | sort -r | sed -e "1,${NUM_BACKUPS}d" | xargs rm -rf
find . -maxdepth 1 -name "backup_*.log" | sort -r | sed -e "1,${NUM_BACKUPS}d" | xargs rm -rf

echo "Backup script completed"
exit 0
