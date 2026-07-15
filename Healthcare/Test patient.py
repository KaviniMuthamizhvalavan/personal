# tests/test_patient.py
from models.patient import Patient
from services.patient_service import PatientService

# Tests Patient CRUD operations 
def test_create_and_read_patient():
    datastore = {"patients": {}, "doctors": {}, "appointments": {}} 
    service = PatientService(datastore)
    
    p = Patient(1, "John Doe", 30, "Flu")
    service.add_patient(p) 
    
    # Read and verify details 
    info = service.get_patient(1)
    assert info is not None
    assert "John Doe" in info
    assert "Flu" in info

def test_update_patient():
    datastore = {"patients": {}, "doctors": {}, "appointments": {}} 
    service = PatientService(datastore)
    
    p = Patient(1, "John Doe", 30, "Flu")
    service.add_patient(p) 
    
    # Update ailment and assert change 
    service.update_patient(1, "Recovered")
    assert datastore["patients"][1].ailment == "Recovered"

def test_delete_patient():
    datastore = {"patients": {}, "doctors": {}, "appointments": {}} 
    service = PatientService(datastore)
    
    p = Patient(1, "John Doe", 30, "Flu")
    service.add_patient(p) 
    
    # Delete and assert removal 
    service.delete_patient(1)
    assert service.get_patient(1) is None
