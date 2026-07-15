# services/appointment_service.py
class AppointmentService:
    def __init__(self, datastore):
        self.datastore = datastore 

    def create_appointment(self, appointment):
        # Verify that both patient and doctor exist before linking 
        if appointment.patient_id not in self.datastore["patients"]:
            raise ValueError(f"Patient ID {appointment.patient_id} does not exist.")
        if appointment.doctor_id not in self.datastore["doctors"]:
            raise ValueError(f"Doctor ID {appointment.doctor_id} does not exist.")
        
        self.datastore["appointments"][appointment.id] = appointment 

    def get_appointment(self, appointment_id):
        appointment = self.datastore["appointments"].get(appointment_id) 
        if appointment:
            return appointment.display_info()
        return None

    def update_appointment(self, appointment_id, date=None, time=None):
        if appointment_id in self.datastore["appointments"]:
            if date:
                self.datastore["appointments"][appointment_id].date = date 
            if time:
                self.datastore["appointments"][appointment_id].time = time 
            return True
        return False

    def delete_appointment(self, appointment_id):
        if appointment_id in self.datastore["appointments"]:
            del self.datastore["appointments"][appointment_id] 
            return True
        return False
