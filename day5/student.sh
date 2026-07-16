names=()
python_marks=()
sql_marks=()
linux_marks=()

while true
do
        echo
        echo "==================="
        echo "Student Performance System"
        echo "1. Add Student"
        echo "2. Display Students"
        echo "3. Search Student"
        echo "4. Class Average"
        echo "5. Exit"
        echo "===================="

        read -p "Enter your choice: " choice
        case $choice in
        1)
                read -p "Enter Student
