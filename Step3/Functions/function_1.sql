CREATE OR REPLACE FUNCTION get_room_cleaning_efficiency
RETURN SYS_REFCURSOR
IS
    v_result SYS_REFCURSOR;
BEGIN
    OPEN v_result FOR
        SELECT 
            r.RID,
            r.Type,
            COUNT(ct.TID) as Total_Cleanings,
            AVG(CASE 
                WHEN ct.Status = 'Completed' THEN 1 
                ELSE 0 
            END) * 100 as Completion_Rate,
            AVG(CASE 
                WHEN i.Inspection_Result = 'Pass' THEN 1 
                ELSE 0 
            END) * 100 as Inspection_Pass_Rate
        FROM Room r
        LEFT JOIN Cleaning_Task ct ON r.RID = ct.RID
        LEFT JOIN Inspection_Logs i ON r.RID = i.RID
        GROUP BY r.RID, r.Type
        ORDER BY Completion_Rate DESC, Inspection_Pass_Rate DESC;

    RETURN v_result;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in get_room_cleaning_efficiency: ' || SQLERRM);
        RETURN NULL;
END get_room_cleaning_efficiency;
/
