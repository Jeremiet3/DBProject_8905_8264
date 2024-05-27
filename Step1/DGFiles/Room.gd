
[General]
Version=1

[Preferences]
Username=
Password=2587
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=ROOM
Count=390

[Record]
Name=RID
Type=NUMBER
Size=
Data=Sequence(11, [1])
Master=

[Record]
Name=TYPE
Type=VARCHAR2
Size=30
Data=List('Single', 'Double', 'Suite')
Master=

[Record]
Name=OCCUPANCY_STATUS
Type=VARCHAR2
Size=30
Data=List('Occupied', 'Vacant')
Master=

[Record]
Name=CLEANING_STATUS
Type=VARCHAR2
Size=30
Data=List('Clean', 'Dirty')
Master=

