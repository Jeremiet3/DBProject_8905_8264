-- Delete Cleaning Supplies with Quantity Below Average Usage

DELETE FROM Cleaning_Supply
WHERE SUID IN (
    SELECT SUID
    FROM (
        SELECT SUID, Total_Quantity
        FROM (
            SELECT SUID, SUM(Quantity) AS Total_Quantity
            FROM Need_for
            GROUP BY SUID
        ) Supply_Quantities
        WHERE Total_Quantity < (
            SELECT AVG(Total_Quantity)
            FROM (
                SELECT SUM(Quantity) AS Total_Quantity
                FROM Need_for
                GROUP BY SUID
            ) Avg_Supply_Quantities
        )
    ) Supplies_Less_Than_Average
);
