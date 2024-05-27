
[General]
Version=1

[Preferences]
Username=
Password=2004
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=SYSTEM
Name=CLEANING_SUPPLY
Count=390

[Record]
Name=SUID
Type=NUMBER
Size=
Data=Sequence(11, [1])
Master=

[Record]
Name=NAME
Type=VARCHAR2
Size=30
Data=List('Detergent', 'Bleach', 'Mop', 'Broom', 'Vacuum', 'Trash Bags', 'Glass Cleaner', 'Air Freshener', 'Disinfectant', 'Floor Polish', 'Sponges', 'Scrub Brushes', 'Rubber Gloves', 'Dish Soap', 'All-Purpose Cleaner', 'Toilet Bowl Cleaner', 'Paper Towels', 'Microfiber Cloths', 'Window Squeegee', 'Carpet Cleaner', 'Stainless Steel Cleaner', 'Wood Polish', 'Grout Cleaner', 'Laundry Detergent', 'Fabric Softener', 'Lint Roller', 'Dryer Sheets', 'Oven Cleaner', 'Stove Degreaser', 'Baking Soda', 'White Vinegar', 'Lemon Juice', 'Essential Oils', 'Hand Sanitizer', 'Bathroom Deodorizer', 'Shoe Deodorizer')
Master=

[Record]
Name=TOTAL_QUANTITY
Type=NUMBER
Size=
Data=Random(10, 500)
Master=

[Record]
Name=LOCATION
Type=VARCHAR2
Size=30
Data=List('Storage A', 'Storage B', 'Storage C')
Master=

