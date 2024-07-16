-- Query to count total surgeries performed by each doctor
SELECT 
  DoctorID, 
  DoctorFirstName, 
  DoctorLastName, 
  COUNT(SurgeryID) AS Total_Surgeries
FROM 
  Surgery_Details_View
GROUP BY 
  DoctorID, 
  DoctorFirstName, 
  DoctorLastName;
