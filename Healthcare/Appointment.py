# models/appointment.py
class Appointment:
    def __init__(self, id, patient_id, doctor_id, date, time):
        self.id = id
        self.patient_id = patient_id  # Associates a patient 
        self.doctor_id = doctor_id    # Associates a doctor 
        self.date = date
        self.time = time

    def get_details(self):
        return {
            "id": self.id,
            "patient_id": self.patient_id,
            "doctor_id": self.doctor_id,
            "date": self.date,
            "time": self.time
        }

    def display_info(self):
        return (f"Appointment ID: {self.id}, Patient ID: {self.patient_id}, "
                f"Doctor ID: {self.doctor_id}, Date: {self.date}, Time: {self.time}")
