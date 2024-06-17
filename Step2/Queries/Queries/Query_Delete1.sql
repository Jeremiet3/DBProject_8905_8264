-- Delete Inactive Staff Members Not Involved in Cleaning Tasks or Maintenance Requests in the Past Year

DELETE FROM staff_member
WHERE SID NOT IN (
    SELECT DISTINCT SID
    FROM cleaning_task
    WHERE TID IN (
        SELECT TID
        FROM cleaning_task
        WHERE TID IN (
            SELECT TID
            FROM maintenance_request
            WHERE DATE_REPORTED >= SYSDATE - 365
        )
    )
)
AND SID NOT IN (
    SELECT DISTINCT SID
    FROM maintenance_request
    WHERE DATE_REPORTED >= SYSDATE - 365
);
