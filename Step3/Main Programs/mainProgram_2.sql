DECLARE
    v_performance_cursor SYS_REFCURSOR;
    TYPE PerformanceRecord IS RECORD (
        SID Staff_Member.SID%TYPE,
        Staff_Name VARCHAR2(61),
        Total_Tasks INT,
        Completed_Tasks INT,
        Completion_Rate FLOAT,
        Inspection_Pass_Rate FLOAT
    );
    v_performance PerformanceRecord;
    v_review_date DATE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Staff Performance and Supply Management');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');

    -- Get user input for review date
    v_review_date := TO_DATE('&review_date', 'YYYY-MM-DD');

    -- Calculate staff performance
    v_performance_cursor := calculate_staff_performance(v_review_date);
    DBMS_OUTPUT.PUT_LINE('Staff Performance for ' || TO_CHAR(v_review_date, 'YYYY-MM-DD') || ':');
    DBMS_OUTPUT.PUT_LINE('SID | Name | Total Tasks | Completed Tasks | Completion Rate | Inspection Pass Rate');
    LOOP
        FETCH v_performance_cursor INTO v_performance;
        EXIT WHEN v_performance_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            v_performance.SID || ' | ' || 
            v_performance.Staff_Name || ' | ' || 
            v_performance.Total_Tasks || ' | ' || 
            v_performance.Completed_Tasks || ' | ' || 
            ROUND(v_performance.Completion_Rate, 2) || '% | ' || 
            ROUND(v_performance.Inspection_Pass_Rate, 2) || '%'
        );
    END LOOP;
    CLOSE v_performance_cursor;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Updating Cleaning Supplies...');
    update_cleaning_supplies;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Staff Performance and Supply Management Completed.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in staff_performance_and_supply_management: ' || SQLERRM);
END;
/
