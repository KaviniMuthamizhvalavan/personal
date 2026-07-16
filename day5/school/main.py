from school import students, teachers, results 

print(students.add_student(101, "Asha")) 
print(teachers.assign_subject("Mr. Sharma", "Mathematics")) 
 
asha_marks = 85
grade = results.calculate_grade(asha_marks) 

student_list = students.view_students() 
teacher_subject = teachers.view_teacher_info("Mr. Sharma") 

print("\n--- Report Card ---")
print(f"Student: {student_list[101]} (ID: 101)")
print(f"Subject: {teacher_subject}")
print(f"Score: {asha_marks}% | Final Grade: {grade}")
