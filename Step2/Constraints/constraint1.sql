-- Constraint1: Add UNIQUE constraint to Staff_Member_Info for Phone_Number
ALTER TABLE Staff_Member_Info
ADD CONSTRAINT uniq_phone_number UNIQUE (Phone_Number);

