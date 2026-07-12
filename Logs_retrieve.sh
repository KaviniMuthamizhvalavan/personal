#!/bin/bash

echo "========== LINUX SYSTEM LOG ANALYSIS =========="

# Create directories
mkdir -p logs processed_logs archive

# Environment variable
export LOG_HOME=$(pwd)

echo "Log Home : $LOG_HOME"
echo "User     : $(whoami)"
echo "Date     : $(date)"
echo "Directory: $(pwd)"

# Create sample log file
cat > logs/system.log << EOF
INFO: System Started
INFO: User login successful
WARNING: Disk usage 80%
ERROR: File not found
INFO: Backup completed
ERROR: Network connection failed
WARNING: CPU usage high
INFO: Service restarted
EOF

echo
echo "===== COMPLETE LOG FILE ====="
cat logs/system.log

echo
echo "===== LOG FILE WITH LINE NUMBERS ====="
cat -n logs/system.log

echo
echo "===== ERROR LOGS ====="
grep "ERROR" logs/system.log

echo
echo "===== WARNING LOGS ====="
grep "WARNING" logs/system.log

echo
echo "===== COUNT OF ERRORS ====="
grep -c "ERROR" logs/system.log

echo
echo "===== USING AWK ====="
awk '{print NR, $0}' logs/system.log

echo
echo "===== USING SED ====="
sed 's/ERROR/CRITICAL/' logs/system.log

echo
echo "===== GENERATING REPORT ====="

{
echo "SYSTEM LOG REPORT"
echo "Generated on: $(date)"
echo "--------------------------------"

echo
echo "Errors:"
grep "ERROR" logs/system.log

echo
echo "Warnings:"
grep "WARNING" logs/system.log

echo
echo "Total Errors:"
grep -c "ERROR" logs/system.log

echo
echo "Total Warnings:"
grep -c "WARNING" logs/system.log

} > processed_logs/log_report.txt

echo
echo "===== REPORT ====="
cat processed_logs/log_report.txt

echo
echo "===== RUNNING PROCESSES ====="
ps

echo
echo "===== COMPRESSING REPORT ====="
tar -czf archive/log_report.tar.gz processed_logs

echo "Archive Created Successfully."

echo
echo "===== ARCHIVE CONTENT ====="
ls archive

echo
echo "========== TASK COMPLETED =========="
