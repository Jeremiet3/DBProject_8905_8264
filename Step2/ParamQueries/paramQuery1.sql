-- Query1: Cleaning Tasks and Supplies Needed by Room

SELECT 
    ct.TID, 
    r.RID, 
    r.Type, 
    ct.Status AS Task_Status, 
    cs.Name AS Supply_Name, 
    nf.Quantity AS Supply_Quantity
FROM 
    Cleaning_Task ct
JOIN 
    Room r ON ct.RID = r.RID
JOIN 
    Need_for nf ON ct.TID = nf.TID AND ct.RID = nf.RID AND ct.SID = nf.SID
JOIN 
    Cleaning_Supply cs ON nf.SUID = cs.SUID
WHERE 
    r.Type = '&<name="Room Type" list="select DISTINCT Type from Room order by Type">'
    AND ct.Status = '&<name="Task Status" list="select DISTINCT Status from Cleaning_Task order by Status">'
    AND nf.Quantity >= &<name="Minimum Supply Quantity" type="integer">
ORDER BY 
    r.RID, ct.TID;
