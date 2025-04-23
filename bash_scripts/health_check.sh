#!/bin/bash
LOG_FILE="/var/log/server_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100}')
DISK=$(df / | awk 'END{print $(NF-1)}' | tr -d '%')
WEB_SERVICE="nginx" 

echo "$TIMESTAMP Health Check" >> $LOG_FILE

if systemctl is-active --quiet $WEB_SERVICE; then
    echo "$WEB_SERVICE is running" >> $LOG_FILE
else
    echo "WARNING: $WEB_SERVICE is not running" >> $LOG_FILE
fi

for ENDPOINT in "students" "subjects"; do
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/$ENDPOINT)
    if [ "$HTTP_CODE" -ne 200 ]; then
        echo "WARNING: /$ENDPOINT endpoint returned $HTTP_CODE" >> $LOG_FILE
    fi
done

echo "CPU Usage: $CPU%" >> $LOG_FILE
echo "Memory Usage: $MEM%" >> $LOG_FILE
[ "$DISK" -gt 90 ] && echo "WARNING: Disk usage over 90%" >> $LOG_FILE

echo "---------" >> $LOG_FILE    
