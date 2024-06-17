--Constraint3: Status will default to 'Pending' if not provided
ALTER TABLE Cleaning_Task
MODIFY Status DEFAULT 'Pending';
