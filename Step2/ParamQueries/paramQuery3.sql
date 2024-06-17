--Query3: Maintenance Requests by Room and Staff Member within a Date Range

SELECT 
    mr.MID, 
    r.RID, 
    r.Type, 
    sm.First_Name, 
    sm.Last_Name, 
    mr.Issue_Description, 
    mr.Date_Reported
FROM 
    Maintenance_Request mr
JOIN 
    Room r ON mr.RID = r.RID
JOIN 
    Staff_Member sm ON mr.SID = sm.SID
WHERE 
    mr.Date_Reported BETWEEN TO_DATE(&<name="Start Date" hint="Enter the start date in format YYYY-MM-DD" type="string">, 'YYYY-MM-DD') 
    AND TO_DATE(&<name="End Date" hint="Enter the end date in format YYYY-MM-DD" type="string">, 'YYYY-MM-DD')
    AND r.Type = '&<name="Room Type" list="select DISTINCT Type from Room order by Type">'
ORDER BY 
    mr.Date_Reported DESC;
