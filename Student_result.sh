#!/bin/bash

name=$1
mark1=$2
mark2=$3
mark3=$4
mark4=$5
mark5=$6

total=$((mark1 + mark2 + mark3 + mark4 + mark5))
avg=$((total / 5))

echo "Student Name : $name"
echo "Total Marks  : $total"
echo "Percentage   : $avg%"

if [ $avg -ge 50 ]
then
    result="PASS"
else
    result="FAIL"
fi

if [ $avg -ge 90 ]
then
    grade="A"
elif [ $avg -ge 75 ]
then
    grade="B"
elif [ $avg -ge 60 ]
then
    grade="C"
elif [ $avg -ge 50 ]
then
    grade="D"
else
    grade="F"
fi

echo "Result : $result"
echo "Grade  : $grade"
