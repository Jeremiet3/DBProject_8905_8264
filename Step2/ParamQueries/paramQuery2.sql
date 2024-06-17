--Query2: Total Quantity of Cleaning Supplies by Location

SELECT 
    cs.Location, 
    SUM(cs.Total_Quantity) AS TotalQuantity
FROM 
    Cleaning_Supply cs
GROUP BY 
    cs.Location
HAVING 
    SUM(cs.Total_Quantity) >= &<name="Minimum Quantity" type="integer">
ORDER BY 
    TotalQuantity DESC;
