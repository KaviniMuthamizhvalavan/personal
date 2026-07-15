# services/doctor_service.py
class DoctorService:
    def __init__(self, datastore):
        self.datastore = datastore 

    def add_doctor(self, doctor):
        self.datastore["doctors"][doctor.id] = doctor 

    def get_doctor(self, doctor_id):
        doctor = self.datastore["doctors"].get(doctor_id) 
        if doctor:
            return doctor.display_info()
        return None

    def update_doctor(self, doctor_id, specialization):
        if doctor_id in self.datastore["doctors"]:
            self.datastore["doctors"][doctor_id].specialization = specialization 
            return True
        return False

    def delete_doctor(self, doctor_id):
        if doctor_id in self.datastore["doctors"]:
            del self.datastore["doctors"][doctor_id] 
            return True
        return False
