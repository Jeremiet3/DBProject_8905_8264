-- Update Room Cleaning Status Based on Recent Inspection Results

UPDATE Room
SET Cleaning_Status = 'Dirty'
WHERE RID IN (
    SELECT RID
    FROM (
        SELECT il.RID, il.Inspection_Result,
               ROW_NUMBER() OVER (PARTITION BY il.RID ORDER BY il.Inspection_Date DESC) AS rn
        FROM Inspection_Logs il
    ) subquery
    WHERE subquery.rn = 1 AND subquery.Inspection_Result = 'Fail'
);
