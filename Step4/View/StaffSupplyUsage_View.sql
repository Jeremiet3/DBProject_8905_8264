-- Create a view to track staff supply usage
CREATE VIEW StaffSupplyUsage AS
SELECT 
    sm.SID,
    sm.FirstName || ' ' || sm.LastName AS Staff_Name,
    smi.Phone_Number,
    cs.SUID,
    cs.Name AS Supply_Name,
    cs.Total_Quantity,
    cs.Location,
    NVL(SUM(nf.Quantity), 0) AS Total_Used
FROM Staff_Member sm
LEFT JOIN Staff_Member_Info smi ON sm.SID = smi.SID
LEFT JOIN Cleaning_Task ct ON sm.SID = ct.SID
LEFT JOIN Need_for nf ON ct.TID = nf.TID AND ct.RID = nf.RID AND ct.SID = nf.SID
LEFT JOIN Cleaning_Supply cs ON nf.SUID = cs.SUID
GROUP BY sm.SID, sm.FirstName, sm.LastName, smi.Phone_Number, cs.SUID, cs.Name, cs.Total_Quantity, cs.Location;
