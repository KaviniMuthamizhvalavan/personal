_teacher_db = {}

def assign_subject(teacher_name, subject):
    """Assign a subject to a teacher."""
    _teacher_db[teacher_name] = subject
    return f"Assigned {subject} to {teacher_name}."

def view_teacher_info(teacher_name):
    """Get assigned subject for a teacher."""
    return _teacher_db.get(teacher_name, "Teacher not found.")
