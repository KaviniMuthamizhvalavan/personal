names=()
python_marks=()
sql_marks=()
linux_marks=()

while true
do
    echo
    echo "==============================="
    echo "Student Performance System"
    echo "1. Add Student"
    echo "2. Display Students"
    echo "3. Search Student"
    echo "4. Class Average"
    echo "5. Exit"
    echo "==============================="

    read -p "Enter your choice: " choice

    case $choice in

    1)
        read -p "Enter student name: " name

        read -p "Enter Python marks: " py
        while [ $py -lt 0 ] || [ $py -gt 100 ]
        do
            echo "Invalid Marks! Enter between 0 and 100."
            read -p "Enter Python marks: " py
        done

        read -p "Enter SQL marks: " sql
        while [ $sql -lt 0 ] || [ $sql -gt 100 ]
        do
            echo "Invalid Marks! Enter between 0 and 100."
            read -p "Enter SQL marks: " sql
        done

        read -p "Enter Linux marks: " linux
        while [ $linux -lt 0 ] || [ $linux -gt 100 ]
        do
            echo "Invalid Marks! Enter between 0 and 100."
            read -p "Enter Linux marks: " linux
        done

        names+=("$name")
        python_marks+=($py)
        sql_marks+=($sql)
        linux_marks+=($linux)

        echo "Student added successfully."
        ;;

    2)
        if [ ${#names[@]} -eq 0 ]
        then
            echo "No student records found."
        else
            for ((i=0; i<${#names[@]}; i++))
            do
                total=$((python_marks[i]+sql_marks[i]+linux_marks[i]))
                avg=$((total/3))

                if [ $avg -ge 85 ]
                then
                    grade="A"
                elif [ $avg -ge 70 ]
                then
                    grade="B"
                elif [ $avg -ge 50 ]
                then
                    grade="C"
                else
                    grade="Fail"
                fi

                echo
                echo "Name : ${names[i]}"
                echo "Marks : ${python_marks[i]} ${sql_marks[i]} ${linux_marks[i]}"
                echo "Total : $total"
                echo "Average : $avg"
                echo "Grade : $grade"
            done
        fi
        ;;

    3)
        read -p "Enter student name to search: " search
        found=0

        for ((i=0; i<${#names[@]}; i++))
        do
            if [ "${names[i]}" = "$search" ]
            then
                total=$((python_marks[i]+sql_marks[i]+linux_marks[i]))
                avg=$((total/3))

                if [ $avg -ge 85 ]
                then
                    grade="A"
                elif [ $avg -ge 70 ]
                then
                    grade="B"
                elif [ $avg -ge 50 ]
                then
                    grade="C"
                else
                    grade="Fail"
                fi

                echo
                echo "Student Found"
                echo "Name : ${names[i]}"
                echo "Marks : ${python_marks[i]} ${sql_marks[i]} ${linux_marks[i]}"
                echo "Total : $total"
                echo "Average : $avg"
                echo "Grade : $grade"

                found=1
                break
            fi
        done

        if [ $found -eq 0 ]
        then
            echo "Student not found."
        fi
        ;;

    4)
        if [ ${#names[@]} -eq 0 ]
        then
            echo "No student records found."
        else
            sum=0

            for ((i=0; i<${#names[@]}; i++))
            do
                total=$((python_marks[i]+sql_marks[i]+linux_marks[i]))
                avg=$((total/3))
                sum=$((sum+avg))
            done

            class_avg=$((sum/${#names[@]}))

            echo "Class Average : $class_avg"
        fi
        ;;

    5)
        echo "Exiting program..."
        break
        ;;

    *)
        echo "Invalid Choice!"
        ;;
    esac

done
