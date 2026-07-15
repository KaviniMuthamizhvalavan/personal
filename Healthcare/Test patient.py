# tests/test_patient.py
import unittest
from models.patient import Patient
from services.patient_service import PatientService

class TestPatientService(unittest.TestCase):
    def setUp(self):
        self.datastore = {"patients": {}, "doctors": {}, "appointments": {}} 
        self.service = PatientService(self.datastore)

    def test_patient_crud(self):
        # Create and Read 
        p = Patient(1, "John Doe", 30, "Flu")
        self.service.add_patient(p)
        self.assertIn("John Doe", self.service.get_patient(1))
        
        # Update 
        self.service.update_patient(1, "Recovered")
        self.assertEqual(self.datastore["patients"][1].ailment, "Recovered")
        
        # Delete 
        self.service.delete_patient(1)
        self.assertIsNone(self.service.get_patient(1))

if __name__ == '__main__':
    unittest.main()
