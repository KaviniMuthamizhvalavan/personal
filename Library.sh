#!/bin/bash

file="books.txt"
report="library_report.txt"

generate_report() {

    echo "Library Book Report" > "$report"
    echo "---------------------------" >> "$report"

    while read id name copies
    do
        if [ $copies -ge 6 ]
        then
            status="High Stock"
        elif [ $copies -ge 3 ]
        then
            status="Medium Stock"
        else
            status="Low Stock"
        fi

        echo "$id $name $copies Status: $status" >> "$report"

    done < "$file"

    echo "Report Generated Successfully."
}

display_report() {
    cat "$report"
}

if [ ! -f "$file" ]
then
    echo "Book file not found."
    exit
fi

generate_report
display_report
