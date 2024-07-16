-- Query to determine supply restock status 
SELECT 
    Supply_Name,
    Total_Quantity AS Current_Stock,
    Location,
    SUM(Total_Used) AS Total_Used,
    COUNT(DISTINCT SID) AS Staff_Using,
    CASE 
        WHEN Total_Quantity <= SUM(Total_Used) * 0.2 THEN 'Urgent'
        WHEN Total_Quantity <= SUM(Total_Used) * 0.5 THEN 'Low'
        ELSE 'Sufficient'
    END AS Restock_Status
FROM StaffSupplyUsage
WHERE SUID IS NOT NULL
GROUP BY Supply_Name, Total_Quantity, Location
HAVING SUM(Total_Used) > 0
ORDER BY 
    CASE Restock_Status
        WHEN 'Urgent' THEN 1
        WHEN 'Low' THEN 2
        ELSE 3
    END,
    Total_Used DESC;
