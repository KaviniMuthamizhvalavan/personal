# tests/test_appointment.py
import unittest
from models.patient import Patient
from models.doctor import Doctor
from models.appointment import Appointment
from services.healthcare_system import HealthcareSystem

class TestAppointmentService(unittest.TestCase):
    def setUp(self):
        self.datastore = {"patients": {}, "doctors": {}, "appointments": {}} 
        self.system = HealthcareSystem(self.datastore)
        self.system.patient_service.add_patient(Patient(1, "John Doe", 30, "Flu"))
        self.system.doctor_service.add_doctor(Doctor(101, "Dr. Alice", 45, "General"))

    def test_appointment_linking_and_retrieval(self):
        # Create appointment linking patient and doctor 
        app = Appointment(1001, 1, 101, "2026-07-20", "10:00 AM")
        self.system.appointment_service.create_appointment(app)
        
        info = self.system.appointment_service.get_appointment(1001)
        self.assertIn("Patient ID: 1", info)
        self.assertIn("Doctor ID: 101", info)

if __name__ == '__main__':
    unittest.main()
