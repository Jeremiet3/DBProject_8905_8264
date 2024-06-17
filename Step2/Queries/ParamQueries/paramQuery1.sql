DECLARE 
  report_date_parameter DATE := TO_DATE('01-01-2023', 'MM-DD-YYYY');

BEGIN

  SELECT MR.MID, MR.Issue_Description, MR.Date_Reported, R.Type AS Room_Type, 
         SM.First_Name || ' ' || SM.Last_Name AS Assigned_Staff,
         (SELECT COUNT(CT.TID) FROM Cleaning_Task CT WHERE CT.RID = MR.RID) AS Num_Tasks
  FROM Maintenance_Request MR
  JOIN Room R ON MR.RID = R.RID
  JOIN Staff_Member SM ON MR.SID = SM.SID
  WHERE MR.Date_Reported >= :report_date_parameter
  ORDER BY MR.Date_Reported DESC;

END;
/
