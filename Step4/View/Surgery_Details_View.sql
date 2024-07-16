-- Create a view to display surgery details including patient and doctor information
CREATE VIEW Surgery_Details_View AS
SELECT 
  Surgery.SurgeryID,
  Surgery.SurgeryDate,
  Surgery.SurgeryType,
  Surgery.RoomID,
  Surgery.PatientID,
  Patient.FirstName AS PatientFirstName,
  Patient.LastName AS PatientLastName,
  Doctor.DoctorID,
  Doctor.FirstName AS DoctorFirstName,
  Doctor.LastName AS DoctorLastName
FROM 
  Surgery
JOIN 
  Patient ON Surgery.PatientID = Patient.PatientID
JOIN 
  Doctor ON Surgery.DoctorID = Doctor.DoctorID;
