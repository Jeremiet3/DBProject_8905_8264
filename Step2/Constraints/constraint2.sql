-- Constraint2: Add CHECK constraints to Cleaning_Supply
ALTER TABLE Cleaning_Supply
ADD CONSTRAINT chk_total_quantity CHECK (Total_Quantity >= 0);

