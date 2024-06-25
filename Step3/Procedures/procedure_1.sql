CREATE OR REPLACE PROCEDURE assign_cleaning_tasks
IS
    CURSOR c_dirty_rooms IS
        SELECT RID, Type
        FROM Room
        WHERE Cleaning_Status = 'Dirty'
        AND Occupancy_Status = 'Vacant'
        FOR UPDATE;

    CURSOR c_available_staff IS
        SELECT SM.SID, SM.First_Name, SM.Last_Name
        FROM Staff_Member SM
        LEFT JOIN (
            SELECT SID, COUNT(*) as Active_Tasks
            FROM Cleaning_Task
            WHERE Status = 'Pending'
            GROUP BY SID
        ) CT ON SM.SID = CT.SID
        WHERE CT.Active_Tasks IS NULL OR CT.Active_Tasks < 3
        ORDER BY CT.Active_Tasks NULLS FIRST;

    TYPE StaffRecord IS RECORD (
        SID Staff_Member.SID%TYPE,
        First_Name Staff_Member.First_Name%TYPE,
        Last_Name Staff_Member.Last_Name%TYPE
    );
    v_staff StaffRecord;
    v_task_id Cleaning_Task.TID%TYPE;
    v_assigned_count INT := 0;
    e_no_staff EXCEPTION;
BEGIN
    OPEN c_available_staff;
    FETCH c_available_staff INTO v_staff;
    IF c_available_staff%NOTFOUND THEN
        RAISE e_no_staff;
    END IF;
    CLOSE c_available_staff;

    FOR room IN c_dirty_rooms LOOP
        -- Generate new task ID
        SELECT NVL(MAX(TID), 0) + 1 INTO v_task_id FROM Cleaning_Task;

        -- Assign task
        INSERT INTO Cleaning_Task (TID, Status, RID, SID)
        VALUES (v_task_id, 'Pending', room.RID, v_staff.SID);

        -- Update room status
        UPDATE Room
        SET Cleaning_Status = 'In Progress'
        WHERE CURRENT OF c_dirty_rooms;

        v_assigned_count := v_assigned_count + 1;
        DBMS_OUTPUT.PUT_LINE('Assigned task ' || v_task_id || ' for room ' || room.RID || ' (' || room.Type || ') to ' || v_staff.First_Name || ' ' || v_staff.Last_Name);

        -- Rotate to next available staff member
        OPEN c_available_staff;
        FETCH c_available_staff INTO v_staff;
        IF c_available_staff%NOTFOUND THEN
            CLOSE c_available_staff;
            EXIT;
        END IF;
        CLOSE c_available_staff;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Assigned ' || v_assigned_count || ' cleaning tasks.');
EXCEPTION
    WHEN e_no_staff THEN
        DBMS_OUTPUT.PUT_LINE('No available staff to assign tasks.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in assign_cleaning_tasks: ' || SQLERRM);
        ROLLBACK;
END assign_cleaning_tasks;
/
