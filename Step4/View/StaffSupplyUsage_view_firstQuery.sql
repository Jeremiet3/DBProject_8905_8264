-- Query to summarize staff supply usage
SELECT 
    Staff_Name,
    Phone_Number,
    SUM(Total_Used) AS Total_Supplies_Used,
    LISTAGG(Supply_Name || ': ' || Total_Used, ', ') WITHIN GROUP (ORDER BY Supply_Name) AS Supply_Usage_Breakdown
FROM StaffSupplyUsage
WHERE Total_Used > 0
GROUP BY SID, Staff_Name, Phone_Number
ORDER BY Total_Supplies_Used DESC;
