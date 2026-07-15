# tests/test_doctor.py
import unittest
from models.doctor import Doctor
from services.doctor_service import DoctorService

class TestDoctorService(unittest.TestCase):
    def setUp(self):
        self.datastore = {"patients": {}, "doctors": {}, "appointments": {}} 
        self.service = DoctorService(self.datastore)

    def test_doctor_crud(self):
        # Create and Read 
        d = Doctor(101, "Dr. Alice", 45, "Cardiology")
        self.service.add_doctor(d)
        self.assertIn("Cardiology", self.service.get_doctor(101))
        
        # Update 
        self.service.update_doctor(101, "Neurology")
        self.assertEqual(self.datastore["doctors"][101].specialization, "Neurology")
        
        # Delete 
        self.service.delete_doctor(101)
        self.assertIsNone(self.service.get_doctor(101))

if __name__ == '__main__':
    unittest.main()
