-- Insert data into Room
INSERT INTO Room VALUES (1, 'Single', 'Occupied', 'Clean');
INSERT INTO Room VALUES (2, 'Double', 'Vacant', 'Dirty');
INSERT INTO Room VALUES (3, 'Suite', 'Occupied', 'Clean');
INSERT INTO Room VALUES (4, 'Single', 'Vacant', 'Clean');
INSERT INTO Room VALUES (5, 'Double', 'Occupied', 'Dirty');
INSERT INTO Room VALUES (6, 'Suite', 'Vacant', 'Clean');
INSERT INTO Room VALUES (7, 'Single', 'Occupied', 'Dirty');
INSERT INTO Room VALUES (8, 'Double', 'Vacant', 'Clean');
INSERT INTO Room VALUES (9, 'Suite', 'Occupied', 'Dirty');
INSERT INTO Room VALUES (10, 'Single', 'Vacant', 'Clean');

-- Insert data into Staff_Member
INSERT INTO Staff_Member VALUES (1, 'John', 'Doe');
INSERT INTO Staff_Member VALUES (2, 'Jane', 'Smith');
INSERT INTO Staff_Member VALUES (3, 'Alice', 'Johnson');
INSERT INTO Staff_Member VALUES (4, 'Bob', 'Williams');
INSERT INTO Staff_Member VALUES (5, 'Charlie', 'Brown');
INSERT INTO Staff_Member VALUES (6, 'David', 'Jones');
INSERT INTO Staff_Member VALUES (7, 'Emma', 'Garcia');
INSERT INTO Staff_Member VALUES (8, 'Frank', 'Martinez');
INSERT INTO Staff_Member VALUES (9, 'Grace', 'Rodriguez');
INSERT INTO Staff_Member VALUES (10, 'Hank', 'Lopez');

-- Insert data into Cleaning_Supply
INSERT INTO Cleaning_Supply VALUES (1, 'Detergent', 100, 'Storage A');
INSERT INTO Cleaning_Supply VALUES (2, 'Bleach', 50, 'Storage B');
INSERT INTO Cleaning_Supply VALUES (3, 'Mop', 30, 'Storage A');
INSERT INTO Cleaning_Supply VALUES (4, 'Broom', 20, 'Storage C');
INSERT INTO Cleaning_Supply VALUES (5, 'Vacuum', 15, 'Storage B');
INSERT INTO Cleaning_Supply VALUES (6, 'Trash Bags', 200, 'Storage A');
INSERT INTO Cleaning_Supply VALUES (7, 'Glass Cleaner', 40, 'Storage C');
INSERT INTO Cleaning_Supply VALUES (8, 'Air Freshener', 60, 'Storage B');
INSERT INTO Cleaning_Supply VALUES (9, 'Disinfectant', 70, 'Storage A');
INSERT INTO Cleaning_Supply VALUES (10, 'Floor Polish', 25, 'Storage C');

-- Insert data into Cleaning_Task
INSERT INTO Cleaning_Task VALUES (1, 'Completed', 1, 1);
INSERT INTO Cleaning_Task VALUES (2, 'Pending', 2, 2);
INSERT INTO Cleaning_Task VALUES (3, 'Completed', 3, 3);
INSERT INTO Cleaning_Task VALUES (4, 'Pending', 4, 4);
INSERT INTO Cleaning_Task VALUES (5, 'Completed', 5, 5);
INSERT INTO Cleaning_Task VALUES (6, 'Pending', 6, 6);
INSERT INTO Cleaning_Task VALUES (7, 'Completed', 7, 7);
INSERT INTO Cleaning_Task VALUES (8, 'Pending', 8, 8);
INSERT INTO Cleaning_Task VALUES (9, 'Completed', 9, 9);
INSERT INTO Cleaning_Task VALUES (10, 'Pending', 10, 10);

-- Insert data into Maintenance_Request
INSERT INTO Maintenance_Request VALUES (1, 'Leaky faucet', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 1, 1);
INSERT INTO Maintenance_Request VALUES (2, 'Broken window', TO_DATE('2024-05-02', 'YYYY-MM-DD'), 2, 2);
INSERT INTO Maintenance_Request VALUES (3, 'AC not working', TO_DATE('2024-05-03', 'YYYY-MM-DD'), 3, 3);
INSERT INTO Maintenance_Request VALUES (4, 'Heater issue', TO_DATE('2024-05-04', 'YYYY-MM-DD'), 4, 4);
INSERT INTO Maintenance_Request VALUES (5, 'Clogged drain', TO_DATE('2024-05-05', 'YYYY-MM-DD'), 5, 5);
INSERT INTO Maintenance_Request VALUES (6, 'Electrical problem', TO_DATE('2024-05-06', 'YYYY-MM-DD'), 6, 6);
INSERT INTO Maintenance_Request VALUES (7, 'Broken door lock', TO_DATE('2024-05-07', 'YYYY-MM-DD'), 7, 7);
INSERT INTO Maintenance_Request VALUES (8, 'Leaky roof', TO_DATE('2024-05-08', 'YYYY-MM-DD'), 8, 8);
INSERT INTO Maintenance_Request VALUES (9, 'Faulty wiring', TO_DATE('2024-05-09', 'YYYY-MM-DD'), 9, 9);
INSERT INTO Maintenance_Request VALUES (10, 'Plumbing issue', TO_DATE('2024-05-10', 'YYYY-MM-DD'), 10, 10);

-- Insert data into Inspection_Logs
INSERT INTO Inspection_Logs VALUES (1, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Pass', 1);
INSERT INTO Inspection_Logs VALUES (2, TO_DATE('2024-05-02', 'YYYY-MM-DD'), 'Fail', 2);
INSERT INTO Inspection_Logs VALUES (3, TO_DATE('2024-05-03', 'YYYY-MM-DD'), 'Pass', 3);
INSERT INTO Inspection_Logs VALUES (4, TO_DATE('2024-05-04', 'YYYY-MM-DD'), 'Pass', 4);
INSERT INTO Inspection_Logs VALUES (5, TO_DATE('2024-05-05', 'YYYY-MM-DD'), 'Fail', 5);
INSERT INTO Inspection_Logs VALUES (6, TO_DATE('2024-05-06', 'YYYY-MM-DD'), 'Pass', 6);
INSERT INTO Inspection_Logs VALUES (7, TO_DATE('2024-05-07', 'YYYY-MM-DD'), 'Pass', 7);
INSERT INTO Inspection_Logs VALUES (8, TO_DATE('2024-05-08', 'YYYY-MM-DD'), 'Fail', 8);
INSERT INTO Inspection_Logs VALUES (9, TO_DATE('2024-05-09', 'YYYY-MM-DD'), 'Pass', 9);
INSERT INTO Inspection_Logs VALUES (10, TO_DATE('2024-05-10', 'YYYY-MM-DD'), 'Pass', 10);

-- Insert data into Need_for
INSERT INTO Need_for VALUES (1, 10, 1, 1, 1);
INSERT INTO Need_for VALUES (2, 5, 2, 2, 2);
INSERT INTO Need_for VALUES (3, 3, 3, 3, 3);
INSERT INTO Need_for VALUES (4, 2, 4, 4, 4);
INSERT INTO Need_for VALUES (5, 1, 5, 5, 5);
INSERT INTO Need_for VALUES (6, 20, 6, 6, 6);
INSERT INTO Need_for VALUES (7, 4, 7, 7, 7);
INSERT INTO Need_for VALUES (8, 6, 8, 8, 8);
INSERT INTO Need_for VALUES (9, 7, 9, 9, 9);
INSERT INTO Need_for VALUES (10, 2, 10, 10, 10);

-- Insert data into Staff_Member_Info
INSERT INTO Staff_Member_Info VALUES (1, '972-5356-7890');
INSERT INTO Staff_Member_Info VALUES (2, '972-5267-8901');
INSERT INTO Staff_Member_Info VALUES (3, '972-5478-9012');
INSERT INTO Staff_Member_Info VALUES (4, '972-5389-0123');
INSERT INTO Staff_Member_Info VALUES (5, '972-5260-1234');
INSERT INTO Staff_Member_Info VALUES (6, '972-5221-2345');
INSERT INTO Staff_Member_Info VALUES (7, '972-5212-3456');
INSERT INTO Staff_Member_Info VALUES (8, '972-5303-4567');
INSERT INTO Staff_Member_Info VALUES (9, '972-5874-5678');
INSERT INTO Staff_Member_Info VALUES (10, '972-5485-6789');

commit;
