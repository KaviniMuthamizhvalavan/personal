# models/doctor.py
from models.person import Person

class Doctor(Person):
    def __init__(self, id, name, age, specialization):
        super().__init__(id, name, age)  # Inherits id, name, age from Person 
        self.specialization = specialization 

    def get_details(self):
        details = super().get_details()  # Override to include specialization 
        details.update({"specialization": self.specialization})
        return details

    def display_info(self):
        return f"{super().display_info()}, Specialization: {self.specialization}"
