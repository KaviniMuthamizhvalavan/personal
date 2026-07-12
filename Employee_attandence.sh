#!/bin/bash

echo "========================================="
echo " EMPLOYEE ATTENDANCE VALIDATION SYSTEM "
echo "========================================="

# Accept employee details
echo -n "Enter Employee ID: "
read empid

echo -n "Enter Employee Name: "
read name

echo -n "Enter Working Hours: "
read hours

# Variables
normal_hours=8

echo
echo "Employee ID   : $empid"
echo "Employee Name : $name"
echo "Working Hours : $hours"

# Conditional Statements and Operators
if [ $hours -lt $normal_hours ]
then
    echo "Status : Less than normal working hours."
    echo "Hours Short : $((normal_hours-hours))"

elif [ $hours -eq $normal_hours ]
then
    echo "Status : Normal working hours completed."
    echo "No Overtime."

else
    overtime=$((hours-normal_hours))
    echo "Status : Overtime Worked."
    echo "Overtime Hours : $overtime"
fi

echo
echo "Attendance Validation Completed."
