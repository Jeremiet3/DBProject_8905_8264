-- Query 2: List Parameter (SELECT) - Enhanced

DECLARE room_type_list VARCHAR2(100) := 'Single, Double';

BEGIN 
  
SELECT IL.LID, IL.Inspection_Date, IL.Inspection_Result, R.Type AS Room_Type,
       SM.First_Name || ' ' || SM.Last_Name AS Inspector_Name
FROM Inspection_Logs IL
JOIN Room R ON IL.RID = R.RID
JOIN Staff_Member SM ON IL.SID = SM.SID
WHERE R.Type IN (:room_type_list)
AND IL.LID IN (
    SELECT MAX(IL2.LID)
    FROM Inspection_Logs IL2
    WHERE IL2.RID = IL.RID
    GROUP BY IL2.RID
)
ORDER BY IL.Inspection_Date DESC;

END;
