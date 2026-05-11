#!/bin/bash

# Output log file
OUTPUT_FILE="system_monitor.log"

# Collect system metrics
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}') # Sum of user and system CPU usage
MEMORY=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }') # Memory usage as a percentage
DISK=$(df -h / | awk 'NR==2 {print $5}') # Root filesystem usage as a percentage
UPTIME=$(uptime -p) # Human-readable uptime
TOP_PROCESSES=$(ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 6) # Top 5 processes

# Write metrics to log file
{
    echo "System Monitoring Report - $(date)"
    echo "---------------------------------"
    echo "CPU Usage: $CPU%"
    echo "Memory Usage: $MEMORY%"
    echo "Disk Usage: $DISK"
    echo "Uptime: $UPTIME"
    echo ""
    echo "Top 5 Processes by CPU Usage:"
    echo "$TOP_PROCESSES"
    echo "---------------------------------"
    echo ""
} >> $OUTPUT_FILE

# Display the report on the terminal
echo "System Monitoring Report - $(date)"
echo "---------------------------------"
echo "CPU Usage: $CPU%"
echo "Memory Usage: $MEMORY%"
echo "Disk Usage: $DISK"
echo "Uptime: $UPTIME"
echo ""
echo "Top 5 Processes by CPU Usage:"
echo "$TOP_PROCESSES"
echo "---------------------------------"
