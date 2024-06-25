CREATE OR REPLACE FUNCTION calculate_staff_performance(p_date IN DATE)
RETURN SYS_REFCURSOR
IS
    v_result SYS_REFCURSOR;
BEGIN
    OPEN v_result FOR
        WITH staff_tasks AS (
            SELECT 
                ct.SID,
                COUNT(*) as Total_Tasks,
                SUM(CASE WHEN ct.Status = 'Completed' THEN 1 ELSE 0 END) as Completed_Tasks,
                AVG(CASE 
                    WHEN i.Inspection_Result = 'Pass' THEN 1 
                    ELSE 0 
                END) as Inspection_Pass_Rate
            FROM Cleaning_Task ct
            LEFT JOIN Inspection_Logs i ON ct.RID = i.RID
            WHERE TRUNC(i.Inspection_Date) = TRUNC(p_date)
            GROUP BY ct.SID
        )
        SELECT 
            sm.SID,
            sm.First_Name || ' ' || sm.Last_Name as Staff_Name,
            NVL(st.Total_Tasks, 0) as Total_Tasks,
            NVL(st.Completed_Tasks, 0) as Completed_Tasks,
            CASE 
                WHEN NVL(st.Total_Tasks, 0) > 0 THEN 
                    ROUND(NVL(st.Completed_Tasks, 0) / NVL(st.Total_Tasks, 0) * 100, 2)
                ELSE 0
            END as Completion_Rate,
            NVL(ROUND(st.Inspection_Pass_Rate * 100, 2), 0) as Inspection_Pass_Rate
        FROM Staff_Member sm
        LEFT JOIN staff_tasks st ON sm.SID = st.SID
        ORDER BY Completion_Rate DESC, Inspection_Pass_Rate DESC;

    RETURN v_result;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in calculate_staff_performance: ' || SQLERRM);
        RETURN NULL;
END calculate_staff_performance;
/
