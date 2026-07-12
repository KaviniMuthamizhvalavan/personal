#!/bin/bash

file="courses.txt"
report="course_report.txt"

# Function to identify course type
course_type() {
    if [ "$1" = "Linux" ]
    then
        type="System Course"
    else
        type="Programming Course"
    fi
}

# Function to generate report
generate_report() {

    total=0

    echo "Course Enrollment Report" > "$report"
    echo "------------------------" >> "$report"

    while read name course fee
    do
        course_type "$course"

        echo "$name enrolled in $course Fee: $fee Type: $type" >> "$report"

        total=$((total + fee))

    done < "$file"

    echo "------------------------" >> "$report"
    echo "Total Revenue: $total" >> "$report"
}

# Check file
if [ ! -f "$file" ]
then
    echo "File not found."
    exit
fi

generate_report

echo "Report Generated Successfully."
cat "$report"
