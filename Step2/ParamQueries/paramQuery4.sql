--Query4: Inspection Logs Results within a Date Range

SELECT
    il.LID,
    r.RID,
    r.Type,
    il.Inspection_Date,
    il.Inspection_Result
FROM
    Inspection_Logs il
JOIN
    Room r ON il.RID = r.RID
WHERE
    il.Inspection_Date BETWEEN TO_DATE(&<name="Start Date" hint="Enter the start date in format YYYY-MM-DD" type="string">, 'YYYY-MM-DD')
    AND TO_DATE(&<name="End Date" hint="Enter the end date in format YYYY-MM-DD" type="string">, 'YYYY-MM-DD')
    AND il.Inspection_Result = '&<name="Inspection Result" list="select DISTINCT Inspection_Result from Inspection_Logs order by Inspection_Result">'
ORDER BY 
    il.Inspection_Date DESC;
