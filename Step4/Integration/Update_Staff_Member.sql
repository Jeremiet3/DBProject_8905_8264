ALTER TABLE Staff_Member
ADD StartDate DATE;

DECLARE
  v_sid Staff_Member.SID%TYPE;
  v_start_date DATE;
BEGIN
  FOR r IN (SELECT SID FROM Staff_Member) LOOP
    -- create a random date between january 2020 and january 2023
    v_start_date := TO_DATE('2020-01-01', 'YYYY-MM-DD') + ROUND(DBMS_RANDOM.VALUE(0, 1095)); -- 1095 for 3 years 
    v_sid := r.SID;

    -- Update StartDate
    UPDATE Staff_Member
    SET StartDate = v_start_date
    WHERE SID = v_sid;
  END LOOP;

  COMMIT;
END;
/
