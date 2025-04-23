
#!/bin/bash
LOG_FILE="/var/log/backup.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
BACKUP_DIR="/home/ubuntu/backups"
API_DIR="/home/ubuntu/student-api"
DB_FILE="/home/ubuntu/student-api/db.sqlite3"

mkdir -p $BACKUP_DIR

# Backup project files
if tar -czf $BACKUP_DIR/api_backup_$(date +%F).tar.gz $API_DIR; then
    echo "$TIMESTAMP API backup successful" >> $LOG_FILE
else
    echo "$TIMESTAMP ERROR: API backup failed" >> $LOG_FILE
    exit 1

fi

# Backup SQLite database
if cp $DB_FILE $BACKUP_DIR/db_backup_$(date +%F).sqlite3; then
    echo "$TIMESTAMP Database backup successful" >> $LOG_FILE
else
    echo "$TIMESTAMP ERROR: Database backup failed" >> $LOG_FILE
    exit 1
fi

# Delete backups older than 7 days
find $BACKUP_DIR -type f -mtime +7 -exec rm {} \;

echo "$TIMESTAMP Backup completed successfully." >> $LOG_FILE