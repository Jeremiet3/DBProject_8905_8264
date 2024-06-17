-- Query 3: Complex Parameterized SELECT
DECLARE
   occupancy_status_parameter VARCHAR2(30) := 'Occupied';


SELECT R.RID, R.Type AS Room_Type, R.Occupancy_Status, R.Cleaning_Status,
       COUNT(CT.TID) AS Num_Tasks, MAX(CT.Status) AS Latest_Task_Status,
       CS.Name AS Cleaning_Supply, CS.Total_Quantity AS Available_Quantity
FROM Room R
LEFT JOIN Cleaning_Task CT ON R.RID = CT.RID
LEFT JOIN Cleaning_Supply CS ON R.RID = CS.SUID
WHERE R.Occupancy_Status = :occupancy_status_parameter
GROUP BY R.RID, R.Type, R.Occupancy_Status, R.Cleaning_Status, CS.Name, CS.Total_Quantity
ORDER BY Num_Tasks DESC;
