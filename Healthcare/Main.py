# main.py
from models.patient import Patient
from models.doctor import Doctor
from models.appointment import Appointment
from services.healthcare_system import HealthcareSystem
from data.datastore import datastore
from utils.logger import logger
from utils.validators import validate_patient, validate_doctor

# Initialize the orchestrator system 
system = HealthcareSystem(datastore)

logger.info("Starting Healthcare Management System workflow...") 

# 1. Create and Validate Patients 
try:
    validate_patient(1, "John Doe", 30, "Flu")
    validate_patient(2, "Jane Smith", 25, "Cold")
    p1 = Patient(1, "John Doe", 30, "Flu")
    p2 = Patient(2, "Jane Smith", 25, "Cold")
    system.patient_service.add_patient(p1)
    system.patient_service.add_patient(p2)
    logger.info("Patients added successfully.") 
except ValueError as e:
    logger.error(f"Patient validation failed: {e}") 

# 2. Create and Assign Doctors 
try:
    validate_doctor(101, "Dr. Sarah Jenkins", 45, "General Physician")
    d1 = Doctor(101, "Dr. Sarah Jenkins", 45, "General Physician")
    system.doctor_service.add_doctor(d1)
    logger.info("Doctor assigned successfully.") 
except ValueError as e:
    logger.error(f"Doctor validation failed: {e}") 

# 3. Create Appointment 
try:
    app1 = Appointment(1001, patient_id=1, doctor_id=101, date="2026-07-20", time="10:30 AM") 
    system.appointment_service.create_appointment(app1)
    logger.info("Appointment created successfully.") 
except ValueError as e:
    logger.error(f"Appointment creation failed: {e}") 

# 4. Display System Information 
print("\n--- Current System Records ---")
print("Patient Details:", system.patient_service.get_patient(1))
print("Doctor Details:", system.doctor_service.get_doctor(101))
print("Appointment Details:", system.appointment_service.get_appointment(1001))
