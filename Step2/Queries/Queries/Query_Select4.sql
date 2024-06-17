-- Query 4 : Total Quantity of Cleaning Supplies Used in Specific Year and Room Type

SELECT 
    cs.Name AS Cleaning_Supply,
    SUM(nf.Quantity) AS Total_Quantity_Used,
    rt.Year,
    rt.Room_Type
FROM 
    Cleaning_Supply cs
JOIN 
    Need_for nf ON cs.SUID = nf.SUID
JOIN (
    SELECT 
        r.RID,
        r.Type AS Room_Type,
        EXTRACT(YEAR FROM il.Inspection_Date) AS Year
    FROM 
        Room r
    JOIN 
        Inspection_Logs il ON r.RID = il.RID
    WHERE 
        EXTRACT(YEAR FROM il.Inspection_Date) = 2023 
) rt ON nf.RID = rt.RID
GROUP BY 
    cs.Name,
    rt.Year,
    rt.Room_Type
ORDER BY 
    rt.Room_Type,
    Total_Quantity_Used DESC;
