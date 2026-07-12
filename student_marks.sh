echo "Creating directories..."
 
mkdir -p input reports archive
 
# Create student marks file
cat > input/students.txt << EOF
101,Alice,85
102,Bob,45
103,Charlie,72
104,David,91
105,Eva,38
106,Frank,67
EOF
 
echo
echo "Student Marks File"
cat input/students.txt
 
echo
echo "Current User:"
whoami
 
echo
echo "Current Date:"
date
 
echo
echo "Current Directory:"
pwd
 
echo
echo "Environment Variable"
export STUDENT_HOME=$(pwd)
echo $STUDENT_HOME
 
echo
echo "Students Who Passed"
awk -F',' '$3>=50 {print $2,"-",$3}' input/students.txt
 
echo
echo "Students Who Failed"
awk -F',' '$3<50 {print $2,"-",$3}' input/students.txt
 
echo
echo "Average Marks"
awk -F',' '{sum+=$3} END{print sum/NR}' input/students.txt
 
echo
echo "Highest Marks"
awk -F',' 'BEGIN{max=0} {if($3>max) max=$3} END{print max}' input/students.txt
 
echo
echo "Search for Alice"
grep "Alice" input/students.txt
 
echo
echo "Replacing Alice with Alicia (display only)"
sed 's/Alice/Alicia/' input/students.txt
 
echo
echo "Generating Report..."
 
{
echo "STUDENT PERFORMANCE REPORT"
echo "=========================="
 
awk -F',' '{
if($3>=50)
status="PASS";
else
status="FAIL";
 
print "ID:",$1,"\tName:",$2,"\tMarks:",$3,"\tStatus:",status
}' input/students.txt
 
echo
echo "Average Marks:"
awk -F',' '{sum+=$3} END{print sum/NR}' input/students.txt
 
} > reports/report.txt
 
echo
echo "Report Generated Successfully"
 
cat reports/report.txt
 
echo
echo "Compressing Report..."
 
tar -czf archive/report.tar.gz reports
 
echo "Archive Created: archive/report.tar.gz"
 
echo
echo "Running Processes"
ps
 
echo
echo "Completed Successfully."
