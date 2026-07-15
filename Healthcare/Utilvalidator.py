# utils/validators.py
def validate_person_data(id, name, age):
    if not isinstance(id, int) or id <= 0:
        raise ValueError("ID must be a positive integer.")
    if not isinstance(name, str) or not name.strip():
        raise ValueError("Name cannot be empty.")
    if not isinstance(age, int) or age <= 0 or age > 130:
        raise ValueError("Age must be between 1 and 130.")
    return True

# Input validation for patient data 
def validate_patient(id, name, age, ailment):
    validate_person_data(id, name, age)
    if not isinstance(ailment, str) or not ailment.strip():
        raise ValueError("Ailment cannot be empty.")
    return True

# Input validation for doctor data 
def validate_doctor(id, name, age, specialization):
    validate_person_data(id, name, age)
    if not isinstance(specialization, str) or not specialization.strip():
        raise ValueError("Specialization cannot be empty.")
    return True
