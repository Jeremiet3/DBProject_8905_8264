-- Drop the tables in the correct order to handle dependencies properly

DROP TABLE Need_for CASCADE CONSTRAINTS;

DROP TABLE Staff_Member_Info CASCADE CONSTRAINTS;

DROP TABLE Inspection_Logs CASCADE CONSTRAINTS;

DROP TABLE Maintenance_Request CASCADE CONSTRAINTS;

DROP TABLE Cleaning_Task CASCADE CONSTRAINTS;

DROP TABLE Staff_Member;

DROP TABLE Cleaning_Supply;

DROP TABLE Room;


