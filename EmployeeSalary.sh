#!/bin/bash

bonus() {
    bonus=$(( $1 * 10 / 100 ))
}

total() {
    total=$(( $1 + bonus ))
}

echo "Enter Employee File:"
read file

if [ ! -f "$file" ]
then
    echo "File not found"
    exit
fi

echo "Employee Salary Report" > salary_report.txt
echo "----------------------------------------" >> salary_report.txt

while read name dept salary
do
    bonus $salary
    total $salary

    echo "$name $dept Basic:$salary Bonus:$bonus Total:$total" >> salary_report.txt

done < "$file"

echo "Report Generated Successfully."

cat salary_report.txt
