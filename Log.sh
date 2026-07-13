#!/bin/bash

# ==========================
# Task 01 - Environment Setup
# ==========================
LOG_DIR="./logs"
REPORT_DIR="./reports"
SCRIPT_LOG="./script_logs/script_execution.log"

DATE=$(date +%Y-%m-%d)
REPORT_FILE="$REPORT_DIR/daily_report_$DATE.txt"

mkdir -p "$REPORT_DIR"
mkdir -p "./script_logs"

declare -a REPORT_DATA

# ==========================
# Task 08 - Script Logging
# ==========================
write_log() {
    local level="$1"
    local msg="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $msg" >> "$SCRIPT_LOG"
}

# ==========================
# Task 02 - Input Validation
# ==========================
check_directory() {

    if [ ! -d "$LOG_DIR" ]; then
        write_log "ERROR" "Log directory not found."
        echo "Error: Log directory not found."
        exit 1
    fi

    if ! ls "$LOG_DIR"/*.log >/dev/null 2>&1; then
        write_log "ERROR" "No log files found."
        echo "No log files found."
        exit 1
    fi

    for file in "$LOG_DIR"/*.log
    do
        if [ ! -r "$file" ]; then
            write_log "ERROR" "$file is not readable."
            echo "$file is not readable."
            exit 1
        fi
    done

    write_log "INFO" "Directory validation successful."
}

# ==========================
# Task 05 - Data Cleaning
# ==========================
clean_line() {
    local line="$1"

    echo "$line" | sed 's/[[:space:]]\+/ /g' | sed 's/[^[:print:]]//g'
}

# ==========================
# Task 03,04,06 - Process Log
# ==========================
process_log_file() {

    local log_file="$1"

    server=$(basename "$log_file" .log)

    # Nested loop
    while IFS= read -r line
    do
        clean_line "$line" >/dev/null
    done < "$log_file"

    # AWK Counts
    info_count=$(awk '$3=="INFO"{c++} END{print c+0}' "$log_file")
    warn_count=$(awk '$3=="WARNING"{c++} END{print c+0}' "$log_file")
    error_count=$(awk '$3=="ERROR"{c++} END{print c+0}' "$log_file")

    # Status
    if [ "$error_count" -gt 10 ]; then
        status="CRITICAL"
        write_log "WARNING" "High error count in $server"

    elif [ "$warn_count" -gt 20 ]; then
        status="WARNING"

    else
        status="NORMAL"
    fi

    REPORT_DATA+=("$server $info_count $warn_count $error_count $status")
}

# ==========================
# Task 07 - Report Generation
# ==========================
generate_report() {

    echo "Daily Server Health Report" > "$REPORT_FILE"
    echo "Generated: $(date)" >> "$REPORT_FILE"
    echo "-----------------------------------------------" >> "$REPORT_FILE"
    printf "%-10s %-6s %-8s %-6s %-10s\n" "Server" "INFO" "WARNING" "ERROR" "STATUS" >> "$REPORT_FILE"

    for row in "${REPORT_DATA[@]}"
    do
        printf "%-10s %-6s %-8s %-6s %-10s\n" $row >> "$REPORT_FILE"
    done

    write_log "INFO" "Report generated."
}

# ==========================
# Task 10 - Menu
# ==========================
show_menu() {

while true
do

echo
echo "===== Log Monitoring Menu ====="
echo "1. Analyze Logs"
echo "2. Generate Report"
echo "3. View Report"
echo "4. Exit"

read -p "Enter choice: " choice

case $choice in

1)
    REPORT_DATA=()
    check_directory

    for f in "$LOG_DIR"/*.log
    do
        process_log_file "$f"
    done

    echo "Log analysis completed."
    ;;

2)
    generate_report
    echo "Report generated at:"
    echo "$REPORT_FILE"
    ;;

3)
    if [ -f "$REPORT_FILE" ]; then
        cat "$REPORT_FILE"
    else
        echo "Report not found."
    fi
    ;;

4)
    write_log "INFO" "Script completed."
    echo "Exiting..."
    exit 0
    ;;

*)
    echo "Invalid Choice."
    ;;

esac

done
}

# ==========================
# Main
# ==========================
write_log "INFO" "Script started"

show_menu
