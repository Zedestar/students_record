
#!/bin/bash
LOG_FILE="/var/log/update.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
cd /home/ubuntu/student-api || {
    echo "$TIMESTAMP ERROR: Directory not found" >> $LOG_FILE
    exit 1
}

echo "$TIMESTAMP Update started" >> $LOG_FILE

sudo apt update && sudo apt upgrade -y >> $LOG_FILE 2>&1

if [ -d .git ]; then
    if git pull >> $LOG_FILE 2>&1; then
        sudo systemctl restart nginx  
        echo "$TIMESTAMP Update completed and server restarted" >> $LOG_FILE
    else
        echo "$TIMESTAMP ERROR: Git pull failed" >> $LOG_FILE
        exit 1
    fi
else
    echo "$TIMESTAMP ERROR: Not a Git repository" >> $LOG_FILE
    exit 1
fi
