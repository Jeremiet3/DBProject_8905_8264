-- Query 2: List of Rooms with Maintenance Requests and Cleaning Tasks in the Last 60 Days

SELECT r.RID, r.TYPE, r.OCCUPANCY_STATUS, r.CLEANING_STATUS
FROM room r
JOIN maintenance_request mr ON r.RID = mr.RID
JOIN cleaning_task ct ON r.RID = ct.RID
WHERE mr.DATE_REPORTED >= SYSDATE - 60
AND ct.STATUS = 'Pending'
GROUP BY r.RID, r.TYPE, r.OCCUPANCY_STATUS, r.CLEANING_STATUS
ORDER BY r.RID;
