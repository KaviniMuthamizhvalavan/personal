#!/bin/bash

# ===========================
# Task 01 - Environment Setup
# ===========================

ORDER_DIR="./orders"
REPORT_DIR="./reports"
ALERT_LOG="./alert_logs/alert_log.txt"

DATE=$(date +%Y-%m-%d)
REPORT_FILE="$REPORT_DIR/sales_$DATE.csv"

mkdir -p "$REPORT_DIR"
mkdir -p "./alert_logs"

declare -a REPORT_DATA

# ===========================
# Alert Logging
# ===========================

write_alert() {
    local level="$1"
    local msg="$2"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $msg" >> "$ALERT_LOG"
}

# ===========================
# Task 02 - File Validation
# ===========================

validate_files() {

    if [ ! -d "$ORDER_DIR" ]; then
        write_alert "ERROR" "Order directory not found."
        exit 1
    fi

    if ! ls "$ORDER_DIR"/*.csv >/dev/null 2>&1; then
        write_alert "ERROR" "No CSV files found."
        exit 1
    fi

    for file in "$ORDER_DIR"/*.csv
    do
        if [ ! -s "$file" ]; then
            write_alert "ERROR" "$file is empty."
            exit 1
        fi
    done

    write_alert "INFO" "Validation completed."
}

# ===========================
# Task 03-07
# ===========================

process_store() {

    local csv_file="$1"
    local store=$(basename "$csv_file" .csv)

    # Nested Loop
    while IFS=',' read -r order_id date status category amount
    do
        [ "$order_id" = "OrderID" ] && continue
    done < "$csv_file"

    # Task 04 - grep
    failed_count=$(grep -c ",FAILED," "$csv_file")
    pending_count=$(grep -c ",PENDING," "$csv_file")
    refund_count=$(grep -c ",REFUNDED," "$csv_file")

    # Task 05 - cut & sort
    amounts=$(grep ",COMPLETED," "$csv_file" | cut -d',' -f5)

    top_orders=$(grep ",COMPLETED," "$csv_file" \
        | cut -d',' -f5 \
        | sort -nr \
        | head -5)

    echo "Top Orders:"
    echo "$top_orders"

    # Task 06 - awk
    revenue=$(awk -F',' '$3=="COMPLETED"{sum+=$5} END{printf "%.2f",sum}' "$csv_file")

    total=$(awk 'END{print NR-1}' "$csv_file")

    avg=$(awk -F',' '
    $3=="COMPLETED"{sum+=$5;c++}
    END{
        if(c>0)
            printf "%.2f",sum/c;
        else
            print 0
    }' "$csv_file")

    # Task 07 - Status
    if [ "$failed_count" -gt 30 ]; then
        status="CRITICAL"
        write_alert "CRITICAL" "$store has high failed orders."

    elif [ "$refund_count" -gt 20 ]; then
        status="WARNING"
        write_alert "WARNING" "$store has high refunds."

    else
        status="OK"
        write_alert "INFO" "$store operating normally."
    fi

    REPORT_DATA+=("$store,$revenue,$total,$failed_count,$status")
}

# ===========================
# Task 08 - CSV Report
# ===========================

generate_csv() {

    echo "Store,Revenue,Orders,Failed,Status" > "$REPORT_FILE"

    for row in "${REPORT_DATA[@]}"
    do
        echo "$row" >> "$REPORT_FILE"
    done

    write_alert "INFO" "CSV Report Generated."
}

# ===========================
# Task 10 - Menu
# ===========================

show_menu() {

while true
do

echo
echo "===== Sales Monitoring Menu ====="
echo "1. Process Today's Orders"
echo "2. Generate CSV Report"
echo "3. View Alert Log"
echo "4. Exit"

read -p "Enter choice: " choice

case $choice in

1)
    REPORT_DATA=()
    validate_files

    for file in "$ORDER_DIR"/*.csv
    do
        process_store "$file"
    done

    echo "Processing Completed."
    ;;

2)
    generate_csv
    echo "Report saved to $REPORT_FILE"
    ;;

3)
    cat "$ALERT_LOG"
    ;;

4)
    write_alert "INFO" "Program terminated."
    exit 0
    ;;

*)
    echo "Invalid Choice."
    ;;

esac

done
}

# ===========================
# Main
# ===========================

write_alert "INFO" "Script Started"

show_menu
