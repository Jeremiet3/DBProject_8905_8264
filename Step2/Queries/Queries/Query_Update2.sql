-- Update Cleaning Supply Total Quantity Based on Most Recent Usage

UPDATE Cleaning_Supply cs
SET Total_Quantity = Total_Quantity - (
    SELECT COALESCE(SUM(nf.Quantity), 0)
    FROM Need_for nf
    WHERE nf.SUID = cs.SUID
    AND nf.TID = (
        SELECT MAX(nf_inner.TID)
        FROM Need_for nf_inner
        WHERE nf_inner.SUID = nf.SUID
    )
)
WHERE EXISTS (
    SELECT 1
    FROM Need_for nf
    WHERE nf.SUID = cs.SUID
);
