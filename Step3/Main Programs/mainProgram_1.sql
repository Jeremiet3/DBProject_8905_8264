DECLARE
    v_efficiency_cursor SYS_REFCURSOR;
    TYPE EfficiencyRecord IS RECORD (
        RID Room.RID%TYPE,
        Type Room.Type%TYPE,
        Total_Cleanings INT,
        Completion_Rate FLOAT,
        Inspection_Pass_Rate FLOAT
    );
    v_efficiency EfficiencyRecord;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Room Cleaning Management');
    DBMS_OUTPUT.PUT_LINE('-------------------------');

    -- Get room cleaning efficiency
    v_efficiency_cursor := get_room_cleaning_efficiency;
    DBMS_OUTPUT.PUT_LINE('Room Cleaning Efficiency:');
    DBMS_OUTPUT.PUT_LINE('RID | Type | Total Cleanings | Completion Rate | Inspection Pass Rate');
    LOOP
        FETCH v_efficiency_cursor INTO v_efficiency;
        EXIT WHEN v_efficiency_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            v_efficiency.RID || ' | ' || 
            v_efficiency.Type || ' | ' || 
            v_efficiency.Total_Cleanings || ' | ' || 
            ROUND(v_efficiency.Completion_Rate, 2) || '% | ' || 
            ROUND(v_efficiency.Inspection_Pass_Rate, 2) || '%'
        );
    END LOOP;
    CLOSE v_efficiency_cursor;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Assigning Cleaning Tasks...');
    assign_cleaning_tasks;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Room Cleaning Management Completed.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in room_cleaning_management: ' || SQLERRM);
END;
/
