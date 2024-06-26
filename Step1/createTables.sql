CREATE TABLE Room
(
  RID INT NOT NULL,
  Type VARCHAR(30) NOT NULL,
  Occupancy_Status VARCHAR(30) NOT NULL,
  Cleaning_Status VARCHAR(30) NOT NULL,
  PRIMARY KEY (RID)
);

CREATE TABLE Staff_Member
(
  SID INT NOT NULL,
  First_Name VARCHAR(30) NOT NULL,
  Last_Name_ VARCHAR(30) NOT NULL,
  PRIMARY KEY (SID)
);

CREATE TABLE Cleaning_Supply
(
  SUID INT NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Total_Quantity INT NOT NULL,
  Location VARCHAR(30) NOT NULL,
  PRIMARY KEY (SUID)
);

CREATE TABLE Cleaning_Task
(
  TID INT NOT NULL,
  Status VARCHAR(30) NOT NULL,
  RID INT NOT NULL,
  SID INT NOT NULL,
  PRIMARY KEY (TID, RID, SID),
  FOREIGN KEY (RID) REFERENCES Room(RID),
  FOREIGN KEY (SID) REFERENCES Staff_Member(SID)
);

CREATE TABLE Maintenance_Request
(
  MID INT NOT NULL,
  Issue_Description VARCHAR(30) NOT NULL,
  Date_Reported DATE NOT NULL,
  RID INT NOT NULL,
  SID INT NOT NULL,
  PRIMARY KEY (MID, RID, SID),
  FOREIGN KEY (RID) REFERENCES Room(RID),
  FOREIGN KEY (SID) REFERENCES Staff_Member(SID)
);

CREATE TABLE Inspection_Logs
(
  LID INT NOT NULL,
  Inspection_Date DATE NOT NULL,
  Inspection_Result VARCHAR(30) NOT NULL,
  RID INT NOT NULL,
  PRIMARY KEY (LID),
  FOREIGN KEY (RID) REFERENCES Room(RID)
);

CREATE TABLE Need_for
(
  SUID INT NOT NULL,
  Quantity INT NOT NULL,
  TID INT NOT NULL,
  RID INT NOT NULL,
  SID INT NOT NULL,
  PRIMARY KEY (SUID, TID, RID, SID),
  FOREIGN KEY (SUID) REFERENCES Cleaning_Supply(SUID),
  FOREIGN KEY (TID, RID, SID) REFERENCES Cleaning_Task(TID, RID, SID)
);

CREATE TABLE Staff_Member_Info
(
  SID INT NOT NULL,
  Phone_Number VARCHAR(30) NOT NULL,
  PRIMARY KEY (SID),
  FOREIGN KEY (SID) REFERENCES Staff_Member(SID)
);
