-- Query to retrieve surgery details within the last 4 years
SELECT 
  SurgeryID, 
  SurgeryDate, 
  SurgeryType, 
  RoomID, 
  PatientFirstName, 
  PatientLastName, 
  DoctorFirstName, 
  DoctorLastName
FROM 
  Surgery_Details_View
WHERE 
  SurgeryDate BETWEEN SYSDATE - 1460   AND SYSDATE  -- 1460 days == 4 years
order by surgeryDate
