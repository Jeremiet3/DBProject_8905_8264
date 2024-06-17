-- Query 3: Staff Members with Most Maintenance Requests in a Year

SELECT 
    sm.SID,
    sm.First_Name,
    sm.Last_Name,
    COUNT(mr.MID) AS Number_Of_Requests,
    EXTRACT(YEAR FROM mr.Date_Reported) AS Year
FROM 
    Maintenance_Request mr
JOIN 
    Staff_Member sm ON mr.SID = sm.SID
WHERE 
    EXTRACT(YEAR FROM mr.Date_Reported) = 2023 
GROUP BY 
    sm.SID,
    sm.First_Name,
    sm.Last_Name,
    EXTRACT(YEAR FROM mr.Date_Reported)
ORDER BY 
    Number_Of_Requests DESC;
