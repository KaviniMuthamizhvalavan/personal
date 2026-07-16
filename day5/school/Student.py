_student_db = {}

def add_student(student_id, name):
    """Add a student to the database."""
    _student_db[student_id] = name
    return f"Student {name} added."

def view_students():
    """Return a list of all enrolled students."""
    return _student_db
