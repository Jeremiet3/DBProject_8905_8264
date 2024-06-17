-- Query 4: Name Parameter (UPDATE) - Enhanced
DECLARE
   staff_last_name VARCHAR2(30) := 'Smith';
UPDATE Room
SET Cleaning_Status = 'Clean'
WHERE RID IN (
    SELECT CT.RID
    FROM Cleaning_Task CT
    WHERE CT.SID IN (
        SELECT SM.SID
        FROM Staff_Member SM
        WHERE SM.Last_Name = :staff_last_name
    )
    GROUP BY CT.RID
    HAVING COUNT(CT.TID) = (
        SELECT COUNT(TID)
        FROM Cleaning_Task
        WHERE RID = CT.RID
    )
)
