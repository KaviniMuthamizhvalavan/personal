# tests/test_doctor.py
from models.doctor import Doctor
from services.doctor_service import DoctorService

# Tests Doctor CRUD operations 
def test_create_and_read_doctor():
    datastore = {"patients": {}, "doctors": {}, "appointments": {}} 
    service = DoctorService(datastore)
    
    d = Doctor(101, "Dr. Alice", 45, "Cardiology")
    service.add_doctor(d) 
    
    # Read and verify details 
    info = service.get_doctor(101)
    assert info is not None
    assert "Dr. Alice" in info
    assert "Cardiology" in info

def test_update_doctor():
    datastore = {"patients": {}, "doctors": {}, "appointments": {}} 
    service = DoctorService(datastore)
    
    d = Doctor(101, "Dr. Alice", 45, "Cardiology")
    service.add_doctor(d) 
    
    # Update specialization and assert change 
    service.update_doctor(101, "Neurology")
    assert datastore["doctors"][101].specialization == "Neurology"

def test_delete_doctor():
    datastore = {"patients": {}, "doctors": {}, "appointments": {}} 
    service = DoctorService(datastore)
    
    d = Doctor(101, "Dr. Alice", 45, "Cardiology")
    service.add_doctor(d) 
    
    # Delete and assert removal 
    service.delete_doctor(101)
    assert service.get_doctor(101) is None
