-- Query 1: Find the Total Number of Cleaning Tasks per Staff Member in the Last 30 Days and Order by Number of Tasks

SELECT sm.SID, sm.FIRST_NAME, sm.LAST_NAME, COUNT(ct.TID) AS total_tasks
FROM staff_member sm
JOIN cleaning_task ct ON sm.SID = ct.SID
JOIN (
    SELECT DISTINCT ct2.TID
    FROM cleaning_task ct2
    JOIN maintenance_request mr2 ON ct2.RID = mr2.RID
    WHERE mr2.DATE_REPORTED >= SYSDATE - 30
) recent_tasks ON ct.TID = recent_tasks.TID
GROUP BY sm.SID, sm.FIRST_NAME, sm.LAST_NAME
HAVING COUNT(ct.TID) > 0
ORDER BY total_tasks DESC;
