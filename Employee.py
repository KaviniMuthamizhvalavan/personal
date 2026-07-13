# Employee Management System

# Creating a dictionary
employees = {
    101: {
        "name": "Ravi",
        "dept": "IT",
        "salary": 50000
    },
    102: {
        "name": "Anu",
        "dept": "HR",
        "salary": 45000
    },
    103: {
        "name": "John",
        "dept": "Finance",
        "salary": 55000
    }
}

# Display all employees
print("Employee Details:")
for emp_id, details in employees.items():
    print(f"\nEmployee ID: {emp_id}")
    print(f"Name: {details['name']}")
    print(f"Department: {details['dept']}")
    print(f"Salary: {details['salary']}")

# Search employee by ID
emp_id = int(input("\nEnter Employee ID to search: "))

if emp_id in employees:
    print("\nEmployee Found")
    print("Name:", employees[emp_id]["name"])
    print("Department:", employees[emp_id]["dept"])
    print("Salary:", employees[emp_id]["salary"])
else:
    print("Employee not found.")

# Add a new employee
new_id = int(input("\nEnter New Employee ID: "))
name = input("Enter Name: ")
dept = input("Enter Department: ")
salary = int(input("Enter Salary: "))

employees[new_id] = {
    "name": name,
    "dept": dept,
    "salary": salary
}

print("\nEmployee added successfully!")

# Update salary
update_id = int(input("\nEnter Employee ID to update salary: "))

if update_id in employees:
    new_salary = int(input("Enter New Salary: "))
    employees[update_id]["salary"] = new_salary
    print("Salary updated successfully!")
else:
    print("Employee not found.")

# Display updated dictionary
print("\nUpdated Employee Records:")
for emp_id, details in employees.items():
    print(f"{emp_id} : {details}")
