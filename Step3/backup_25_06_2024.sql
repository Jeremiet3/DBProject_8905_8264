prompt PL/SQL Developer Export Tables for user C##JEREM@XE
prompt Created by Admin on Tuesday, June 25, 2024
set feedback off
set define off

prompt Creating CLEANING_SUPPLY...
create table CLEANING_SUPPLY
(
  suid           INTEGER not null,
  name           VARCHAR2(30) not null,
  total_quantity INTEGER not null,
  location       VARCHAR2(30) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLEANING_SUPPLY
  add primary key (SUID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLEANING_SUPPLY
  add constraint CHK_TOTAL_QUANTITY
  check (Total_Quantity >= 0);

prompt Creating ROOM...
create table ROOM
(
  rid              INTEGER not null,
  type             VARCHAR2(30) not null,
  occupancy_status VARCHAR2(30) not null,
  cleaning_status  VARCHAR2(30) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ROOM
  add primary key (RID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating STAFF_MEMBER...
create table STAFF_MEMBER
(
  sid        INTEGER not null,
  first_name VARCHAR2(30) not null,
  last_name  VARCHAR2(30) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STAFF_MEMBER
  add primary key (SID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating CLEANING_TASK...
create table CLEANING_TASK
(
  tid    INTEGER not null,
  status VARCHAR2(30) default 'Pending' not null,
  rid    INTEGER not null,
  sid    INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLEANING_TASK
  add primary key (TID, RID, SID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table CLEANING_TASK
  add foreign key (RID)
  references ROOM (RID) on delete cascade;
alter table CLEANING_TASK
  add foreign key (SID)
  references STAFF_MEMBER (SID) on delete cascade;

prompt Creating INSPECTION_LOGS...
create table INSPECTION_LOGS
(
  lid               INTEGER not null,
  inspection_date   DATE not null,
  inspection_result VARCHAR2(30) not null,
  rid               INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INSPECTION_LOGS
  add primary key (LID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table INSPECTION_LOGS
  add foreign key (RID)
  references ROOM (RID) on delete cascade;

prompt Creating MAINTENANCE_REQUEST...
create table MAINTENANCE_REQUEST
(
  mid               INTEGER not null,
  issue_description VARCHAR2(30) not null,
  date_reported     DATE not null,
  rid               INTEGER not null,
  sid               INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MAINTENANCE_REQUEST
  add primary key (MID, RID, SID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table MAINTENANCE_REQUEST
  add foreign key (RID)
  references ROOM (RID) on delete cascade;
alter table MAINTENANCE_REQUEST
  add foreign key (SID)
  references STAFF_MEMBER (SID) on delete cascade;

prompt Creating NEED_FOR...
create table NEED_FOR
(
  suid     INTEGER not null,
  quantity INTEGER not null,
  tid      INTEGER not null,
  rid      INTEGER not null,
  sid      INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table NEED_FOR
  add primary key (SUID, TID, RID, SID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table NEED_FOR
  add foreign key (SUID)
  references CLEANING_SUPPLY (SUID) on delete cascade;
alter table NEED_FOR
  add foreign key (TID, RID, SID)
  references CLEANING_TASK (TID, RID, SID) on delete cascade;

prompt Creating STAFF_MEMBER_INFO...
create table STAFF_MEMBER_INFO
(
  sid          INTEGER not null,
  phone_number VARCHAR2(30) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STAFF_MEMBER_INFO
  add primary key (SID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STAFF_MEMBER_INFO
  add constraint UNIQ_PHONE_NUMBER unique (PHONE_NUMBER)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table STAFF_MEMBER_INFO
  add foreign key (SID)
  references STAFF_MEMBER (SID) on delete cascade;

prompt Disabling triggers for CLEANING_SUPPLY...
alter table CLEANING_SUPPLY disable all triggers;
prompt Disabling triggers for ROOM...
alter table ROOM disable all triggers;
prompt Disabling triggers for STAFF_MEMBER...
alter table STAFF_MEMBER disable all triggers;
prompt Disabling triggers for CLEANING_TASK...
alter table CLEANING_TASK disable all triggers;
prompt Disabling triggers for INSPECTION_LOGS...
alter table INSPECTION_LOGS disable all triggers;
prompt Disabling triggers for MAINTENANCE_REQUEST...
alter table MAINTENANCE_REQUEST disable all triggers;
prompt Disabling triggers for NEED_FOR...
alter table NEED_FOR disable all triggers;
prompt Disabling triggers for STAFF_MEMBER_INFO...
alter table STAFF_MEMBER_INFO disable all triggers;
prompt Disabling foreign key constraints for CLEANING_TASK...
alter table CLEANING_TASK disable constraint SYS_C009187;
alter table CLEANING_TASK disable constraint SYS_C009188;
prompt Disabling foreign key constraints for INSPECTION_LOGS...
alter table INSPECTION_LOGS disable constraint SYS_C009202;
prompt Disabling foreign key constraints for MAINTENANCE_REQUEST...
alter table MAINTENANCE_REQUEST disable constraint SYS_C009195;
alter table MAINTENANCE_REQUEST disable constraint SYS_C009196;
prompt Disabling foreign key constraints for NEED_FOR...
alter table NEED_FOR disable constraint SYS_C009209;
alter table NEED_FOR disable constraint SYS_C009210;
prompt Disabling foreign key constraints for STAFF_MEMBER_INFO...
alter table STAFF_MEMBER_INFO disable constraint SYS_C009214;
prompt Deleting STAFF_MEMBER_INFO...
delete from STAFF_MEMBER_INFO;
commit;
prompt Deleting NEED_FOR...
delete from NEED_FOR;
commit;
prompt Deleting MAINTENANCE_REQUEST...
delete from MAINTENANCE_REQUEST;
commit;
prompt Deleting INSPECTION_LOGS...
delete from INSPECTION_LOGS;
commit;
prompt Deleting CLEANING_TASK...
delete from CLEANING_TASK;
commit;
prompt Deleting STAFF_MEMBER...
delete from STAFF_MEMBER;
commit;
prompt Deleting ROOM...
delete from ROOM;
commit;
prompt Deleting CLEANING_SUPPLY...
delete from CLEANING_SUPPLY;
commit;
prompt Loading CLEANING_SUPPLY...
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (6, 'Trash Bags', 160, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (17, 'Floor Polish', 130, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (19, 'Broom', 235, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (20, 'White Vinegar', 195, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (25, 'Wood Polish', 91, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (28, 'Oven Cleaner', 172, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (33, 'Mop', 213, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (34, 'Detergent', 285, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (35, 'Stove Degreaser', 340, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (40, 'Carpet Cleaner', 320, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (49, 'Toilet Bowl Cleaner', 43, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (51, 'Fabric Softener', 446, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (54, 'Shoe Deodorizer', 404, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (61, 'Bathroom Deodorizer', 336, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (64, 'Carpet Cleaner', 83, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (69, 'Stove Degreaser', 278, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (70, 'Disinfectant', 345, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (74, 'Fabric Softener', 339, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (76, 'Essential Oils', 101, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (78, 'Rubber Gloves', 341, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (81, 'White Vinegar', 203, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (85, 'Paper Towels', 359, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (90, 'Shoe Deodorizer', 307, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (95, 'Baking Soda', 276, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (100, 'Broom', 313, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (101, 'Oven Cleaner', 43, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (102, 'Shoe Deodorizer', 212, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (103, 'Oven Cleaner', 463, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (106, 'Microfiber Cloths', 224, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (108, 'Bathroom Deodorizer', 372, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (109, 'Paper Towels', 184, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (115, 'Mop', 85, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (117, 'Hand Sanitizer', 231, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (123, 'Floor Polish', 215, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (127, 'Microfiber Cloths', 409, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (142, 'Dryer Sheets', 210, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (143, 'Baking Soda', 359, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (148, 'Stainless Steel Cleaner', 240, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (154, 'Bleach', 409, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (155, 'Essential Oils', 121, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (165, 'Shoe Deodorizer', 246, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (166, 'Dryer Sheets', 168, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (171, 'Vacuum', 164, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (174, 'Lemon Juice', 420, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (179, 'Window Squeegee', 334, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (185, 'Stainless Steel Cleaner', 175, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (187, 'Microfiber Cloths', 304, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (189, 'Essential Oils', 165, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (192, 'Window Squeegee', 121, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (193, 'White Vinegar', 175, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (195, 'Detergent', 353, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (198, 'Trash Bags', 400, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (199, 'Toilet Bowl Cleaner', 272, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (201, 'Essential Oils', 80, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (205, 'Mop', 174, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (208, 'Rubber Gloves', 110, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (212, 'Floor Polish', 231, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (213, 'Trash Bags', 47, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (218, 'Trash Bags', 149, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (222, 'Stove Degreaser', 192, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (227, 'Stove Degreaser', 87, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (230, 'Shoe Deodorizer', 29, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (231, 'Sponges', 343, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (237, 'Window Squeegee', 129, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (251, 'Hand Sanitizer', 30, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (253, 'Grout Cleaner', 260, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (255, 'Floor Polish', 89, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (269, 'Stainless Steel Cleaner', 31, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (274, 'Vacuum', 28, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (282, 'Detergent', 300, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (283, 'Stainless Steel Cleaner', 81, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (287, 'Stove Degreaser', 107, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (291, 'Floor Polish', 83, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (296, 'Grout Cleaner', 383, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (297, 'Carpet Cleaner', 254, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (301, 'Lint Roller', 119, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (305, 'Oven Cleaner', 319, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (320, 'Laundry Detergent', 149, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (321, 'Floor Polish', 145, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (323, 'Window Squeegee', 313, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (325, 'White Vinegar', 47, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (329, 'Bleach', 402, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (331, 'Carpet Cleaner', 83, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (332, 'Carpet Cleaner', 177, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (337, 'Toilet Bowl Cleaner', 388, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (342, 'Dish Soap', 360, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (343, 'Stove Degreaser', 348, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (350, 'Rubber Gloves', 456, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (352, 'Wood Polish', 334, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (360, 'Glass Cleaner', 281, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (361, 'Microfiber Cloths', 27, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (367, 'Vacuum', 330, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (371, 'Trash Bags', 205, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (375, 'Microfiber Cloths', 309, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (386, 'Hand Sanitizer', 327, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (393, 'Shoe Deodorizer', 450, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (397, 'Hand Sanitizer', 37, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (400, 'Bathroom Deodorizer', 325, 'Storage B');
commit;
prompt 98 records loaded
prompt Loading ROOM...
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (1, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (2, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (3, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (4, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (5, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (6, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (7, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (8, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (9, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (10, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (11, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (12, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (13, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (14, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (15, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (16, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (17, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (18, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (19, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (20, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (21, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (22, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (23, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (24, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (25, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (26, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (27, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (28, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (29, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (30, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (31, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (32, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (33, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (34, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (35, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (36, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (37, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (38, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (39, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (40, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (41, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (42, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (43, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (44, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (45, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (46, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (47, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (48, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (49, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (50, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (51, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (52, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (53, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (54, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (55, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (56, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (57, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (58, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (59, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (60, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (61, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (62, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (63, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (64, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (65, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (66, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (67, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (68, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (69, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (70, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (71, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (72, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (73, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (74, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (75, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (76, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (77, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (78, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (79, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (80, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (81, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (82, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (83, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (84, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (85, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (86, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (87, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (88, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (89, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (90, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (91, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (92, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (93, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (94, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (95, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (96, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (97, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (98, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (99, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (100, 'Suite', 'Occupied', 'Dirty');
commit;
prompt 100 records committed...
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (101, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (102, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (103, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (104, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (105, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (106, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (107, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (108, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (109, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (110, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (111, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (112, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (113, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (114, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (115, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (116, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (117, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (118, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (119, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (120, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (121, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (122, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (123, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (124, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (125, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (126, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (127, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (128, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (129, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (130, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (131, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (132, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (133, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (134, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (135, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (136, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (137, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (138, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (139, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (140, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (141, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (142, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (143, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (144, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (145, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (146, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (147, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (148, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (149, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (150, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (151, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (152, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (153, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (154, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (155, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (156, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (157, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (158, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (159, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (160, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (161, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (162, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (163, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (164, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (165, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (166, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (167, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (168, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (169, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (170, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (171, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (172, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (173, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (174, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (175, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (176, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (177, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (178, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (179, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (180, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (181, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (182, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (183, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (184, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (185, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (186, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (187, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (188, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (189, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (190, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (191, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (192, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (193, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (194, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (195, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (196, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (197, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (198, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (199, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (200, 'Suite', 'Occupied', 'Dirty');
commit;
prompt 200 records committed...
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (201, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (202, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (203, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (204, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (205, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (206, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (207, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (208, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (209, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (210, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (211, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (212, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (213, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (214, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (215, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (216, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (217, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (218, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (219, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (220, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (221, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (222, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (223, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (224, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (225, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (226, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (227, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (228, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (229, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (230, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (231, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (232, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (233, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (234, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (235, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (236, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (237, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (238, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (239, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (240, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (241, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (242, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (243, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (244, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (245, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (246, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (247, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (248, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (249, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (250, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (251, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (252, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (253, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (254, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (255, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (256, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (257, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (258, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (259, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (260, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (261, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (262, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (263, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (264, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (265, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (266, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (267, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (268, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (269, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (270, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (271, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (272, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (273, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (274, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (275, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (276, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (277, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (278, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (279, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (280, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (281, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (282, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (283, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (284, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (285, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (286, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (287, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (288, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (289, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (290, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (291, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (292, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (293, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (294, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (295, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (296, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (297, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (298, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (299, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (300, 'Suite', 'Occupied', 'Dirty');
commit;
prompt 300 records committed...
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (301, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (302, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (303, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (304, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (305, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (306, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (307, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (308, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (309, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (310, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (311, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (312, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (313, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (314, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (315, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (316, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (317, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (318, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (319, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (320, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (321, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (322, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (323, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (324, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (325, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (326, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (327, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (328, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (329, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (330, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (331, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (332, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (333, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (334, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (335, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (336, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (337, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (338, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (339, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (340, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (341, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (342, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (343, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (344, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (345, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (346, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (347, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (348, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (349, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (350, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (351, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (352, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (353, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (354, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (355, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (356, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (357, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (358, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (359, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (360, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (361, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (362, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (363, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (364, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (365, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (366, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (367, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (368, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (369, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (370, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (371, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (372, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (373, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (374, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (375, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (376, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (377, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (378, 'Single', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (379, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (380, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (381, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (382, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (383, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (384, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (385, 'Double', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (386, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (387, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (388, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (389, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (390, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (391, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (392, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (393, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (394, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (395, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (396, 'Suite', 'Vacant', 'In Progress');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (397, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (398, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (399, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (400, 'Suite', 'Occupied', 'Clean');
commit;
prompt 400 records committed...
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (402, 'Single', 'Vacant', 'Clean');
commit;
prompt 401 records loaded
prompt Loading STAFF_MEMBER...
insert into STAFF_MEMBER (sid, first_name, last_name)
values (1, 'John', 'Doe');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (2, 'Jane', 'Smith');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (3, 'Alice', 'Johnson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (4, 'Bob', 'Williams');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (5, 'Charlie', 'Brown');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (6, 'David', 'Jones');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (7, 'Emma', 'Garcia');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (8, 'Frank', 'Martinez');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (9, 'Grace', 'Rodriguez');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (10, 'Hank', 'Lopez');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (11, 'Jodie', 'Colton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (12, 'Madeleine', 'Barry');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (13, 'Woody', 'Cassel');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (14, 'Pat', 'Starr');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (15, 'Lonnie', 'Downie');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (16, 'Jet', 'Chappelle');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (17, 'Larry', 'Imbruglia');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (18, 'Loren', 'Macht');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (19, 'Amy', 'Orton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (20, 'Stockard', 'McCann');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (21, 'Frances', 'Mathis');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (23, 'Kevn', 'Howard');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (24, 'Ahmad', 'Mortensen');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (25, 'Demi', 'Blackmore');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (26, 'Roger', 'Dickinson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (27, 'Frank', 'Lizzy');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (28, 'Garry', 'Payne');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (29, 'Tyrone', 'Deschanel');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (30, 'Victoria', 'Bale');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (32, 'Alan', 'Buckingham');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (33, 'Sandra', 'Holeman');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (34, 'Andrea', 'Fender');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (35, 'Natacha', 'Mirren');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (36, 'Rosco', 'Arquette');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (37, 'Jared', 'Serbedzija');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (38, 'Rene', 'Fiennes');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (39, 'Sal', 'Herndon');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (40, 'Tea', 'Gertner');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (41, 'Veruca', 'Torres');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (42, 'Roberta', 'Gary');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (43, 'Elvis', 'Hobson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (44, 'Ice', 'Penn');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (45, 'Keith', 'Guest');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (46, 'Emmylou', 'Imbruglia');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (47, 'Sissy', 'Emmett');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (49, 'Debra', 'Mattea');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (50, 'Lesley', 'Duschel');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (51, 'Maceo', 'Johansson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (52, 'Goldie', 'Crouch');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (53, 'Trace', 'Posener');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (54, 'Kelly', 'Wine');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (55, 'Armand', 'Sandoval');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (56, 'Rebeka', 'Crouse');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (57, 'Carl', 'Horton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (58, 'Praga', 'Davidson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (59, 'Elvis', 'Rizzo');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (60, 'Jean', 'Guest');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (61, 'Boyd', 'Wagner');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (63, 'Timothy', 'Channing');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (64, 'Robby', 'Dalley');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (65, 'Lynn', 'Van Damme');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (66, 'Brendan', 'Kinski');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (67, 'Nora', 'Frampton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (68, 'Anna', 'Fender');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (69, 'Miranda', 'Richter');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (70, 'Dabney', 'Reeve');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (71, 'Collin', 'Clayton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (72, 'Debby', 'Newman');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (73, 'Rip', 'Ifans');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (74, 'Ned', 'Hopkins');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (75, 'Rip', 'Humphrey');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (76, 'Jesse', 'English');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (77, 'Jane', 'Alston');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (78, 'Cornell', 'Davies');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (79, 'Gavin', 'Robards');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (80, 'Radney', 'Reiner');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (84, 'Tcheky', 'Rivers');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (85, 'Raul', 'Biehn');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (86, 'Gilberto', 'Jones');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (87, 'Grace', 'Hoskins');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (88, 'Robbie', 'Tankard');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (89, 'Thin', 'Union');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (90, 'Giovanni', 'Wine');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (91, 'Temuera', 'Caine');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (92, 'Tony', 'Edmunds');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (93, 'Liev', 'Elizondo');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (97, 'Collective', 'Weiss');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (100, 'Jane', 'Gayle');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (102, 'Meg', 'Wheel');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (103, 'Praga', 'Union');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (104, 'Antonio', 'Tisdale');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (106, 'Chet', 'Janney');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (107, 'Elias', 'Jenkins');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (108, 'Saul', 'Janssen');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (109, 'Terri', 'Bergen');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (110, 'Ivan', 'Woods');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (111, 'Sandra', 'Def');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (112, 'Reese', 'Langella');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (113, 'Hope', 'Griffith');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (114, 'Lois', 'Jane');
commit;
prompt 100 records committed...
insert into STAFF_MEMBER (sid, first_name, last_name)
values (115, 'Julianna', 'Schneider');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (116, 'Karen', 'Woods');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (117, 'Freddie', 'Colin Young');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (118, 'Wendy', 'Choice');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (120, 'Javon', 'Hutton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (121, 'France', 'Tisdale');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (122, 'Earl', 'Theron');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (123, 'Boyd', 'Van Shelton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (125, 'Curtis', 'Gooding');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (126, 'Hilary', 'Vannelli');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (127, 'Aimee', 'Adler');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (128, 'Emerson', 'Payne');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (129, 'Louise', 'Hingle');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (130, 'Julie', 'Brando');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (132, 'Kid', 'Wilson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (133, 'Nelly', 'Holliday');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (137, 'Laura', 'Basinger');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (138, 'Karen', 'Torn');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (140, 'Aimee', 'Boyle');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (141, 'Joanna', 'Richter');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (142, 'Charlize', 'Rooker');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (143, 'Loretta', 'Holly');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (144, 'Miki', 'Paxton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (145, 'Saffron', 'Scott');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (146, 'Mac', 'Rucker');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (147, 'Clay', 'Crystal');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (148, 'Franz', 'Sepulveda');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (152, 'Dom', 'Seagal');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (153, 'Collective', 'Weaving');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (154, 'James', 'McGoohan');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (155, 'Thomas', 'Saucedo');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (156, 'Ice', 'Boothe');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (158, 'Sarah', 'Peebles');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (159, 'Fionnula', 'Holm');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (160, 'Kirsten', 'Thompson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (162, 'Antonio', 'Neeson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (163, 'Suzi', 'Zahn');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (164, 'Cheryl', 'Fehr');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (165, 'Yaphet', 'Ramis');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (166, 'Hilton', 'Shawn');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (167, 'Clarence', 'Lee');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (168, 'Hugh', 'Willard');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (169, 'Emma', 'Firth');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (170, 'Edward', 'Manning');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (171, 'Embeth', 'Oakenfold');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (174, 'Seth', 'Stamp');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (175, 'Tramaine', 'Getty');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (176, 'Jennifer', 'Kudrow');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (177, 'Terence', 'Diesel');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (178, 'Natasha', 'Epps');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (179, 'Mitchell', 'Pollak');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (181, 'Rosanna', 'Bruce');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (182, 'Albertina', 'Singh');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (183, 'Fionnula', 'Rucker');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (184, 'Brothers', 'Duncan');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (185, 'Ozzy', 'Todd');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (188, 'Marley', 'Duke');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (189, 'Judd', 'Kane');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (190, 'Patricia', 'Knight');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (191, 'Hector', 'Tripplehorn');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (192, 'Tea', 'Hedaya');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (193, 'Alessandro', 'Herrmann');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (195, 'Brad', 'Moore');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (196, 'Horace', 'Mifune');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (197, 'Don', 'Lowe');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (198, 'Diane', 'Chung');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (199, 'Jerry', 'Keith');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (200, 'Marc', 'Dolenz');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (201, 'Devon', 'Presley');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (203, 'Leon', 'Lynne');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (204, 'Gabriel', 'Matheson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (205, 'Nancy', 'Fonda');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (206, 'Donald', 'Rodriguez');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (207, 'Lila', 'Drive');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (208, 'Ike', 'Gallant');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (210, 'Jon', 'Albright');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (211, 'Fisher', 'Stowe');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (212, 'Mark', 'Glover');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (213, 'Art', 'Farrow');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (214, 'Cornell', 'Rhames');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (215, 'Geoffrey', 'Morrison');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (216, 'Brittany', 'Dupree');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (219, 'Fairuza', 'Harrelson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (220, 'Percy', 'Dean');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (222, 'Harrison', 'Weller');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (223, 'King', 'Strong');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (224, 'Geraldine', 'Ranger');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (225, 'Don', 'Wopat');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (226, 'Ronny', 'Tsettos');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (227, 'Ani', 'Leoni');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (228, 'Leelee', 'Leguizamo');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (229, 'Gin', 'Dorn');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (230, 'Collin', 'Moreno');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (231, 'Richard', 'Pollack');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (232, 'Ozzy', 'Hingle');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (233, 'Jimmy', 'Leto');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (234, 'Kurtwood', 'Osborne');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (235, 'Edward', 'Sinise');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (236, 'Joy', 'Joli');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (238, 'Emerson', 'Feliciano');
commit;
prompt 200 records committed...
insert into STAFF_MEMBER (sid, first_name, last_name)
values (239, 'Grant', 'Owen');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (240, 'Bobbi', 'Stevens');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (241, 'Mary', 'Hayek');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (242, 'Rich', 'Dutton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (243, 'Marie', 'King');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (244, 'Pelvic', 'Cummings');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (246, 'Phoebe', 'Rizzo');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (247, 'Nikki', 'Matheson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (248, 'Loretta', 'Macy');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (249, 'Owen', 'Bullock');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (250, 'Guy', 'Grier');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (251, 'Garry', 'Luongo');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (253, 'Kim', 'Coyote');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (254, 'Gina', 'Bacharach');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (255, 'Earl', 'Vicious');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (256, 'Vivica', 'Plimpton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (257, 'Noah', 'Bradford');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (258, 'Phoebe', 'Dunst');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (259, 'Terri', 'McConaughey');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (261, 'Jackson', 'Makeba');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (263, 'Avenged', 'Imperioli');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (264, 'Orlando', 'Fraser');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (266, 'Helen', 'Stoltz');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (267, 'Swoosie', 'Ammons');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (268, 'Howie', 'Statham');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (269, 'Neil', 'McGinley');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (270, 'Chazz', 'Joli');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (271, 'Juan', 'Gill');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (273, 'Davy', 'Tisdale');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (274, 'Ray', 'Moraz');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (276, 'Goran', 'Winger');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (277, 'Anne', 'Sutherland');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (278, 'Nora', 'Wheel');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (279, 'Susan', 'Voight');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (280, 'Charlton', 'Burstyn');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (281, 'Ramsey', 'Elizabeth');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (282, 'Phoebe', 'Hoskins');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (283, 'Winona', 'O''Neal');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (284, 'Winona', 'Short');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (285, 'Ann', 'Kramer');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (286, 'Judd', 'Soul');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (287, 'Gran', 'Wilkinson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (288, 'Davis', 'Grier');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (289, 'Merrill', 'Simpson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (290, 'Mary', 'McCoy');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (291, 'Chrissie', 'Wright');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (292, 'Cathy', 'Meniketti');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (293, 'Sander', 'Harmon');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (294, 'Cloris', 'Buffalo');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (295, 'Geoff', 'Braugher');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (297, 'Ben', 'Fogerty');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (298, 'Gordie', 'Richards');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (300, 'Nickel', 'Wagner');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (302, 'Gailard', 'Logue');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (303, 'Garland', 'Emmett');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (305, 'Gordon', 'Wright');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (306, 'Red', 'Tanon');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (307, 'Rascal', 'Head');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (308, 'Susan', 'Stewart');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (309, 'Lin', 'Chambers');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (310, 'Glenn', 'Pearce');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (311, 'Luis', 'Feuerstein');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (312, 'Melba', 'Collins');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (313, 'Mekhi', 'Costa');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (314, 'Rade', 'Cattrall');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (315, 'Minnie', 'McLean');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (316, 'Guy', 'Reeves');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (317, 'Tcheky', 'Kimball');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (319, 'Sean', 'Caldwell');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (320, 'Parker', 'Wopat');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (322, 'Jake', 'Scott');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (323, 'Jimmie', 'Choice');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (324, 'Jennifer', 'Cummings');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (325, 'Emerson', 'Thorton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (327, 'Val', 'Greene');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (329, 'Rod', 'Winstone');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (330, 'Dwight', 'Gano');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (332, 'Elijah', 'Bloch');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (333, 'Benicio', 'Lorenz');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (334, 'Juliette', 'Benoit');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (336, 'Kyle', 'Condition');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (338, 'James', 'Carnes');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (339, 'Wayman', 'Lynn');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (340, 'Anna', 'Gallant');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (341, 'Heather', 'Aykroyd');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (342, 'Clay', 'Love');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (343, 'Rebecca', 'Keitel');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (344, 'Chi', 'Davidtz');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (345, 'Praga', 'Uggams');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (347, 'Wallace', 'Johnson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (348, 'Chrissie', 'Allison');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (349, 'Nelly', 'Arkenstone');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (351, 'Ali', 'Rhymes');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (352, 'Jeanne', 'Ceasar');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (353, 'Bernard', 'Cazale');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (354, 'Hal', 'Cassidy');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (355, 'Oded', 'Quinones');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (357, 'Lydia', 'MacDowell');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (358, 'Kid', 'Alexander');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (360, 'Jeffrey', 'Starr');
commit;
prompt 300 records committed...
insert into STAFF_MEMBER (sid, first_name, last_name)
values (361, 'Joseph', 'Gryner');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (362, 'Cathy', 'Shelton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (363, 'Allan', 'Geldof');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (364, 'Dennis', 'Todd');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (365, 'Jared', 'Lennox');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (366, 'Maura', 'Serbedzija');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (367, 'Andrea', 'Dalton');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (368, 'Jean', 'Diddley');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (369, 'Uma', 'Davidtz');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (370, 'Leelee', 'Nicholson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (371, 'Mae', 'Roy Parnell');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (373, 'Wesley', 'Buffalo');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (374, 'Vanessa', 'Gilley');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (376, 'Anne', 'Wong');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (378, 'Luis', 'Dunaway');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (381, 'Delroy', 'DiCaprio');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (384, 'Jose', 'Meniketti');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (386, 'Vienna', 'Wright');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (387, 'Chazz', 'Neill');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (388, 'Micky', 'Heron');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (390, 'Rufus', 'Penn');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (391, 'Rueben', 'Russo');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (392, 'Miguel', 'Gibson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (394, 'Ernest', 'Ribisi');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (395, 'Famke', 'Santa Rosa');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (396, 'Victor', 'Galecki');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (397, 'Humberto', 'Biel');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (398, 'Tom', 'Simpson');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (399, 'Val', 'Kinski');
insert into STAFF_MEMBER (sid, first_name, last_name)
values (400, 'Johnnie', 'Caldwell');
commit;
prompt 330 records loaded
prompt Loading CLEANING_TASK...
insert into CLEANING_TASK (tid, status, rid, sid)
values (1, 'Completed', 1, 1);
insert into CLEANING_TASK (tid, status, rid, sid)
values (2, 'Pending', 2, 2);
insert into CLEANING_TASK (tid, status, rid, sid)
values (3, 'Completed', 3, 3);
insert into CLEANING_TASK (tid, status, rid, sid)
values (4, 'Pending', 4, 4);
insert into CLEANING_TASK (tid, status, rid, sid)
values (5, 'Completed', 5, 5);
insert into CLEANING_TASK (tid, status, rid, sid)
values (6, 'Pending', 6, 6);
insert into CLEANING_TASK (tid, status, rid, sid)
values (7, 'Completed', 7, 7);
insert into CLEANING_TASK (tid, status, rid, sid)
values (8, 'Pending', 8, 8);
insert into CLEANING_TASK (tid, status, rid, sid)
values (9, 'Completed', 9, 9);
insert into CLEANING_TASK (tid, status, rid, sid)
values (10, 'Pending', 10, 10);
insert into CLEANING_TASK (tid, status, rid, sid)
values (11, 'Completed', 119, 5);
insert into CLEANING_TASK (tid, status, rid, sid)
values (12, 'Completed', 61, 85);
insert into CLEANING_TASK (tid, status, rid, sid)
values (13, 'Completed', 60, 68);
insert into CLEANING_TASK (tid, status, rid, sid)
values (14, 'Pending', 86, 281);
insert into CLEANING_TASK (tid, status, rid, sid)
values (15, 'Pending', 361, 184);
insert into CLEANING_TASK (tid, status, rid, sid)
values (16, 'Pending', 187, 6);
insert into CLEANING_TASK (tid, status, rid, sid)
values (17, 'Pending', 83, 223);
insert into CLEANING_TASK (tid, status, rid, sid)
values (18, 'Completed', 353, 231);
insert into CLEANING_TASK (tid, status, rid, sid)
values (19, 'Pending', 16, 183);
insert into CLEANING_TASK (tid, status, rid, sid)
values (20, 'Pending', 115, 107);
insert into CLEANING_TASK (tid, status, rid, sid)
values (21, 'Completed', 146, 33);
insert into CLEANING_TASK (tid, status, rid, sid)
values (22, 'Pending', 27, 72);
insert into CLEANING_TASK (tid, status, rid, sid)
values (23, 'Completed', 380, 361);
insert into CLEANING_TASK (tid, status, rid, sid)
values (24, 'Pending', 75, 141);
insert into CLEANING_TASK (tid, status, rid, sid)
values (25, 'Completed', 8, 234);
insert into CLEANING_TASK (tid, status, rid, sid)
values (26, 'Completed', 246, 3);
insert into CLEANING_TASK (tid, status, rid, sid)
values (27, 'Completed', 107, 347);
insert into CLEANING_TASK (tid, status, rid, sid)
values (28, 'Pending', 108, 37);
insert into CLEANING_TASK (tid, status, rid, sid)
values (29, 'Completed', 281, 277);
insert into CLEANING_TASK (tid, status, rid, sid)
values (30, 'Pending', 158, 282);
insert into CLEANING_TASK (tid, status, rid, sid)
values (31, 'Pending', 272, 391);
insert into CLEANING_TASK (tid, status, rid, sid)
values (32, 'Completed', 103, 5);
insert into CLEANING_TASK (tid, status, rid, sid)
values (33, 'Completed', 232, 376);
insert into CLEANING_TASK (tid, status, rid, sid)
values (34, 'Pending', 154, 351);
insert into CLEANING_TASK (tid, status, rid, sid)
values (35, 'Completed', 286, 192);
insert into CLEANING_TASK (tid, status, rid, sid)
values (36, 'Pending', 313, 229);
insert into CLEANING_TASK (tid, status, rid, sid)
values (37, 'Pending', 213, 278);
insert into CLEANING_TASK (tid, status, rid, sid)
values (38, 'Completed', 292, 248);
insert into CLEANING_TASK (tid, status, rid, sid)
values (39, 'Completed', 343, 308);
insert into CLEANING_TASK (tid, status, rid, sid)
values (40, 'Completed', 169, 85);
insert into CLEANING_TASK (tid, status, rid, sid)
values (41, 'Completed', 19, 77);
insert into CLEANING_TASK (tid, status, rid, sid)
values (42, 'Completed', 371, 325);
insert into CLEANING_TASK (tid, status, rid, sid)
values (43, 'Completed', 119, 118);
insert into CLEANING_TASK (tid, status, rid, sid)
values (44, 'Completed', 140, 147);
insert into CLEANING_TASK (tid, status, rid, sid)
values (45, 'Completed', 183, 115);
insert into CLEANING_TASK (tid, status, rid, sid)
values (46, 'Pending', 250, 163);
insert into CLEANING_TASK (tid, status, rid, sid)
values (47, 'Completed', 9, 13);
insert into CLEANING_TASK (tid, status, rid, sid)
values (48, 'Completed', 261, 349);
insert into CLEANING_TASK (tid, status, rid, sid)
values (49, 'Completed', 112, 290);
insert into CLEANING_TASK (tid, status, rid, sid)
values (50, 'Completed', 292, 109);
insert into CLEANING_TASK (tid, status, rid, sid)
values (51, 'Completed', 45, 9);
insert into CLEANING_TASK (tid, status, rid, sid)
values (52, 'Pending', 254, 138);
insert into CLEANING_TASK (tid, status, rid, sid)
values (53, 'Completed', 277, 17);
insert into CLEANING_TASK (tid, status, rid, sid)
values (54, 'Completed', 307, 117);
insert into CLEANING_TASK (tid, status, rid, sid)
values (55, 'Pending', 151, 256);
insert into CLEANING_TASK (tid, status, rid, sid)
values (56, 'Completed', 290, 192);
insert into CLEANING_TASK (tid, status, rid, sid)
values (57, 'Pending', 150, 154);
insert into CLEANING_TASK (tid, status, rid, sid)
values (58, 'Completed', 278, 327);
insert into CLEANING_TASK (tid, status, rid, sid)
values (59, 'Pending', 294, 223);
insert into CLEANING_TASK (tid, status, rid, sid)
values (60, 'Pending', 309, 147);
insert into CLEANING_TASK (tid, status, rid, sid)
values (61, 'Pending', 106, 345);
insert into CLEANING_TASK (tid, status, rid, sid)
values (62, 'Pending', 264, 261);
insert into CLEANING_TASK (tid, status, rid, sid)
values (63, 'Pending', 394, 248);
insert into CLEANING_TASK (tid, status, rid, sid)
values (64, 'Completed', 338, 103);
insert into CLEANING_TASK (tid, status, rid, sid)
values (65, 'Pending', 398, 91);
insert into CLEANING_TASK (tid, status, rid, sid)
values (66, 'Completed', 134, 66);
insert into CLEANING_TASK (tid, status, rid, sid)
values (67, 'Pending', 330, 21);
insert into CLEANING_TASK (tid, status, rid, sid)
values (68, 'Pending', 324, 145);
insert into CLEANING_TASK (tid, status, rid, sid)
values (69, 'Completed', 398, 396);
insert into CLEANING_TASK (tid, status, rid, sid)
values (70, 'Completed', 347, 93);
insert into CLEANING_TASK (tid, status, rid, sid)
values (71, 'Completed', 120, 298);
insert into CLEANING_TASK (tid, status, rid, sid)
values (72, 'Completed', 141, 261);
insert into CLEANING_TASK (tid, status, rid, sid)
values (73, 'Completed', 220, 116);
insert into CLEANING_TASK (tid, status, rid, sid)
values (74, 'Completed', 226, 27);
insert into CLEANING_TASK (tid, status, rid, sid)
values (75, 'Completed', 21, 212);
insert into CLEANING_TASK (tid, status, rid, sid)
values (76, 'Completed', 68, 286);
insert into CLEANING_TASK (tid, status, rid, sid)
values (77, 'Completed', 132, 29);
insert into CLEANING_TASK (tid, status, rid, sid)
values (78, 'Pending', 332, 73);
insert into CLEANING_TASK (tid, status, rid, sid)
values (79, 'Pending', 398, 270);
insert into CLEANING_TASK (tid, status, rid, sid)
values (80, 'Completed', 194, 54);
insert into CLEANING_TASK (tid, status, rid, sid)
values (81, 'Pending', 59, 183);
insert into CLEANING_TASK (tid, status, rid, sid)
values (82, 'Pending', 9, 400);
insert into CLEANING_TASK (tid, status, rid, sid)
values (83, 'Pending', 136, 23);
insert into CLEANING_TASK (tid, status, rid, sid)
values (84, 'Completed', 77, 392);
insert into CLEANING_TASK (tid, status, rid, sid)
values (85, 'Completed', 384, 122);
insert into CLEANING_TASK (tid, status, rid, sid)
values (86, 'Completed', 85, 360);
insert into CLEANING_TASK (tid, status, rid, sid)
values (87, 'Pending', 38, 270);
insert into CLEANING_TASK (tid, status, rid, sid)
values (88, 'Pending', 74, 126);
insert into CLEANING_TASK (tid, status, rid, sid)
values (89, 'Completed', 155, 152);
insert into CLEANING_TASK (tid, status, rid, sid)
values (90, 'Completed', 396, 269);
insert into CLEANING_TASK (tid, status, rid, sid)
values (91, 'Pending', 162, 203);
insert into CLEANING_TASK (tid, status, rid, sid)
values (92, 'Completed', 298, 355);
insert into CLEANING_TASK (tid, status, rid, sid)
values (93, 'Completed', 105, 250);
insert into CLEANING_TASK (tid, status, rid, sid)
values (94, 'Pending', 344, 278);
insert into CLEANING_TASK (tid, status, rid, sid)
values (95, 'Completed', 175, 354);
insert into CLEANING_TASK (tid, status, rid, sid)
values (96, 'Pending', 1, 141);
insert into CLEANING_TASK (tid, status, rid, sid)
values (97, 'Pending', 385, 175);
insert into CLEANING_TASK (tid, status, rid, sid)
values (98, 'Completed', 335, 129);
insert into CLEANING_TASK (tid, status, rid, sid)
values (99, 'Completed', 249, 339);
insert into CLEANING_TASK (tid, status, rid, sid)
values (100, 'Pending', 354, 276);
commit;
prompt 100 records committed...
insert into CLEANING_TASK (tid, status, rid, sid)
values (101, 'Pending', 223, 387);
insert into CLEANING_TASK (tid, status, rid, sid)
values (102, 'Completed', 109, 100);
insert into CLEANING_TASK (tid, status, rid, sid)
values (103, 'Pending', 180, 67);
insert into CLEANING_TASK (tid, status, rid, sid)
values (104, 'Completed', 12, 284);
insert into CLEANING_TASK (tid, status, rid, sid)
values (105, 'Completed', 18, 320);
insert into CLEANING_TASK (tid, status, rid, sid)
values (106, 'Pending', 23, 348);
insert into CLEANING_TASK (tid, status, rid, sid)
values (107, 'Pending', 80, 9);
insert into CLEANING_TASK (tid, status, rid, sid)
values (108, 'Pending', 235, 313);
insert into CLEANING_TASK (tid, status, rid, sid)
values (109, 'Completed', 62, 238);
insert into CLEANING_TASK (tid, status, rid, sid)
values (110, 'Completed', 271, 364);
insert into CLEANING_TASK (tid, status, rid, sid)
values (111, 'Completed', 85, 200);
insert into CLEANING_TASK (tid, status, rid, sid)
values (112, 'Pending', 366, 74);
insert into CLEANING_TASK (tid, status, rid, sid)
values (113, 'Pending', 212, 204);
insert into CLEANING_TASK (tid, status, rid, sid)
values (114, 'Pending', 340, 333);
insert into CLEANING_TASK (tid, status, rid, sid)
values (115, 'Completed', 263, 152);
insert into CLEANING_TASK (tid, status, rid, sid)
values (116, 'Pending', 215, 273);
insert into CLEANING_TASK (tid, status, rid, sid)
values (117, 'Completed', 103, 190);
insert into CLEANING_TASK (tid, status, rid, sid)
values (118, 'Pending', 255, 313);
insert into CLEANING_TASK (tid, status, rid, sid)
values (119, 'Pending', 344, 374);
insert into CLEANING_TASK (tid, status, rid, sid)
values (120, 'Completed', 374, 115);
insert into CLEANING_TASK (tid, status, rid, sid)
values (121, 'Completed', 24, 267);
insert into CLEANING_TASK (tid, status, rid, sid)
values (122, 'Completed', 113, 38);
insert into CLEANING_TASK (tid, status, rid, sid)
values (123, 'Pending', 258, 264);
insert into CLEANING_TASK (tid, status, rid, sid)
values (124, 'Completed', 393, 112);
insert into CLEANING_TASK (tid, status, rid, sid)
values (125, 'Completed', 251, 295);
insert into CLEANING_TASK (tid, status, rid, sid)
values (126, 'Pending', 92, 253);
insert into CLEANING_TASK (tid, status, rid, sid)
values (127, 'Pending', 116, 56);
insert into CLEANING_TASK (tid, status, rid, sid)
values (128, 'Pending', 53, 362);
insert into CLEANING_TASK (tid, status, rid, sid)
values (129, 'Completed', 347, 259);
insert into CLEANING_TASK (tid, status, rid, sid)
values (130, 'Completed', 394, 184);
insert into CLEANING_TASK (tid, status, rid, sid)
values (131, 'Completed', 10, 224);
insert into CLEANING_TASK (tid, status, rid, sid)
values (132, 'Completed', 260, 167);
insert into CLEANING_TASK (tid, status, rid, sid)
values (133, 'Completed', 41, 68);
insert into CLEANING_TASK (tid, status, rid, sid)
values (134, 'Completed', 324, 247);
insert into CLEANING_TASK (tid, status, rid, sid)
values (135, 'Pending', 68, 188);
insert into CLEANING_TASK (tid, status, rid, sid)
values (136, 'Pending', 203, 115);
insert into CLEANING_TASK (tid, status, rid, sid)
values (137, 'Pending', 176, 158);
insert into CLEANING_TASK (tid, status, rid, sid)
values (138, 'Completed', 176, 13);
insert into CLEANING_TASK (tid, status, rid, sid)
values (139, 'Completed', 131, 341);
insert into CLEANING_TASK (tid, status, rid, sid)
values (140, 'Pending', 290, 319);
insert into CLEANING_TASK (tid, status, rid, sid)
values (141, 'Completed', 361, 322);
insert into CLEANING_TASK (tid, status, rid, sid)
values (142, 'Completed', 116, 323);
insert into CLEANING_TASK (tid, status, rid, sid)
values (143, 'Pending', 111, 250);
insert into CLEANING_TASK (tid, status, rid, sid)
values (144, 'Completed', 113, 140);
insert into CLEANING_TASK (tid, status, rid, sid)
values (145, 'Pending', 394, 310);
insert into CLEANING_TASK (tid, status, rid, sid)
values (146, 'Pending', 327, 165);
insert into CLEANING_TASK (tid, status, rid, sid)
values (147, 'Pending', 183, 26);
insert into CLEANING_TASK (tid, status, rid, sid)
values (148, 'Completed', 356, 69);
insert into CLEANING_TASK (tid, status, rid, sid)
values (149, 'Completed', 304, 216);
insert into CLEANING_TASK (tid, status, rid, sid)
values (150, 'Pending', 14, 219);
insert into CLEANING_TASK (tid, status, rid, sid)
values (151, 'Completed', 57, 344);
insert into CLEANING_TASK (tid, status, rid, sid)
values (152, 'Pending', 89, 113);
insert into CLEANING_TASK (tid, status, rid, sid)
values (153, 'Pending', 284, 397);
insert into CLEANING_TASK (tid, status, rid, sid)
values (154, 'Pending', 147, 276);
insert into CLEANING_TASK (tid, status, rid, sid)
values (155, 'Pending', 307, 288);
insert into CLEANING_TASK (tid, status, rid, sid)
values (156, 'Pending', 172, 348);
insert into CLEANING_TASK (tid, status, rid, sid)
values (157, 'Pending', 344, 340);
insert into CLEANING_TASK (tid, status, rid, sid)
values (158, 'Pending', 110, 238);
insert into CLEANING_TASK (tid, status, rid, sid)
values (159, 'Completed', 396, 306);
insert into CLEANING_TASK (tid, status, rid, sid)
values (160, 'Pending', 7, 190);
insert into CLEANING_TASK (tid, status, rid, sid)
values (161, 'Pending', 374, 28);
insert into CLEANING_TASK (tid, status, rid, sid)
values (162, 'Pending', 157, 103);
insert into CLEANING_TASK (tid, status, rid, sid)
values (163, 'Completed', 160, 60);
insert into CLEANING_TASK (tid, status, rid, sid)
values (164, 'Pending', 159, 247);
insert into CLEANING_TASK (tid, status, rid, sid)
values (165, 'Pending', 237, 214);
insert into CLEANING_TASK (tid, status, rid, sid)
values (166, 'Completed', 42, 43);
insert into CLEANING_TASK (tid, status, rid, sid)
values (167, 'Pending', 9, 240);
insert into CLEANING_TASK (tid, status, rid, sid)
values (168, 'Pending', 293, 300);
insert into CLEANING_TASK (tid, status, rid, sid)
values (169, 'Pending', 391, 155);
insert into CLEANING_TASK (tid, status, rid, sid)
values (170, 'Pending', 308, 179);
insert into CLEANING_TASK (tid, status, rid, sid)
values (171, 'Pending', 392, 343);
insert into CLEANING_TASK (tid, status, rid, sid)
values (172, 'Pending', 338, 277);
insert into CLEANING_TASK (tid, status, rid, sid)
values (173, 'Pending', 44, 219);
insert into CLEANING_TASK (tid, status, rid, sid)
values (174, 'Completed', 20, 167);
insert into CLEANING_TASK (tid, status, rid, sid)
values (175, 'Pending', 398, 77);
insert into CLEANING_TASK (tid, status, rid, sid)
values (176, 'Pending', 129, 367);
insert into CLEANING_TASK (tid, status, rid, sid)
values (177, 'Completed', 357, 114);
insert into CLEANING_TASK (tid, status, rid, sid)
values (178, 'Completed', 16, 386);
insert into CLEANING_TASK (tid, status, rid, sid)
values (179, 'Pending', 233, 184);
insert into CLEANING_TASK (tid, status, rid, sid)
values (180, 'Completed', 43, 148);
insert into CLEANING_TASK (tid, status, rid, sid)
values (181, 'Completed', 287, 352);
insert into CLEANING_TASK (tid, status, rid, sid)
values (182, 'Completed', 69, 253);
insert into CLEANING_TASK (tid, status, rid, sid)
values (183, 'Pending', 41, 162);
insert into CLEANING_TASK (tid, status, rid, sid)
values (184, 'Completed', 76, 254);
insert into CLEANING_TASK (tid, status, rid, sid)
values (185, 'Pending', 397, 294);
insert into CLEANING_TASK (tid, status, rid, sid)
values (186, 'Pending', 22, 54);
insert into CLEANING_TASK (tid, status, rid, sid)
values (187, 'Completed', 17, 66);
insert into CLEANING_TASK (tid, status, rid, sid)
values (188, 'Pending', 67, 277);
insert into CLEANING_TASK (tid, status, rid, sid)
values (189, 'Pending', 18, 201);
insert into CLEANING_TASK (tid, status, rid, sid)
values (190, 'Pending', 302, 14);
insert into CLEANING_TASK (tid, status, rid, sid)
values (191, 'Pending', 76, 64);
insert into CLEANING_TASK (tid, status, rid, sid)
values (192, 'Pending', 334, 228);
insert into CLEANING_TASK (tid, status, rid, sid)
values (193, 'Completed', 82, 23);
insert into CLEANING_TASK (tid, status, rid, sid)
values (194, 'Pending', 74, 392);
insert into CLEANING_TASK (tid, status, rid, sid)
values (195, 'Completed', 227, 338);
insert into CLEANING_TASK (tid, status, rid, sid)
values (196, 'Pending', 23, 224);
insert into CLEANING_TASK (tid, status, rid, sid)
values (197, 'Pending', 27, 154);
insert into CLEANING_TASK (tid, status, rid, sid)
values (198, 'Completed', 223, 128);
insert into CLEANING_TASK (tid, status, rid, sid)
values (199, 'Pending', 110, 9);
insert into CLEANING_TASK (tid, status, rid, sid)
values (200, 'Pending', 218, 363);
commit;
prompt 200 records committed...
insert into CLEANING_TASK (tid, status, rid, sid)
values (201, 'Completed', 87, 292);
insert into CLEANING_TASK (tid, status, rid, sid)
values (202, 'Completed', 46, 34);
insert into CLEANING_TASK (tid, status, rid, sid)
values (203, 'Completed', 261, 258);
insert into CLEANING_TASK (tid, status, rid, sid)
values (204, 'Completed', 140, 40);
insert into CLEANING_TASK (tid, status, rid, sid)
values (205, 'Completed', 363, 225);
insert into CLEANING_TASK (tid, status, rid, sid)
values (206, 'Completed', 242, 243);
insert into CLEANING_TASK (tid, status, rid, sid)
values (207, 'Completed', 146, 143);
insert into CLEANING_TASK (tid, status, rid, sid)
values (208, 'Completed', 62, 51);
insert into CLEANING_TASK (tid, status, rid, sid)
values (209, 'Pending', 185, 88);
insert into CLEANING_TASK (tid, status, rid, sid)
values (210, 'Pending', 63, 116);
insert into CLEANING_TASK (tid, status, rid, sid)
values (211, 'Pending', 131, 69);
insert into CLEANING_TASK (tid, status, rid, sid)
values (212, 'Completed', 277, 158);
insert into CLEANING_TASK (tid, status, rid, sid)
values (213, 'Pending', 184, 106);
insert into CLEANING_TASK (tid, status, rid, sid)
values (214, 'Completed', 229, 120);
insert into CLEANING_TASK (tid, status, rid, sid)
values (215, 'Completed', 244, 16);
insert into CLEANING_TASK (tid, status, rid, sid)
values (216, 'Pending', 348, 53);
insert into CLEANING_TASK (tid, status, rid, sid)
values (217, 'Pending', 354, 368);
insert into CLEANING_TASK (tid, status, rid, sid)
values (218, 'Pending', 68, 78);
insert into CLEANING_TASK (tid, status, rid, sid)
values (219, 'Pending', 278, 92);
insert into CLEANING_TASK (tid, status, rid, sid)
values (220, 'Pending', 167, 195);
insert into CLEANING_TASK (tid, status, rid, sid)
values (221, 'Completed', 338, 51);
insert into CLEANING_TASK (tid, status, rid, sid)
values (222, 'Completed', 283, 297);
insert into CLEANING_TASK (tid, status, rid, sid)
values (223, 'Completed', 301, 293);
insert into CLEANING_TASK (tid, status, rid, sid)
values (224, 'Pending', 62, 264);
insert into CLEANING_TASK (tid, status, rid, sid)
values (225, 'Completed', 222, 44);
insert into CLEANING_TASK (tid, status, rid, sid)
values (226, 'Completed', 4, 188);
insert into CLEANING_TASK (tid, status, rid, sid)
values (227, 'Pending', 320, 55);
insert into CLEANING_TASK (tid, status, rid, sid)
values (228, 'Pending', 78, 287);
insert into CLEANING_TASK (tid, status, rid, sid)
values (229, 'Pending', 259, 176);
insert into CLEANING_TASK (tid, status, rid, sid)
values (230, 'Pending', 130, 274);
insert into CLEANING_TASK (tid, status, rid, sid)
values (231, 'Pending', 360, 285);
insert into CLEANING_TASK (tid, status, rid, sid)
values (232, 'Pending', 268, 10);
insert into CLEANING_TASK (tid, status, rid, sid)
values (233, 'Pending', 24, 6);
insert into CLEANING_TASK (tid, status, rid, sid)
values (234, 'Completed', 224, 397);
insert into CLEANING_TASK (tid, status, rid, sid)
values (235, 'Pending', 319, 235);
insert into CLEANING_TASK (tid, status, rid, sid)
values (236, 'Completed', 312, 144);
insert into CLEANING_TASK (tid, status, rid, sid)
values (237, 'Pending', 395, 189);
insert into CLEANING_TASK (tid, status, rid, sid)
values (238, 'Completed', 348, 231);
insert into CLEANING_TASK (tid, status, rid, sid)
values (239, 'Completed', 241, 116);
insert into CLEANING_TASK (tid, status, rid, sid)
values (240, 'Completed', 118, 68);
insert into CLEANING_TASK (tid, status, rid, sid)
values (241, 'Completed', 294, 357);
insert into CLEANING_TASK (tid, status, rid, sid)
values (242, 'Completed', 128, 307);
insert into CLEANING_TASK (tid, status, rid, sid)
values (243, 'Completed', 179, 32);
insert into CLEANING_TASK (tid, status, rid, sid)
values (244, 'Pending', 313, 230);
insert into CLEANING_TASK (tid, status, rid, sid)
values (245, 'Pending', 158, 344);
insert into CLEANING_TASK (tid, status, rid, sid)
values (246, 'Completed', 213, 258);
insert into CLEANING_TASK (tid, status, rid, sid)
values (247, 'Pending', 96, 302);
insert into CLEANING_TASK (tid, status, rid, sid)
values (248, 'Completed', 75, 7);
insert into CLEANING_TASK (tid, status, rid, sid)
values (249, 'Completed', 279, 84);
insert into CLEANING_TASK (tid, status, rid, sid)
values (250, 'Completed', 224, 280);
insert into CLEANING_TASK (tid, status, rid, sid)
values (251, 'Completed', 360, 370);
insert into CLEANING_TASK (tid, status, rid, sid)
values (252, 'Completed', 217, 277);
insert into CLEANING_TASK (tid, status, rid, sid)
values (253, 'Completed', 199, 19);
insert into CLEANING_TASK (tid, status, rid, sid)
values (254, 'Completed', 170, 330);
insert into CLEANING_TASK (tid, status, rid, sid)
values (255, 'Pending', 294, 365);
insert into CLEANING_TASK (tid, status, rid, sid)
values (256, 'Completed', 373, 63);
insert into CLEANING_TASK (tid, status, rid, sid)
values (257, 'Pending', 274, 345);
insert into CLEANING_TASK (tid, status, rid, sid)
values (258, 'Pending', 8, 59);
insert into CLEANING_TASK (tid, status, rid, sid)
values (259, 'Pending', 330, 315);
insert into CLEANING_TASK (tid, status, rid, sid)
values (260, 'Pending', 11, 309);
insert into CLEANING_TASK (tid, status, rid, sid)
values (261, 'Pending', 211, 323);
insert into CLEANING_TASK (tid, status, rid, sid)
values (262, 'Completed', 134, 185);
insert into CLEANING_TASK (tid, status, rid, sid)
values (263, 'Pending', 229, 68);
insert into CLEANING_TASK (tid, status, rid, sid)
values (264, 'Completed', 291, 329);
insert into CLEANING_TASK (tid, status, rid, sid)
values (265, 'Pending', 288, 192);
insert into CLEANING_TASK (tid, status, rid, sid)
values (266, 'Completed', 81, 118);
insert into CLEANING_TASK (tid, status, rid, sid)
values (267, 'Completed', 326, 327);
insert into CLEANING_TASK (tid, status, rid, sid)
values (268, 'Completed', 328, 205);
insert into CLEANING_TASK (tid, status, rid, sid)
values (269, 'Pending', 254, 319);
insert into CLEANING_TASK (tid, status, rid, sid)
values (270, 'Pending', 11, 341);
insert into CLEANING_TASK (tid, status, rid, sid)
values (271, 'Pending', 46, 70);
insert into CLEANING_TASK (tid, status, rid, sid)
values (272, 'Completed', 258, 75);
insert into CLEANING_TASK (tid, status, rid, sid)
values (273, 'Completed', 230, 305);
insert into CLEANING_TASK (tid, status, rid, sid)
values (274, 'Completed', 78, 143);
insert into CLEANING_TASK (tid, status, rid, sid)
values (275, 'Completed', 56, 129);
insert into CLEANING_TASK (tid, status, rid, sid)
values (276, 'Completed', 64, 177);
insert into CLEANING_TASK (tid, status, rid, sid)
values (277, 'Pending', 3, 86);
insert into CLEANING_TASK (tid, status, rid, sid)
values (278, 'Completed', 44, 236);
insert into CLEANING_TASK (tid, status, rid, sid)
values (279, 'Pending', 106, 20);
insert into CLEANING_TASK (tid, status, rid, sid)
values (280, 'Pending', 383, 395);
insert into CLEANING_TASK (tid, status, rid, sid)
values (281, 'Pending', 25, 364);
insert into CLEANING_TASK (tid, status, rid, sid)
values (282, 'Pending', 32, 228);
insert into CLEANING_TASK (tid, status, rid, sid)
values (283, 'Completed', 315, 6);
insert into CLEANING_TASK (tid, status, rid, sid)
values (284, 'Pending', 19, 179);
insert into CLEANING_TASK (tid, status, rid, sid)
values (285, 'Pending', 328, 190);
insert into CLEANING_TASK (tid, status, rid, sid)
values (286, 'Pending', 190, 290);
insert into CLEANING_TASK (tid, status, rid, sid)
values (287, 'Pending', 161, 59);
insert into CLEANING_TASK (tid, status, rid, sid)
values (288, 'Completed', 209, 176);
insert into CLEANING_TASK (tid, status, rid, sid)
values (289, 'Pending', 51, 37);
insert into CLEANING_TASK (tid, status, rid, sid)
values (290, 'Pending', 358, 2);
insert into CLEANING_TASK (tid, status, rid, sid)
values (291, 'Pending', 328, 327);
insert into CLEANING_TASK (tid, status, rid, sid)
values (292, 'Pending', 160, 241);
insert into CLEANING_TASK (tid, status, rid, sid)
values (293, 'Completed', 393, 392);
insert into CLEANING_TASK (tid, status, rid, sid)
values (294, 'Pending', 112, 292);
insert into CLEANING_TASK (tid, status, rid, sid)
values (295, 'Completed', 266, 160);
insert into CLEANING_TASK (tid, status, rid, sid)
values (296, 'Pending', 91, 188);
insert into CLEANING_TASK (tid, status, rid, sid)
values (297, 'Pending', 300, 398);
insert into CLEANING_TASK (tid, status, rid, sid)
values (298, 'Pending', 64, 80);
insert into CLEANING_TASK (tid, status, rid, sid)
values (299, 'Pending', 24, 97);
insert into CLEANING_TASK (tid, status, rid, sid)
values (300, 'Completed', 117, 121);
commit;
prompt 300 records committed...
insert into CLEANING_TASK (tid, status, rid, sid)
values (301, 'Completed', 281, 378);
insert into CLEANING_TASK (tid, status, rid, sid)
values (302, 'Completed', 208, 115);
insert into CLEANING_TASK (tid, status, rid, sid)
values (303, 'Pending', 209, 87);
insert into CLEANING_TASK (tid, status, rid, sid)
values (304, 'Completed', 200, 112);
insert into CLEANING_TASK (tid, status, rid, sid)
values (305, 'Completed', 271, 170);
insert into CLEANING_TASK (tid, status, rid, sid)
values (306, 'Pending', 384, 239);
insert into CLEANING_TASK (tid, status, rid, sid)
values (307, 'Completed', 26, 123);
insert into CLEANING_TASK (tid, status, rid, sid)
values (308, 'Pending', 99, 290);
insert into CLEANING_TASK (tid, status, rid, sid)
values (309, 'Completed', 345, 109);
insert into CLEANING_TASK (tid, status, rid, sid)
values (310, 'Completed', 52, 353);
insert into CLEANING_TASK (tid, status, rid, sid)
values (311, 'Completed', 266, 378);
insert into CLEANING_TASK (tid, status, rid, sid)
values (312, 'Pending', 353, 76);
insert into CLEANING_TASK (tid, status, rid, sid)
values (313, 'Completed', 379, 386);
insert into CLEANING_TASK (tid, status, rid, sid)
values (314, 'Pending', 241, 319);
insert into CLEANING_TASK (tid, status, rid, sid)
values (315, 'Pending', 175, 14);
insert into CLEANING_TASK (tid, status, rid, sid)
values (316, 'Completed', 230, 241);
insert into CLEANING_TASK (tid, status, rid, sid)
values (317, 'Completed', 84, 204);
insert into CLEANING_TASK (tid, status, rid, sid)
values (318, 'Pending', 273, 85);
insert into CLEANING_TASK (tid, status, rid, sid)
values (319, 'Completed', 88, 358);
insert into CLEANING_TASK (tid, status, rid, sid)
values (320, 'Pending', 264, 330);
insert into CLEANING_TASK (tid, status, rid, sid)
values (321, 'Completed', 96, 286);
insert into CLEANING_TASK (tid, status, rid, sid)
values (322, 'Completed', 329, 248);
insert into CLEANING_TASK (tid, status, rid, sid)
values (323, 'Pending', 169, 208);
insert into CLEANING_TASK (tid, status, rid, sid)
values (324, 'Pending', 323, 117);
insert into CLEANING_TASK (tid, status, rid, sid)
values (325, 'Pending', 146, 340);
insert into CLEANING_TASK (tid, status, rid, sid)
values (326, 'Pending', 247, 163);
insert into CLEANING_TASK (tid, status, rid, sid)
values (327, 'Completed', 105, 374);
insert into CLEANING_TASK (tid, status, rid, sid)
values (328, 'Pending', 228, 239);
insert into CLEANING_TASK (tid, status, rid, sid)
values (329, 'Pending', 12, 32);
insert into CLEANING_TASK (tid, status, rid, sid)
values (330, 'Pending', 226, 394);
insert into CLEANING_TASK (tid, status, rid, sid)
values (331, 'Completed', 337, 212);
insert into CLEANING_TASK (tid, status, rid, sid)
values (332, 'Pending', 66, 71);
insert into CLEANING_TASK (tid, status, rid, sid)
values (333, 'Completed', 250, 85);
insert into CLEANING_TASK (tid, status, rid, sid)
values (334, 'Pending', 24, 27);
insert into CLEANING_TASK (tid, status, rid, sid)
values (335, 'Pending', 256, 253);
insert into CLEANING_TASK (tid, status, rid, sid)
values (336, 'Completed', 219, 200);
insert into CLEANING_TASK (tid, status, rid, sid)
values (337, 'Pending', 226, 247);
insert into CLEANING_TASK (tid, status, rid, sid)
values (338, 'Pending', 128, 239);
insert into CLEANING_TASK (tid, status, rid, sid)
values (339, 'Completed', 133, 283);
insert into CLEANING_TASK (tid, status, rid, sid)
values (340, 'Completed', 41, 145);
insert into CLEANING_TASK (tid, status, rid, sid)
values (341, 'Pending', 239, 148);
insert into CLEANING_TASK (tid, status, rid, sid)
values (342, 'Completed', 74, 39);
insert into CLEANING_TASK (tid, status, rid, sid)
values (343, 'Completed', 49, 388);
insert into CLEANING_TASK (tid, status, rid, sid)
values (344, 'Pending', 223, 91);
insert into CLEANING_TASK (tid, status, rid, sid)
values (345, 'Completed', 257, 384);
insert into CLEANING_TASK (tid, status, rid, sid)
values (346, 'Pending', 8, 181);
insert into CLEANING_TASK (tid, status, rid, sid)
values (347, 'Pending', 354, 117);
insert into CLEANING_TASK (tid, status, rid, sid)
values (348, 'Completed', 364, 282);
insert into CLEANING_TASK (tid, status, rid, sid)
values (349, 'Pending', 256, 60);
insert into CLEANING_TASK (tid, status, rid, sid)
values (350, 'Pending', 58, 152);
insert into CLEANING_TASK (tid, status, rid, sid)
values (351, 'Pending', 345, 251);
insert into CLEANING_TASK (tid, status, rid, sid)
values (352, 'Completed', 191, 239);
insert into CLEANING_TASK (tid, status, rid, sid)
values (353, 'Pending', 83, 316);
insert into CLEANING_TASK (tid, status, rid, sid)
values (354, 'Completed', 204, 59);
insert into CLEANING_TASK (tid, status, rid, sid)
values (355, 'Completed', 286, 179);
insert into CLEANING_TASK (tid, status, rid, sid)
values (356, 'Pending', 152, 52);
insert into CLEANING_TASK (tid, status, rid, sid)
values (357, 'Completed', 42, 279);
insert into CLEANING_TASK (tid, status, rid, sid)
values (358, 'Completed', 228, 93);
insert into CLEANING_TASK (tid, status, rid, sid)
values (359, 'Completed', 58, 324);
insert into CLEANING_TASK (tid, status, rid, sid)
values (360, 'Pending', 18, 111);
insert into CLEANING_TASK (tid, status, rid, sid)
values (361, 'Completed', 306, 355);
insert into CLEANING_TASK (tid, status, rid, sid)
values (362, 'Pending', 226, 6);
insert into CLEANING_TASK (tid, status, rid, sid)
values (363, 'Completed', 170, 46);
insert into CLEANING_TASK (tid, status, rid, sid)
values (364, 'Completed', 216, 115);
insert into CLEANING_TASK (tid, status, rid, sid)
values (365, 'Pending', 167, 316);
insert into CLEANING_TASK (tid, status, rid, sid)
values (366, 'Pending', 251, 280);
insert into CLEANING_TASK (tid, status, rid, sid)
values (367, 'Completed', 196, 261);
insert into CLEANING_TASK (tid, status, rid, sid)
values (368, 'Pending', 344, 339);
insert into CLEANING_TASK (tid, status, rid, sid)
values (369, 'Completed', 235, 88);
insert into CLEANING_TASK (tid, status, rid, sid)
values (370, 'Pending', 193, 21);
insert into CLEANING_TASK (tid, status, rid, sid)
values (371, 'Pending', 202, 184);
insert into CLEANING_TASK (tid, status, rid, sid)
values (372, 'Pending', 173, 197);
insert into CLEANING_TASK (tid, status, rid, sid)
values (373, 'Completed', 375, 90);
insert into CLEANING_TASK (tid, status, rid, sid)
values (374, 'Completed', 251, 258);
insert into CLEANING_TASK (tid, status, rid, sid)
values (375, 'Completed', 9, 72);
insert into CLEANING_TASK (tid, status, rid, sid)
values (376, 'Completed', 188, 61);
insert into CLEANING_TASK (tid, status, rid, sid)
values (377, 'Pending', 307, 49);
insert into CLEANING_TASK (tid, status, rid, sid)
values (378, 'Pending', 94, 274);
insert into CLEANING_TASK (tid, status, rid, sid)
values (379, 'Pending', 49, 339);
insert into CLEANING_TASK (tid, status, rid, sid)
values (380, 'Pending', 392, 2);
insert into CLEANING_TASK (tid, status, rid, sid)
values (381, 'Pending', 264, 111);
insert into CLEANING_TASK (tid, status, rid, sid)
values (382, 'Pending', 88, 263);
insert into CLEANING_TASK (tid, status, rid, sid)
values (383, 'Pending', 78, 336);
insert into CLEANING_TASK (tid, status, rid, sid)
values (384, 'Completed', 199, 392);
insert into CLEANING_TASK (tid, status, rid, sid)
values (385, 'Completed', 19, 207);
insert into CLEANING_TASK (tid, status, rid, sid)
values (386, 'Pending', 70, 127);
insert into CLEANING_TASK (tid, status, rid, sid)
values (387, 'Pending', 95, 168);
insert into CLEANING_TASK (tid, status, rid, sid)
values (388, 'Completed', 358, 243);
insert into CLEANING_TASK (tid, status, rid, sid)
values (389, 'Completed', 285, 75);
insert into CLEANING_TASK (tid, status, rid, sid)
values (390, 'Completed', 51, 311);
insert into CLEANING_TASK (tid, status, rid, sid)
values (391, 'Completed', 321, 235);
insert into CLEANING_TASK (tid, status, rid, sid)
values (392, 'Pending', 333, 18);
insert into CLEANING_TASK (tid, status, rid, sid)
values (393, 'Completed', 195, 86);
insert into CLEANING_TASK (tid, status, rid, sid)
values (394, 'Completed', 128, 290);
insert into CLEANING_TASK (tid, status, rid, sid)
values (395, 'Completed', 8, 79);
insert into CLEANING_TASK (tid, status, rid, sid)
values (396, 'Pending', 265, 195);
insert into CLEANING_TASK (tid, status, rid, sid)
values (397, 'Pending', 268, 302);
insert into CLEANING_TASK (tid, status, rid, sid)
values (398, 'Pending', 185, 11);
insert into CLEANING_TASK (tid, status, rid, sid)
values (399, 'Pending', 119, 210);
insert into CLEANING_TASK (tid, status, rid, sid)
values (400, 'Completed', 362, 113);
commit;
prompt 400 records committed...
insert into CLEANING_TASK (tid, status, rid, sid)
values (401, 'Pending', 101, 201);
insert into CLEANING_TASK (tid, status, rid, sid)
values (402, 'Pending', 8, 295);
insert into CLEANING_TASK (tid, status, rid, sid)
values (403, 'Pending', 12, 297);
insert into CLEANING_TASK (tid, status, rid, sid)
values (404, 'Pending', 16, 298);
insert into CLEANING_TASK (tid, status, rid, sid)
values (405, 'Pending', 18, 303);
insert into CLEANING_TASK (tid, status, rid, sid)
values (406, 'Pending', 23, 305);
insert into CLEANING_TASK (tid, status, rid, sid)
values (407, 'Pending', 24, 306);
insert into CLEANING_TASK (tid, status, rid, sid)
values (408, 'Pending', 27, 307);
insert into CLEANING_TASK (tid, status, rid, sid)
values (409, 'Pending', 34, 308);
insert into CLEANING_TASK (tid, status, rid, sid)
values (410, 'Pending', 39, 311);
insert into CLEANING_TASK (tid, status, rid, sid)
values (411, 'Pending', 43, 312);
insert into CLEANING_TASK (tid, status, rid, sid)
values (412, 'Pending', 47, 314);
insert into CLEANING_TASK (tid, status, rid, sid)
values (413, 'Pending', 48, 317);
insert into CLEANING_TASK (tid, status, rid, sid)
values (414, 'Pending', 53, 320);
insert into CLEANING_TASK (tid, status, rid, sid)
values (415, 'Pending', 55, 322);
insert into CLEANING_TASK (tid, status, rid, sid)
values (416, 'Pending', 59, 324);
insert into CLEANING_TASK (tid, status, rid, sid)
values (417, 'Pending', 64, 325);
insert into CLEANING_TASK (tid, status, rid, sid)
values (418, 'Pending', 66, 329);
insert into CLEANING_TASK (tid, status, rid, sid)
values (419, 'Pending', 69, 332);
insert into CLEANING_TASK (tid, status, rid, sid)
values (420, 'Pending', 71, 334);
insert into CLEANING_TASK (tid, status, rid, sid)
values (421, 'Pending', 73, 338);
insert into CLEANING_TASK (tid, status, rid, sid)
values (422, 'Pending', 75, 342);
insert into CLEANING_TASK (tid, status, rid, sid)
values (423, 'Pending', 80, 347);
insert into CLEANING_TASK (tid, status, rid, sid)
values (424, 'Pending', 81, 349);
insert into CLEANING_TASK (tid, status, rid, sid)
values (425, 'Pending', 82, 352);
insert into CLEANING_TASK (tid, status, rid, sid)
values (426, 'Pending', 88, 353);
insert into CLEANING_TASK (tid, status, rid, sid)
values (427, 'Pending', 89, 354);
insert into CLEANING_TASK (tid, status, rid, sid)
values (428, 'Pending', 91, 355);
insert into CLEANING_TASK (tid, status, rid, sid)
values (429, 'Pending', 95, 357);
insert into CLEANING_TASK (tid, status, rid, sid)
values (430, 'Pending', 96, 358);
insert into CLEANING_TASK (tid, status, rid, sid)
values (431, 'Pending', 97, 360);
insert into CLEANING_TASK (tid, status, rid, sid)
values (432, 'Pending', 102, 361);
insert into CLEANING_TASK (tid, status, rid, sid)
values (433, 'Pending', 106, 366);
insert into CLEANING_TASK (tid, status, rid, sid)
values (434, 'Pending', 118, 369);
insert into CLEANING_TASK (tid, status, rid, sid)
values (435, 'Pending', 120, 370);
insert into CLEANING_TASK (tid, status, rid, sid)
values (436, 'Pending', 121, 371);
insert into CLEANING_TASK (tid, status, rid, sid)
values (437, 'Pending', 122, 373);
insert into CLEANING_TASK (tid, status, rid, sid)
values (438, 'Pending', 123, 376);
insert into CLEANING_TASK (tid, status, rid, sid)
values (439, 'Pending', 126, 378);
insert into CLEANING_TASK (tid, status, rid, sid)
values (440, 'Pending', 130, 381);
insert into CLEANING_TASK (tid, status, rid, sid)
values (441, 'Pending', 131, 384);
insert into CLEANING_TASK (tid, status, rid, sid)
values (442, 'Pending', 135, 386);
insert into CLEANING_TASK (tid, status, rid, sid)
values (443, 'Pending', 136, 388);
insert into CLEANING_TASK (tid, status, rid, sid)
values (444, 'Pending', 138, 390);
insert into CLEANING_TASK (tid, status, rid, sid)
values (445, 'Pending', 139, 396);
insert into CLEANING_TASK (tid, status, rid, sid)
values (446, 'Pending', 144, 399);
insert into CLEANING_TASK (tid, status, rid, sid)
values (447, 'Pending', 154, 143);
insert into CLEANING_TASK (tid, status, rid, sid)
values (448, 'Pending', 156, 144);
insert into CLEANING_TASK (tid, status, rid, sid)
values (449, 'Pending', 157, 146);
insert into CLEANING_TASK (tid, status, rid, sid)
values (450, 'Pending', 158, 153);
insert into CLEANING_TASK (tid, status, rid, sid)
values (451, 'Pending', 160, 156);
insert into CLEANING_TASK (tid, status, rid, sid)
values (452, 'Pending', 162, 159);
insert into CLEANING_TASK (tid, status, rid, sid)
values (453, 'Pending', 166, 160);
insert into CLEANING_TASK (tid, status, rid, sid)
values (454, 'Pending', 169, 164);
insert into CLEANING_TASK (tid, status, rid, sid)
values (455, 'Pending', 170, 166);
insert into CLEANING_TASK (tid, status, rid, sid)
values (456, 'Pending', 173, 167);
insert into CLEANING_TASK (tid, status, rid, sid)
values (457, 'Pending', 180, 169);
insert into CLEANING_TASK (tid, status, rid, sid)
values (458, 'Pending', 188, 170);
insert into CLEANING_TASK (tid, status, rid, sid)
values (459, 'Pending', 189, 171);
insert into CLEANING_TASK (tid, status, rid, sid)
values (460, 'Pending', 191, 174);
insert into CLEANING_TASK (tid, status, rid, sid)
values (461, 'Pending', 198, 177);
insert into CLEANING_TASK (tid, status, rid, sid)
values (462, 'Pending', 199, 178);
insert into CLEANING_TASK (tid, status, rid, sid)
values (463, 'Pending', 205, 182);
insert into CLEANING_TASK (tid, status, rid, sid)
values (464, 'Pending', 206, 185);
insert into CLEANING_TASK (tid, status, rid, sid)
values (465, 'Pending', 207, 191);
insert into CLEANING_TASK (tid, status, rid, sid)
values (466, 'Pending', 210, 193);
insert into CLEANING_TASK (tid, status, rid, sid)
values (467, 'Pending', 211, 196);
insert into CLEANING_TASK (tid, status, rid, sid)
values (468, 'Pending', 218, 198);
insert into CLEANING_TASK (tid, status, rid, sid)
values (469, 'Pending', 220, 199);
insert into CLEANING_TASK (tid, status, rid, sid)
values (470, 'Pending', 222, 200);
insert into CLEANING_TASK (tid, status, rid, sid)
values (471, 'Pending', 225, 205);
insert into CLEANING_TASK (tid, status, rid, sid)
values (472, 'Pending', 228, 206);
insert into CLEANING_TASK (tid, status, rid, sid)
values (473, 'Pending', 229, 207);
insert into CLEANING_TASK (tid, status, rid, sid)
values (474, 'Pending', 230, 211);
insert into CLEANING_TASK (tid, status, rid, sid)
values (475, 'Pending', 233, 212);
insert into CLEANING_TASK (tid, status, rid, sid)
values (476, 'Pending', 238, 213);
insert into CLEANING_TASK (tid, status, rid, sid)
values (477, 'Pending', 240, 215);
insert into CLEANING_TASK (tid, status, rid, sid)
values (478, 'Pending', 242, 216);
insert into CLEANING_TASK (tid, status, rid, sid)
values (479, 'Pending', 244, 220);
insert into CLEANING_TASK (tid, status, rid, sid)
values (480, 'Pending', 245, 222);
insert into CLEANING_TASK (tid, status, rid, sid)
values (481, 'Pending', 246, 225);
insert into CLEANING_TASK (tid, status, rid, sid)
values (482, 'Pending', 247, 226);
insert into CLEANING_TASK (tid, status, rid, sid)
values (483, 'Pending', 250, 227);
insert into CLEANING_TASK (tid, status, rid, sid)
values (484, 'Pending', 251, 231);
insert into CLEANING_TASK (tid, status, rid, sid)
values (485, 'Pending', 255, 232);
insert into CLEANING_TASK (tid, status, rid, sid)
values (486, 'Pending', 261, 233);
insert into CLEANING_TASK (tid, status, rid, sid)
values (487, 'Pending', 264, 234);
insert into CLEANING_TASK (tid, status, rid, sid)
values (488, 'Pending', 265, 236);
insert into CLEANING_TASK (tid, status, rid, sid)
values (489, 'Pending', 269, 242);
insert into CLEANING_TASK (tid, status, rid, sid)
values (490, 'Pending', 271, 243);
insert into CLEANING_TASK (tid, status, rid, sid)
values (491, 'Pending', 275, 244);
insert into CLEANING_TASK (tid, status, rid, sid)
values (492, 'Pending', 276, 246);
insert into CLEANING_TASK (tid, status, rid, sid)
values (493, 'Pending', 277, 249);
insert into CLEANING_TASK (tid, status, rid, sid)
values (494, 'Pending', 280, 254);
insert into CLEANING_TASK (tid, status, rid, sid)
values (495, 'Pending', 286, 255);
insert into CLEANING_TASK (tid, status, rid, sid)
values (496, 'Pending', 288, 257);
insert into CLEANING_TASK (tid, status, rid, sid)
values (497, 'Pending', 289, 258);
insert into CLEANING_TASK (tid, status, rid, sid)
values (498, 'Pending', 291, 259);
insert into CLEANING_TASK (tid, status, rid, sid)
values (499, 'Pending', 298, 266);
insert into CLEANING_TASK (tid, status, rid, sid)
values (500, 'Pending', 301, 267);
commit;
prompt 500 records committed...
insert into CLEANING_TASK (tid, status, rid, sid)
values (501, 'Pending', 302, 268);
insert into CLEANING_TASK (tid, status, rid, sid)
values (502, 'Pending', 308, 269);
insert into CLEANING_TASK (tid, status, rid, sid)
values (503, 'Pending', 310, 271);
insert into CLEANING_TASK (tid, status, rid, sid)
values (504, 'Pending', 312, 279);
insert into CLEANING_TASK (tid, status, rid, sid)
values (505, 'Pending', 315, 283);
insert into CLEANING_TASK (tid, status, rid, sid)
values (506, 'Pending', 319, 284);
insert into CLEANING_TASK (tid, status, rid, sid)
values (507, 'Pending', 328, 286);
insert into CLEANING_TASK (tid, status, rid, sid)
values (508, 'Pending', 335, 289);
insert into CLEANING_TASK (tid, status, rid, sid)
values (509, 'Pending', 337, 291);
insert into CLEANING_TASK (tid, status, rid, sid)
values (510, 'Pending', 338, 293);
insert into CLEANING_TASK (tid, status, rid, sid)
values (511, 'Pending', 341, 1);
insert into CLEANING_TASK (tid, status, rid, sid)
values (512, 'Pending', 342, 3);
insert into CLEANING_TASK (tid, status, rid, sid)
values (513, 'Pending', 343, 5);
insert into CLEANING_TASK (tid, status, rid, sid)
values (514, 'Pending', 345, 7);
insert into CLEANING_TASK (tid, status, rid, sid)
values (515, 'Pending', 348, 12);
insert into CLEANING_TASK (tid, status, rid, sid)
values (516, 'Pending', 349, 13);
insert into CLEANING_TASK (tid, status, rid, sid)
values (517, 'Pending', 351, 15);
insert into CLEANING_TASK (tid, status, rid, sid)
values (518, 'Pending', 353, 16);
insert into CLEANING_TASK (tid, status, rid, sid)
values (519, 'Pending', 354, 17);
insert into CLEANING_TASK (tid, status, rid, sid)
values (520, 'Pending', 358, 19);
insert into CLEANING_TASK (tid, status, rid, sid)
values (521, 'Pending', 364, 24);
insert into CLEANING_TASK (tid, status, rid, sid)
values (522, 'Pending', 366, 25);
insert into CLEANING_TASK (tid, status, rid, sid)
values (523, 'Pending', 376, 29);
insert into CLEANING_TASK (tid, status, rid, sid)
values (524, 'Pending', 377, 30);
insert into CLEANING_TASK (tid, status, rid, sid)
values (525, 'Pending', 378, 33);
insert into CLEANING_TASK (tid, status, rid, sid)
values (526, 'Pending', 380, 34);
insert into CLEANING_TASK (tid, status, rid, sid)
values (527, 'Pending', 381, 35);
insert into CLEANING_TASK (tid, status, rid, sid)
values (528, 'Pending', 382, 36);
insert into CLEANING_TASK (tid, status, rid, sid)
values (529, 'Pending', 383, 38);
insert into CLEANING_TASK (tid, status, rid, sid)
values (530, 'Pending', 385, 39);
insert into CLEANING_TASK (tid, status, rid, sid)
values (531, 'Pending', 390, 40);
insert into CLEANING_TASK (tid, status, rid, sid)
values (532, 'Pending', 396, 41);
commit;
prompt 532 records loaded
prompt Loading INSPECTION_LOGS...
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (1, to_date('01-05-2024', 'dd-mm-yyyy'), 'Pass', 1);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (2, to_date('02-05-2024', 'dd-mm-yyyy'), 'Fail', 2);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (3, to_date('03-05-2024', 'dd-mm-yyyy'), 'Pass', 3);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (4, to_date('04-05-2024', 'dd-mm-yyyy'), 'Pass', 4);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (5, to_date('05-05-2024', 'dd-mm-yyyy'), 'Fail', 5);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (6, to_date('06-05-2024', 'dd-mm-yyyy'), 'Pass', 6);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (7, to_date('07-05-2024', 'dd-mm-yyyy'), 'Pass', 7);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (8, to_date('08-05-2024', 'dd-mm-yyyy'), 'Fail', 8);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (9, to_date('09-05-2024', 'dd-mm-yyyy'), 'Pass', 9);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (10, to_date('10-05-2024', 'dd-mm-yyyy'), 'Pass', 10);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (11, to_date('02-12-2023', 'dd-mm-yyyy'), 'Fail', 345);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (12, to_date('13-05-2023', 'dd-mm-yyyy'), 'Pass', 358);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (13, to_date('15-03-2023', 'dd-mm-yyyy'), 'Fail', 334);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (14, to_date('22-03-2024', 'dd-mm-yyyy'), 'Pass', 315);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (15, to_date('20-04-2024', 'dd-mm-yyyy'), 'Pass', 215);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (16, to_date('16-11-2023', 'dd-mm-yyyy'), 'Pass', 241);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (17, to_date('21-04-2023', 'dd-mm-yyyy'), 'Pass', 105);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (18, to_date('10-04-2024', 'dd-mm-yyyy'), 'Pass', 66);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (19, to_date('28-03-2024', 'dd-mm-yyyy'), 'Pass', 101);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (20, to_date('12-04-2024', 'dd-mm-yyyy'), 'Pass', 171);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (21, to_date('31-12-2023', 'dd-mm-yyyy'), 'Fail', 237);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (22, to_date('22-02-2024', 'dd-mm-yyyy'), 'Fail', 244);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (23, to_date('20-09-2023', 'dd-mm-yyyy'), 'Pass', 270);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (24, to_date('09-12-2023', 'dd-mm-yyyy'), 'Pass', 311);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (25, to_date('15-03-2024', 'dd-mm-yyyy'), 'Fail', 166);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (26, to_date('02-05-2023', 'dd-mm-yyyy'), 'Pass', 176);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (27, to_date('03-07-2023', 'dd-mm-yyyy'), 'Pass', 99);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (28, to_date('21-08-2023', 'dd-mm-yyyy'), 'Pass', 233);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (29, to_date('21-05-2023', 'dd-mm-yyyy'), 'Fail', 190);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (30, to_date('13-02-2024', 'dd-mm-yyyy'), 'Pass', 293);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (31, to_date('10-01-2024', 'dd-mm-yyyy'), 'Fail', 382);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (32, to_date('10-09-2023', 'dd-mm-yyyy'), 'Fail', 355);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (33, to_date('28-05-2023', 'dd-mm-yyyy'), 'Fail', 62);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (34, to_date('21-10-2023', 'dd-mm-yyyy'), 'Fail', 348);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (35, to_date('21-01-2023', 'dd-mm-yyyy'), 'Fail', 189);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (36, to_date('29-03-2024', 'dd-mm-yyyy'), 'Pass', 269);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (37, to_date('04-02-2023', 'dd-mm-yyyy'), 'Fail', 300);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (38, to_date('19-04-2024', 'dd-mm-yyyy'), 'Fail', 173);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (39, to_date('18-02-2024', 'dd-mm-yyyy'), 'Fail', 209);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (40, to_date('16-07-2023', 'dd-mm-yyyy'), 'Fail', 138);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (41, to_date('25-01-2024', 'dd-mm-yyyy'), 'Fail', 209);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (42, to_date('15-03-2024', 'dd-mm-yyyy'), 'Fail', 286);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (43, to_date('22-02-2024', 'dd-mm-yyyy'), 'Fail', 61);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (44, to_date('02-02-2024', 'dd-mm-yyyy'), 'Fail', 46);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (45, to_date('03-01-2024', 'dd-mm-yyyy'), 'Pass', 122);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (46, to_date('04-05-2023', 'dd-mm-yyyy'), 'Pass', 294);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (47, to_date('04-04-2023', 'dd-mm-yyyy'), 'Pass', 129);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (48, to_date('03-09-2023', 'dd-mm-yyyy'), 'Fail', 59);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (49, to_date('30-03-2024', 'dd-mm-yyyy'), 'Fail', 366);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (50, to_date('06-06-2023', 'dd-mm-yyyy'), 'Pass', 51);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (51, to_date('09-02-2024', 'dd-mm-yyyy'), 'Pass', 69);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (52, to_date('11-09-2023', 'dd-mm-yyyy'), 'Pass', 96);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (53, to_date('03-05-2023', 'dd-mm-yyyy'), 'Fail', 245);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (54, to_date('01-06-2023', 'dd-mm-yyyy'), 'Pass', 78);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (55, to_date('10-02-2023', 'dd-mm-yyyy'), 'Pass', 210);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (56, to_date('02-01-2023', 'dd-mm-yyyy'), 'Fail', 39);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (57, to_date('04-05-2023', 'dd-mm-yyyy'), 'Fail', 3);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (58, to_date('28-06-2023', 'dd-mm-yyyy'), 'Fail', 283);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (59, to_date('04-10-2023', 'dd-mm-yyyy'), 'Fail', 186);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (60, to_date('22-03-2023', 'dd-mm-yyyy'), 'Pass', 393);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (61, to_date('15-04-2023', 'dd-mm-yyyy'), 'Fail', 124);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (62, to_date('17-04-2023', 'dd-mm-yyyy'), 'Pass', 113);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (63, to_date('09-04-2023', 'dd-mm-yyyy'), 'Fail', 8);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (64, to_date('17-04-2024', 'dd-mm-yyyy'), 'Fail', 142);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (65, to_date('30-12-2023', 'dd-mm-yyyy'), 'Pass', 205);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (66, to_date('10-01-2023', 'dd-mm-yyyy'), 'Pass', 257);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (67, to_date('02-09-2023', 'dd-mm-yyyy'), 'Pass', 103);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (68, to_date('21-05-2023', 'dd-mm-yyyy'), 'Fail', 80);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (69, to_date('09-05-2023', 'dd-mm-yyyy'), 'Fail', 18);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (70, to_date('26-12-2023', 'dd-mm-yyyy'), 'Pass', 29);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (71, to_date('16-05-2024', 'dd-mm-yyyy'), 'Fail', 206);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (72, to_date('25-03-2024', 'dd-mm-yyyy'), 'Fail', 75);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (73, to_date('02-01-2024', 'dd-mm-yyyy'), 'Fail', 205);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (74, to_date('17-06-2023', 'dd-mm-yyyy'), 'Fail', 52);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (75, to_date('03-02-2023', 'dd-mm-yyyy'), 'Fail', 200);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (76, to_date('18-12-2023', 'dd-mm-yyyy'), 'Pass', 13);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (77, to_date('15-05-2024', 'dd-mm-yyyy'), 'Pass', 337);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (78, to_date('14-03-2023', 'dd-mm-yyyy'), 'Pass', 62);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (79, to_date('06-10-2023', 'dd-mm-yyyy'), 'Pass', 188);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (80, to_date('14-05-2024', 'dd-mm-yyyy'), 'Pass', 19);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (81, to_date('15-07-2023', 'dd-mm-yyyy'), 'Fail', 377);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (82, to_date('15-03-2023', 'dd-mm-yyyy'), 'Pass', 172);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (83, to_date('15-06-2023', 'dd-mm-yyyy'), 'Fail', 280);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (84, to_date('30-04-2023', 'dd-mm-yyyy'), 'Fail', 218);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (85, to_date('11-11-2023', 'dd-mm-yyyy'), 'Fail', 6);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (86, to_date('23-03-2024', 'dd-mm-yyyy'), 'Pass', 304);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (87, to_date('03-04-2024', 'dd-mm-yyyy'), 'Fail', 53);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (88, to_date('29-11-2023', 'dd-mm-yyyy'), 'Pass', 22);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (89, to_date('17-05-2023', 'dd-mm-yyyy'), 'Pass', 280);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (90, to_date('23-03-2023', 'dd-mm-yyyy'), 'Fail', 228);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (91, to_date('26-04-2023', 'dd-mm-yyyy'), 'Fail', 281);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (92, to_date('12-06-2023', 'dd-mm-yyyy'), 'Fail', 264);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (93, to_date('11-07-2023', 'dd-mm-yyyy'), 'Fail', 9);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (94, to_date('15-06-2023', 'dd-mm-yyyy'), 'Pass', 339);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (95, to_date('10-01-2023', 'dd-mm-yyyy'), 'Fail', 278);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (96, to_date('02-05-2024', 'dd-mm-yyyy'), 'Fail', 383);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (97, to_date('25-02-2024', 'dd-mm-yyyy'), 'Pass', 256);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (98, to_date('07-12-2023', 'dd-mm-yyyy'), 'Pass', 319);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (99, to_date('26-02-2024', 'dd-mm-yyyy'), 'Fail', 267);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (100, to_date('03-06-2023', 'dd-mm-yyyy'), 'Fail', 388);
commit;
prompt 100 records committed...
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (101, to_date('01-12-2023', 'dd-mm-yyyy'), 'Pass', 46);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (102, to_date('11-10-2023', 'dd-mm-yyyy'), 'Pass', 243);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (103, to_date('08-11-2023', 'dd-mm-yyyy'), 'Pass', 231);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (104, to_date('17-12-2023', 'dd-mm-yyyy'), 'Pass', 352);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (105, to_date('04-10-2023', 'dd-mm-yyyy'), 'Fail', 77);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (106, to_date('02-03-2023', 'dd-mm-yyyy'), 'Fail', 178);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (107, to_date('10-01-2024', 'dd-mm-yyyy'), 'Fail', 188);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (108, to_date('09-06-2023', 'dd-mm-yyyy'), 'Pass', 9);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (109, to_date('19-03-2024', 'dd-mm-yyyy'), 'Fail', 143);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (110, to_date('18-04-2023', 'dd-mm-yyyy'), 'Pass', 214);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (111, to_date('26-09-2023', 'dd-mm-yyyy'), 'Fail', 264);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (112, to_date('12-11-2023', 'dd-mm-yyyy'), 'Pass', 366);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (113, to_date('22-02-2024', 'dd-mm-yyyy'), 'Pass', 75);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (114, to_date('14-03-2024', 'dd-mm-yyyy'), 'Fail', 362);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (115, to_date('15-08-2023', 'dd-mm-yyyy'), 'Fail', 183);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (116, to_date('04-03-2024', 'dd-mm-yyyy'), 'Fail', 163);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (117, to_date('12-04-2023', 'dd-mm-yyyy'), 'Pass', 189);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (118, to_date('13-11-2023', 'dd-mm-yyyy'), 'Fail', 8);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (119, to_date('03-09-2023', 'dd-mm-yyyy'), 'Fail', 218);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (120, to_date('15-12-2023', 'dd-mm-yyyy'), 'Fail', 374);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (121, to_date('18-05-2023', 'dd-mm-yyyy'), 'Fail', 143);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (122, to_date('10-01-2024', 'dd-mm-yyyy'), 'Pass', 32);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (123, to_date('13-05-2023', 'dd-mm-yyyy'), 'Fail', 248);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (124, to_date('13-07-2023', 'dd-mm-yyyy'), 'Fail', 211);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (125, to_date('03-11-2023', 'dd-mm-yyyy'), 'Fail', 191);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (126, to_date('28-10-2023', 'dd-mm-yyyy'), 'Fail', 277);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (127, to_date('03-09-2023', 'dd-mm-yyyy'), 'Fail', 373);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (128, to_date('11-02-2023', 'dd-mm-yyyy'), 'Pass', 122);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (129, to_date('09-07-2023', 'dd-mm-yyyy'), 'Pass', 149);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (130, to_date('26-12-2023', 'dd-mm-yyyy'), 'Pass', 362);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (131, to_date('21-10-2023', 'dd-mm-yyyy'), 'Fail', 119);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (132, to_date('25-02-2024', 'dd-mm-yyyy'), 'Fail', 46);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (133, to_date('04-08-2023', 'dd-mm-yyyy'), 'Fail', 213);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (134, to_date('11-09-2023', 'dd-mm-yyyy'), 'Pass', 346);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (135, to_date('07-09-2023', 'dd-mm-yyyy'), 'Fail', 321);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (136, to_date('09-10-2023', 'dd-mm-yyyy'), 'Fail', 383);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (137, to_date('28-04-2023', 'dd-mm-yyyy'), 'Fail', 281);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (138, to_date('20-06-2023', 'dd-mm-yyyy'), 'Fail', 215);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (139, to_date('05-11-2023', 'dd-mm-yyyy'), 'Pass', 221);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (140, to_date('23-04-2024', 'dd-mm-yyyy'), 'Fail', 396);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (141, to_date('08-12-2023', 'dd-mm-yyyy'), 'Fail', 155);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (142, to_date('30-04-2023', 'dd-mm-yyyy'), 'Pass', 300);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (143, to_date('14-04-2024', 'dd-mm-yyyy'), 'Pass', 229);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (144, to_date('10-08-2023', 'dd-mm-yyyy'), 'Fail', 224);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (145, to_date('03-04-2024', 'dd-mm-yyyy'), 'Pass', 333);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (146, to_date('21-12-2023', 'dd-mm-yyyy'), 'Pass', 30);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (147, to_date('05-08-2023', 'dd-mm-yyyy'), 'Pass', 282);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (148, to_date('14-01-2023', 'dd-mm-yyyy'), 'Pass', 33);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (149, to_date('08-05-2024', 'dd-mm-yyyy'), 'Pass', 319);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (150, to_date('22-02-2024', 'dd-mm-yyyy'), 'Fail', 66);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (151, to_date('06-08-2023', 'dd-mm-yyyy'), 'Pass', 356);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (152, to_date('16-02-2023', 'dd-mm-yyyy'), 'Fail', 310);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (153, to_date('11-04-2023', 'dd-mm-yyyy'), 'Pass', 168);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (154, to_date('01-03-2024', 'dd-mm-yyyy'), 'Fail', 251);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (155, to_date('03-04-2023', 'dd-mm-yyyy'), 'Fail', 127);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (156, to_date('20-03-2023', 'dd-mm-yyyy'), 'Pass', 299);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (157, to_date('17-03-2024', 'dd-mm-yyyy'), 'Fail', 38);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (158, to_date('01-10-2023', 'dd-mm-yyyy'), 'Fail', 169);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (159, to_date('22-02-2024', 'dd-mm-yyyy'), 'Fail', 36);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (160, to_date('05-01-2023', 'dd-mm-yyyy'), 'Fail', 189);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (161, to_date('17-05-2023', 'dd-mm-yyyy'), 'Fail', 321);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (162, to_date('25-02-2024', 'dd-mm-yyyy'), 'Pass', 190);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (163, to_date('19-08-2023', 'dd-mm-yyyy'), 'Pass', 201);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (164, to_date('06-04-2023', 'dd-mm-yyyy'), 'Pass', 330);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (165, to_date('16-10-2023', 'dd-mm-yyyy'), 'Fail', 365);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (166, to_date('28-02-2024', 'dd-mm-yyyy'), 'Pass', 95);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (167, to_date('27-03-2023', 'dd-mm-yyyy'), 'Fail', 300);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (168, to_date('12-05-2023', 'dd-mm-yyyy'), 'Pass', 315);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (169, to_date('16-01-2023', 'dd-mm-yyyy'), 'Fail', 118);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (170, to_date('02-03-2023', 'dd-mm-yyyy'), 'Fail', 78);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (171, to_date('19-02-2024', 'dd-mm-yyyy'), 'Fail', 189);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (172, to_date('14-04-2024', 'dd-mm-yyyy'), 'Pass', 209);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (173, to_date('14-12-2023', 'dd-mm-yyyy'), 'Pass', 131);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (174, to_date('18-09-2023', 'dd-mm-yyyy'), 'Pass', 209);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (175, to_date('14-09-2023', 'dd-mm-yyyy'), 'Fail', 259);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (176, to_date('24-02-2024', 'dd-mm-yyyy'), 'Pass', 256);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (177, to_date('04-06-2023', 'dd-mm-yyyy'), 'Fail', 89);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (178, to_date('13-10-2023', 'dd-mm-yyyy'), 'Fail', 291);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (179, to_date('17-05-2024', 'dd-mm-yyyy'), 'Pass', 217);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (180, to_date('02-08-2023', 'dd-mm-yyyy'), 'Pass', 205);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (181, to_date('26-11-2023', 'dd-mm-yyyy'), 'Pass', 63);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (182, to_date('16-03-2024', 'dd-mm-yyyy'), 'Fail', 157);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (183, to_date('22-11-2023', 'dd-mm-yyyy'), 'Pass', 254);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (184, to_date('02-05-2024', 'dd-mm-yyyy'), 'Pass', 330);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (185, to_date('05-10-2023', 'dd-mm-yyyy'), 'Fail', 151);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (186, to_date('28-06-2023', 'dd-mm-yyyy'), 'Fail', 176);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (187, to_date('15-12-2023', 'dd-mm-yyyy'), 'Pass', 327);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (188, to_date('02-03-2024', 'dd-mm-yyyy'), 'Fail', 260);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (189, to_date('15-05-2024', 'dd-mm-yyyy'), 'Fail', 67);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (190, to_date('06-07-2023', 'dd-mm-yyyy'), 'Fail', 16);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (191, to_date('06-02-2023', 'dd-mm-yyyy'), 'Fail', 324);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (192, to_date('22-01-2024', 'dd-mm-yyyy'), 'Pass', 389);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (193, to_date('12-02-2023', 'dd-mm-yyyy'), 'Pass', 360);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (194, to_date('23-01-2024', 'dd-mm-yyyy'), 'Fail', 75);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (195, to_date('30-03-2024', 'dd-mm-yyyy'), 'Pass', 164);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (196, to_date('11-11-2023', 'dd-mm-yyyy'), 'Fail', 181);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (197, to_date('23-05-2024', 'dd-mm-yyyy'), 'Fail', 203);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (198, to_date('26-03-2024', 'dd-mm-yyyy'), 'Fail', 54);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (199, to_date('13-07-2023', 'dd-mm-yyyy'), 'Fail', 211);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (200, to_date('15-11-2023', 'dd-mm-yyyy'), 'Fail', 92);
commit;
prompt 200 records committed...
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (201, to_date('13-06-2023', 'dd-mm-yyyy'), 'Fail', 191);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (202, to_date('22-01-2023', 'dd-mm-yyyy'), 'Pass', 35);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (203, to_date('24-11-2023', 'dd-mm-yyyy'), 'Fail', 57);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (204, to_date('13-12-2023', 'dd-mm-yyyy'), 'Pass', 117);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (205, to_date('06-01-2023', 'dd-mm-yyyy'), 'Pass', 128);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (206, to_date('02-01-2023', 'dd-mm-yyyy'), 'Pass', 244);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (207, to_date('23-03-2023', 'dd-mm-yyyy'), 'Fail', 107);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (208, to_date('06-01-2024', 'dd-mm-yyyy'), 'Fail', 18);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (209, to_date('16-11-2023', 'dd-mm-yyyy'), 'Pass', 107);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (210, to_date('28-10-2023', 'dd-mm-yyyy'), 'Fail', 106);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (211, to_date('09-03-2024', 'dd-mm-yyyy'), 'Fail', 156);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (212, to_date('30-12-2023', 'dd-mm-yyyy'), 'Fail', 294);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (213, to_date('21-12-2023', 'dd-mm-yyyy'), 'Fail', 95);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (214, to_date('06-09-2023', 'dd-mm-yyyy'), 'Fail', 19);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (215, to_date('21-03-2024', 'dd-mm-yyyy'), 'Fail', 50);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (216, to_date('03-06-2023', 'dd-mm-yyyy'), 'Fail', 58);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (217, to_date('13-03-2024', 'dd-mm-yyyy'), 'Pass', 14);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (218, to_date('02-01-2023', 'dd-mm-yyyy'), 'Pass', 235);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (219, to_date('19-10-2023', 'dd-mm-yyyy'), 'Fail', 263);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (220, to_date('18-05-2024', 'dd-mm-yyyy'), 'Fail', 383);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (221, to_date('18-04-2023', 'dd-mm-yyyy'), 'Pass', 124);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (222, to_date('12-02-2024', 'dd-mm-yyyy'), 'Fail', 118);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (223, to_date('04-09-2023', 'dd-mm-yyyy'), 'Pass', 10);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (224, to_date('21-10-2023', 'dd-mm-yyyy'), 'Fail', 182);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (225, to_date('23-03-2023', 'dd-mm-yyyy'), 'Pass', 306);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (226, to_date('04-01-2023', 'dd-mm-yyyy'), 'Pass', 293);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (227, to_date('29-08-2023', 'dd-mm-yyyy'), 'Pass', 81);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (228, to_date('13-06-2023', 'dd-mm-yyyy'), 'Pass', 187);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (229, to_date('12-02-2023', 'dd-mm-yyyy'), 'Fail', 38);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (230, to_date('11-04-2023', 'dd-mm-yyyy'), 'Pass', 88);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (231, to_date('23-12-2023', 'dd-mm-yyyy'), 'Pass', 244);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (232, to_date('10-05-2024', 'dd-mm-yyyy'), 'Pass', 325);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (233, to_date('27-07-2023', 'dd-mm-yyyy'), 'Pass', 205);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (234, to_date('02-04-2024', 'dd-mm-yyyy'), 'Pass', 284);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (235, to_date('20-02-2024', 'dd-mm-yyyy'), 'Pass', 12);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (236, to_date('17-04-2024', 'dd-mm-yyyy'), 'Fail', 26);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (237, to_date('01-07-2023', 'dd-mm-yyyy'), 'Pass', 148);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (238, to_date('18-07-2023', 'dd-mm-yyyy'), 'Fail', 181);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (239, to_date('26-04-2023', 'dd-mm-yyyy'), 'Pass', 308);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (240, to_date('27-10-2023', 'dd-mm-yyyy'), 'Fail', 69);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (241, to_date('29-01-2023', 'dd-mm-yyyy'), 'Pass', 230);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (242, to_date('14-04-2024', 'dd-mm-yyyy'), 'Pass', 334);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (243, to_date('15-01-2023', 'dd-mm-yyyy'), 'Fail', 325);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (244, to_date('04-02-2023', 'dd-mm-yyyy'), 'Pass', 205);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (245, to_date('20-06-2023', 'dd-mm-yyyy'), 'Pass', 382);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (246, to_date('16-05-2024', 'dd-mm-yyyy'), 'Fail', 64);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (247, to_date('09-04-2023', 'dd-mm-yyyy'), 'Fail', 34);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (248, to_date('08-07-2023', 'dd-mm-yyyy'), 'Fail', 225);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (249, to_date('20-01-2023', 'dd-mm-yyyy'), 'Pass', 44);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (250, to_date('10-02-2024', 'dd-mm-yyyy'), 'Pass', 256);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (251, to_date('09-01-2024', 'dd-mm-yyyy'), 'Fail', 41);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (252, to_date('08-09-2023', 'dd-mm-yyyy'), 'Pass', 337);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (253, to_date('30-10-2023', 'dd-mm-yyyy'), 'Pass', 30);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (254, to_date('25-12-2023', 'dd-mm-yyyy'), 'Fail', 73);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (255, to_date('21-04-2024', 'dd-mm-yyyy'), 'Pass', 43);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (256, to_date('15-08-2023', 'dd-mm-yyyy'), 'Fail', 148);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (257, to_date('29-12-2023', 'dd-mm-yyyy'), 'Pass', 131);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (258, to_date('17-03-2024', 'dd-mm-yyyy'), 'Fail', 353);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (259, to_date('04-01-2023', 'dd-mm-yyyy'), 'Fail', 100);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (260, to_date('03-01-2023', 'dd-mm-yyyy'), 'Pass', 373);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (261, to_date('21-02-2023', 'dd-mm-yyyy'), 'Fail', 294);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (262, to_date('08-09-2023', 'dd-mm-yyyy'), 'Pass', 238);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (263, to_date('19-11-2023', 'dd-mm-yyyy'), 'Fail', 398);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (264, to_date('28-02-2023', 'dd-mm-yyyy'), 'Pass', 322);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (265, to_date('24-08-2023', 'dd-mm-yyyy'), 'Pass', 222);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (266, to_date('01-04-2023', 'dd-mm-yyyy'), 'Fail', 176);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (267, to_date('23-04-2024', 'dd-mm-yyyy'), 'Fail', 74);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (268, to_date('07-01-2023', 'dd-mm-yyyy'), 'Pass', 69);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (269, to_date('10-04-2023', 'dd-mm-yyyy'), 'Fail', 293);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (270, to_date('26-01-2024', 'dd-mm-yyyy'), 'Pass', 291);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (271, to_date('21-06-2023', 'dd-mm-yyyy'), 'Fail', 268);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (272, to_date('13-12-2023', 'dd-mm-yyyy'), 'Pass', 278);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (273, to_date('27-02-2024', 'dd-mm-yyyy'), 'Pass', 33);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (274, to_date('05-09-2023', 'dd-mm-yyyy'), 'Pass', 242);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (275, to_date('10-05-2023', 'dd-mm-yyyy'), 'Fail', 381);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (276, to_date('05-09-2023', 'dd-mm-yyyy'), 'Fail', 333);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (277, to_date('12-02-2023', 'dd-mm-yyyy'), 'Fail', 241);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (278, to_date('12-03-2024', 'dd-mm-yyyy'), 'Pass', 209);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (279, to_date('31-12-2023', 'dd-mm-yyyy'), 'Pass', 129);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (280, to_date('24-01-2024', 'dd-mm-yyyy'), 'Pass', 5);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (281, to_date('24-06-2023', 'dd-mm-yyyy'), 'Pass', 375);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (282, to_date('17-03-2024', 'dd-mm-yyyy'), 'Fail', 228);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (283, to_date('07-04-2024', 'dd-mm-yyyy'), 'Pass', 77);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (284, to_date('11-08-2023', 'dd-mm-yyyy'), 'Fail', 349);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (285, to_date('16-04-2024', 'dd-mm-yyyy'), 'Pass', 48);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (286, to_date('10-10-2023', 'dd-mm-yyyy'), 'Pass', 112);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (287, to_date('25-05-2023', 'dd-mm-yyyy'), 'Pass', 155);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (288, to_date('29-04-2023', 'dd-mm-yyyy'), 'Pass', 145);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (289, to_date('08-07-2023', 'dd-mm-yyyy'), 'Fail', 24);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (290, to_date('17-11-2023', 'dd-mm-yyyy'), 'Fail', 190);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (291, to_date('12-08-2023', 'dd-mm-yyyy'), 'Fail', 331);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (292, to_date('07-03-2023', 'dd-mm-yyyy'), 'Fail', 216);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (293, to_date('06-04-2023', 'dd-mm-yyyy'), 'Fail', 112);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (294, to_date('25-04-2023', 'dd-mm-yyyy'), 'Pass', 229);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (295, to_date('28-08-2023', 'dd-mm-yyyy'), 'Fail', 372);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (296, to_date('20-02-2024', 'dd-mm-yyyy'), 'Fail', 346);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (297, to_date('16-10-2023', 'dd-mm-yyyy'), 'Fail', 88);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (298, to_date('02-02-2023', 'dd-mm-yyyy'), 'Pass', 291);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (299, to_date('17-12-2023', 'dd-mm-yyyy'), 'Pass', 279);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (300, to_date('07-05-2024', 'dd-mm-yyyy'), 'Fail', 52);
commit;
prompt 300 records committed...
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (301, to_date('06-09-2023', 'dd-mm-yyyy'), 'Fail', 378);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (302, to_date('05-03-2023', 'dd-mm-yyyy'), 'Fail', 40);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (303, to_date('26-01-2023', 'dd-mm-yyyy'), 'Fail', 387);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (304, to_date('14-03-2024', 'dd-mm-yyyy'), 'Pass', 395);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (305, to_date('12-02-2023', 'dd-mm-yyyy'), 'Pass', 214);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (306, to_date('20-03-2024', 'dd-mm-yyyy'), 'Pass', 121);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (307, to_date('01-04-2024', 'dd-mm-yyyy'), 'Fail', 23);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (308, to_date('10-04-2024', 'dd-mm-yyyy'), 'Fail', 58);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (309, to_date('13-07-2023', 'dd-mm-yyyy'), 'Pass', 114);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (310, to_date('12-04-2023', 'dd-mm-yyyy'), 'Pass', 248);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (311, to_date('16-09-2023', 'dd-mm-yyyy'), 'Pass', 383);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (312, to_date('14-12-2023', 'dd-mm-yyyy'), 'Pass', 87);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (313, to_date('29-08-2023', 'dd-mm-yyyy'), 'Fail', 336);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (314, to_date('20-02-2023', 'dd-mm-yyyy'), 'Fail', 259);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (315, to_date('16-03-2023', 'dd-mm-yyyy'), 'Pass', 143);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (316, to_date('24-01-2023', 'dd-mm-yyyy'), 'Pass', 350);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (317, to_date('19-01-2024', 'dd-mm-yyyy'), 'Pass', 257);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (318, to_date('16-04-2023', 'dd-mm-yyyy'), 'Fail', 266);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (319, to_date('03-12-2023', 'dd-mm-yyyy'), 'Fail', 198);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (320, to_date('23-03-2023', 'dd-mm-yyyy'), 'Pass', 195);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (321, to_date('10-09-2023', 'dd-mm-yyyy'), 'Fail', 362);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (322, to_date('14-08-2023', 'dd-mm-yyyy'), 'Pass', 163);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (323, to_date('21-02-2023', 'dd-mm-yyyy'), 'Pass', 89);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (324, to_date('30-01-2023', 'dd-mm-yyyy'), 'Fail', 101);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (325, to_date('13-12-2023', 'dd-mm-yyyy'), 'Fail', 388);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (326, to_date('03-08-2023', 'dd-mm-yyyy'), 'Pass', 333);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (327, to_date('17-02-2024', 'dd-mm-yyyy'), 'Fail', 43);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (328, to_date('04-09-2023', 'dd-mm-yyyy'), 'Fail', 336);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (329, to_date('22-04-2024', 'dd-mm-yyyy'), 'Pass', 359);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (330, to_date('26-01-2023', 'dd-mm-yyyy'), 'Fail', 120);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (331, to_date('26-02-2023', 'dd-mm-yyyy'), 'Fail', 149);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (332, to_date('01-09-2023', 'dd-mm-yyyy'), 'Pass', 131);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (333, to_date('05-08-2023', 'dd-mm-yyyy'), 'Fail', 117);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (334, to_date('28-04-2023', 'dd-mm-yyyy'), 'Pass', 214);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (335, to_date('12-03-2023', 'dd-mm-yyyy'), 'Fail', 262);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (336, to_date('16-02-2024', 'dd-mm-yyyy'), 'Pass', 64);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (337, to_date('15-01-2024', 'dd-mm-yyyy'), 'Pass', 99);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (338, to_date('09-02-2023', 'dd-mm-yyyy'), 'Pass', 132);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (339, to_date('01-03-2023', 'dd-mm-yyyy'), 'Fail', 270);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (340, to_date('06-09-2023', 'dd-mm-yyyy'), 'Fail', 91);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (341, to_date('28-07-2023', 'dd-mm-yyyy'), 'Fail', 113);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (342, to_date('17-04-2023', 'dd-mm-yyyy'), 'Fail', 324);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (343, to_date('31-08-2023', 'dd-mm-yyyy'), 'Pass', 390);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (344, to_date('22-05-2023', 'dd-mm-yyyy'), 'Pass', 79);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (345, to_date('13-08-2023', 'dd-mm-yyyy'), 'Pass', 180);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (346, to_date('20-06-2023', 'dd-mm-yyyy'), 'Fail', 27);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (347, to_date('30-01-2023', 'dd-mm-yyyy'), 'Pass', 99);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (348, to_date('26-03-2024', 'dd-mm-yyyy'), 'Pass', 389);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (349, to_date('25-09-2023', 'dd-mm-yyyy'), 'Pass', 247);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (350, to_date('06-05-2023', 'dd-mm-yyyy'), 'Fail', 24);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (351, to_date('25-02-2024', 'dd-mm-yyyy'), 'Pass', 146);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (352, to_date('02-07-2023', 'dd-mm-yyyy'), 'Fail', 32);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (353, to_date('13-04-2024', 'dd-mm-yyyy'), 'Pass', 167);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (354, to_date('17-01-2024', 'dd-mm-yyyy'), 'Pass', 179);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (355, to_date('19-08-2023', 'dd-mm-yyyy'), 'Pass', 308);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (356, to_date('23-04-2024', 'dd-mm-yyyy'), 'Pass', 142);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (357, to_date('13-09-2023', 'dd-mm-yyyy'), 'Fail', 230);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (358, to_date('13-03-2024', 'dd-mm-yyyy'), 'Fail', 289);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (359, to_date('24-02-2024', 'dd-mm-yyyy'), 'Pass', 119);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (360, to_date('17-11-2023', 'dd-mm-yyyy'), 'Fail', 160);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (361, to_date('02-01-2023', 'dd-mm-yyyy'), 'Pass', 183);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (362, to_date('14-05-2024', 'dd-mm-yyyy'), 'Fail', 271);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (363, to_date('12-07-2023', 'dd-mm-yyyy'), 'Fail', 66);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (364, to_date('15-07-2023', 'dd-mm-yyyy'), 'Pass', 116);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (365, to_date('30-01-2023', 'dd-mm-yyyy'), 'Pass', 97);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (366, to_date('26-03-2024', 'dd-mm-yyyy'), 'Pass', 57);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (367, to_date('29-04-2023', 'dd-mm-yyyy'), 'Fail', 132);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (368, to_date('11-08-2023', 'dd-mm-yyyy'), 'Fail', 384);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (369, to_date('03-05-2023', 'dd-mm-yyyy'), 'Fail', 95);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (370, to_date('06-06-2023', 'dd-mm-yyyy'), 'Pass', 301);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (371, to_date('23-10-2023', 'dd-mm-yyyy'), 'Pass', 343);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (372, to_date('24-10-2023', 'dd-mm-yyyy'), 'Pass', 371);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (373, to_date('20-05-2023', 'dd-mm-yyyy'), 'Pass', 126);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (374, to_date('28-05-2023', 'dd-mm-yyyy'), 'Fail', 393);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (375, to_date('05-03-2024', 'dd-mm-yyyy'), 'Fail', 359);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (376, to_date('18-04-2023', 'dd-mm-yyyy'), 'Fail', 113);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (377, to_date('28-10-2023', 'dd-mm-yyyy'), 'Fail', 380);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (378, to_date('30-11-2023', 'dd-mm-yyyy'), 'Fail', 150);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (379, to_date('23-02-2023', 'dd-mm-yyyy'), 'Pass', 18);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (380, to_date('03-11-2023', 'dd-mm-yyyy'), 'Pass', 2);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (381, to_date('27-10-2023', 'dd-mm-yyyy'), 'Fail', 261);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (382, to_date('11-08-2023', 'dd-mm-yyyy'), 'Fail', 97);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (383, to_date('20-04-2023', 'dd-mm-yyyy'), 'Pass', 193);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (384, to_date('10-05-2024', 'dd-mm-yyyy'), 'Fail', 268);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (385, to_date('26-03-2023', 'dd-mm-yyyy'), 'Fail', 332);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (386, to_date('15-05-2023', 'dd-mm-yyyy'), 'Fail', 68);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (387, to_date('01-04-2023', 'dd-mm-yyyy'), 'Fail', 102);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (388, to_date('13-06-2023', 'dd-mm-yyyy'), 'Pass', 365);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (389, to_date('24-04-2023', 'dd-mm-yyyy'), 'Fail', 325);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (390, to_date('07-08-2023', 'dd-mm-yyyy'), 'Pass', 385);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (391, to_date('13-10-2023', 'dd-mm-yyyy'), 'Pass', 281);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (392, to_date('12-03-2023', 'dd-mm-yyyy'), 'Fail', 3);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (393, to_date('20-08-2023', 'dd-mm-yyyy'), 'Pass', 68);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (394, to_date('30-01-2024', 'dd-mm-yyyy'), 'Pass', 198);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (395, to_date('17-10-2023', 'dd-mm-yyyy'), 'Pass', 159);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (396, to_date('24-03-2024', 'dd-mm-yyyy'), 'Fail', 207);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (397, to_date('27-03-2024', 'dd-mm-yyyy'), 'Pass', 197);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (398, to_date('09-07-2023', 'dd-mm-yyyy'), 'Pass', 354);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (399, to_date('18-12-2023', 'dd-mm-yyyy'), 'Fail', 327);
insert into INSPECTION_LOGS (lid, inspection_date, inspection_result, rid)
values (400, to_date('03-10-2023', 'dd-mm-yyyy'), 'Fail', 351);
commit;
prompt 400 records loaded
prompt Loading MAINTENANCE_REQUEST...
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (1, 'Leaky faucet', to_date('01-05-2024', 'dd-mm-yyyy'), 1, 1);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (2, 'Broken window', to_date('02-05-2024', 'dd-mm-yyyy'), 2, 2);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (3, 'AC not working', to_date('03-05-2024', 'dd-mm-yyyy'), 3, 3);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (4, 'Heater issue', to_date('04-05-2024', 'dd-mm-yyyy'), 4, 4);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (5, 'Clogged drain', to_date('05-05-2024', 'dd-mm-yyyy'), 5, 5);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (6, 'Electrical problem', to_date('06-05-2024', 'dd-mm-yyyy'), 6, 6);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (7, 'Broken door lock', to_date('07-05-2024', 'dd-mm-yyyy'), 7, 7);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (8, 'Leaky roof', to_date('08-05-2024', 'dd-mm-yyyy'), 8, 8);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (9, 'Faulty wiring', to_date('09-05-2024', 'dd-mm-yyyy'), 9, 9);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (10, 'Plumbing issue', to_date('10-05-2024', 'dd-mm-yyyy'), 10, 10);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (11, 'Leaking pipe', to_date('08-09-2023', 'dd-mm-yyyy'), 70, 35);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (12, 'Freezing refrigerator', to_date('16-05-2023', 'dd-mm-yyyy'), 149, 174);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (13, 'Flickering lights', to_date('06-04-2024', 'dd-mm-yyyy'), 229, 399);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (14, 'Dripping shower', to_date('22-02-2023', 'dd-mm-yyyy'), 155, 39);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (15, 'Broken door', to_date('24-10-2023', 'dd-mm-yyyy'), 358, 16);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (16, 'Water damage', to_date('15-07-2023', 'dd-mm-yyyy'), 356, 215);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (17, 'Soggy drywall', to_date('08-05-2023', 'dd-mm-yyyy'), 88, 52);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (18, 'Plumbing issue', to_date('26-07-2023', 'dd-mm-yyyy'), 284, 271);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (19, 'Cabinet door broken', to_date('14-02-2023', 'dd-mm-yyyy'), 241, 158);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (20, 'Pest infestation', to_date('03-11-2023', 'dd-mm-yyyy'), 208, 313);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (21, 'Window won''t close', to_date('23-01-2023', 'dd-mm-yyyy'), 113, 333);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (22, 'Cabinet door broken', to_date('13-03-2023', 'dd-mm-yyyy'), 76, 341);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (23, 'Cracked wall', to_date('19-02-2023', 'dd-mm-yyyy'), 394, 4);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (25, 'Broken drawer', to_date('04-06-2023', 'dd-mm-yyyy'), 119, 12);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (26, 'Hissing radiator', to_date('06-03-2024', 'dd-mm-yyyy'), 324, 55);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (27, 'Leaky faucet', to_date('19-02-2024', 'dd-mm-yyyy'), 277, 9);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (28, 'Flickering screen', to_date('25-01-2023', 'dd-mm-yyyy'), 270, 203);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (29, 'Graffiti', to_date('25-01-2023', 'dd-mm-yyyy'), 48, 238);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (30, 'No hot water', to_date('05-10-2023', 'dd-mm-yyyy'), 250, 334);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (31, 'Heater issue', to_date('12-12-2023', 'dd-mm-yyyy'), 91, 138);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (32, 'Cracked wall', to_date('22-01-2023', 'dd-mm-yyyy'), 400, 203);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (33, 'Leaky roof', to_date('04-12-2023', 'dd-mm-yyyy'), 105, 8);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (34, 'Freezing refrigerator', to_date('26-07-2023', 'dd-mm-yyyy'), 321, 213);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (35, 'Broken switch', to_date('20-08-2023', 'dd-mm-yyyy'), 225, 233);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (36, 'Toilet clog', to_date('24-10-2023', 'dd-mm-yyyy'), 115, 266);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (37, 'Leaking pipe', to_date('05-05-2024', 'dd-mm-yyyy'), 256, 371);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (38, 'Leaky roof', to_date('18-11-2023', 'dd-mm-yyyy'), 202, 312);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (39, 'Cabinet door broken', to_date('24-03-2024', 'dd-mm-yyyy'), 229, 97);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (40, 'Broken switch', to_date('17-05-2024', 'dd-mm-yyyy'), 286, 242);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (41, 'Jammed lock', to_date('06-11-2023', 'dd-mm-yyyy'), 319, 7);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (42, 'Squeaky floor', to_date('19-07-2023', 'dd-mm-yyyy'), 47, 213);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (43, 'Loose tile', to_date('26-02-2024', 'dd-mm-yyyy'), 43, 333);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (44, 'Graffiti', to_date('28-01-2023', 'dd-mm-yyyy'), 119, 319);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (45, 'Air conditioning leak', to_date('18-04-2023', 'dd-mm-yyyy'), 308, 53);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (46, 'Cracked sidewalk', to_date('25-11-2023', 'dd-mm-yyyy'), 182, 164);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (47, 'Rattling pipes', to_date('10-05-2023', 'dd-mm-yyyy'), 39, 92);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (48, 'Loose tile', to_date('10-09-2023', 'dd-mm-yyyy'), 223, 269);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (49, 'Toilet clog', to_date('08-01-2024', 'dd-mm-yyyy'), 172, 115);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (50, 'Jammed garbage disposal', to_date('05-08-2023', 'dd-mm-yyyy'), 202, 392);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (51, 'Loose tile', to_date('07-01-2024', 'dd-mm-yyyy'), 182, 384);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (52, 'Ceiling leak', to_date('24-03-2024', 'dd-mm-yyyy'), 158, 397);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (53, 'Heater issue', to_date('18-01-2023', 'dd-mm-yyyy'), 355, 291);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (54, 'Soggy drywall', to_date('14-11-2023', 'dd-mm-yyyy'), 115, 65);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (55, 'Broken window', to_date('30-05-2023', 'dd-mm-yyyy'), 129, 79);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (56, 'Rodent sighting', to_date('14-06-2023', 'dd-mm-yyyy'), 238, 174);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (58, 'Broken thermostat', to_date('10-01-2023', 'dd-mm-yyyy'), 67, 19);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (59, 'Mold growth', to_date('05-10-2023', 'dd-mm-yyyy'), 9, 184);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (60, 'Cracked wall', to_date('06-09-2023', 'dd-mm-yyyy'), 58, 42);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (61, 'Plumbing issue', to_date('14-07-2023', 'dd-mm-yyyy'), 58, 37);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (62, 'No hot water', to_date('24-11-2023', 'dd-mm-yyyy'), 212, 210);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (63, 'Broken drawer', to_date('18-06-2023', 'dd-mm-yyyy'), 15, 314);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (64, 'Clogged drain', to_date('18-04-2023', 'dd-mm-yyyy'), 371, 370);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (65, 'Foul smell', to_date('27-03-2024', 'dd-mm-yyyy'), 56, 204);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (66, 'Water damage', to_date('27-09-2023', 'dd-mm-yyyy'), 326, 381);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (67, 'Moldy odor', to_date('18-12-2023', 'dd-mm-yyyy'), 128, 271);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (68, 'Graffiti', to_date('23-05-2023', 'dd-mm-yyyy'), 268, 110);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (69, 'Soggy drywall', to_date('22-12-2023', 'dd-mm-yyyy'), 294, 153);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (70, 'Rusty faucet', to_date('29-06-2023', 'dd-mm-yyyy'), 120, 142);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (71, 'Air conditioning leak', to_date('20-02-2023', 'dd-mm-yyyy'), 10, 261);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (72, 'Cracked wall', to_date('10-10-2023', 'dd-mm-yyyy'), 190, 257);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (73, 'Ceiling leak', to_date('21-04-2024', 'dd-mm-yyyy'), 200, 35);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (74, 'Mold growth', to_date('21-06-2023', 'dd-mm-yyyy'), 116, 7);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (75, 'Broken switch', to_date('09-02-2023', 'dd-mm-yyyy'), 117, 365);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (76, 'Ceiling leak', to_date('01-09-2023', 'dd-mm-yyyy'), 75, 352);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (77, 'Damaged flooring', to_date('01-04-2024', 'dd-mm-yyyy'), 209, 378);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (78, 'Faulty wiring', to_date('10-11-2023', 'dd-mm-yyyy'), 102, 231);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (79, 'Loose tile', to_date('30-06-2023', 'dd-mm-yyyy'), 48, 166);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (80, 'Toilet clog', to_date('10-09-2023', 'dd-mm-yyyy'), 192, 317);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (81, 'Flickering lights', to_date('06-04-2024', 'dd-mm-yyyy'), 71, 342);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (82, 'Leaky faucet', to_date('04-01-2023', 'dd-mm-yyyy'), 36, 242);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (83, 'Graffiti', to_date('28-02-2023', 'dd-mm-yyyy'), 209, 397);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (84, 'Broken lock', to_date('12-04-2024', 'dd-mm-yyyy'), 205, 292);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (85, 'Toilet clog', to_date('17-04-2024', 'dd-mm-yyyy'), 360, 142);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (86, 'Squeaky floor', to_date('09-01-2024', 'dd-mm-yyyy'), 353, 297);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (87, 'Clogged drain', to_date('17-12-2023', 'dd-mm-yyyy'), 134, 253);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (88, 'Flickering screen', to_date('25-10-2023', 'dd-mm-yyyy'), 69, 227);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (89, 'Hissing radiator', to_date('17-03-2023', 'dd-mm-yyyy'), 86, 212);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (90, 'Soggy drywall', to_date('26-09-2023', 'dd-mm-yyyy'), 57, 24);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (91, 'AC not working', to_date('16-04-2024', 'dd-mm-yyyy'), 45, 366);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (92, 'Broken door', to_date('06-02-2023', 'dd-mm-yyyy'), 387, 42);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (93, 'Freezing refrigerator', to_date('19-03-2023', 'dd-mm-yyyy'), 74, 298);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (94, 'Broken thermostat', to_date('01-08-2023', 'dd-mm-yyyy'), 186, 230);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (95, 'Rattling pipes', to_date('01-04-2023', 'dd-mm-yyyy'), 99, 348);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (96, 'Rusty faucet', to_date('04-04-2023', 'dd-mm-yyyy'), 392, 313);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (97, 'Rusty faucet', to_date('05-05-2024', 'dd-mm-yyyy'), 321, 199);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (98, 'Broken door', to_date('20-05-2024', 'dd-mm-yyyy'), 152, 282);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (99, 'Plumbing issue', to_date('14-11-2023', 'dd-mm-yyyy'), 125, 360);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (100, 'Flickering screen', to_date('24-03-2023', 'dd-mm-yyyy'), 159, 42);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (101, 'Broken window', to_date('27-12-2023', 'dd-mm-yyyy'), 166, 120);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (102, 'AC not working', to_date('23-07-2023', 'dd-mm-yyyy'), 48, 212);
commit;
prompt 100 records committed...
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (103, 'Broken drawer', to_date('28-12-2023', 'dd-mm-yyyy'), 322, 365);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (104, 'Broken thermostat', to_date('20-11-2023', 'dd-mm-yyyy'), 251, 327);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (105, 'Water damage', to_date('06-03-2024', 'dd-mm-yyyy'), 50, 116);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (106, 'Window won''t close', to_date('20-04-2023', 'dd-mm-yyyy'), 244, 369);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (107, 'Faulty wiring', to_date('04-05-2023', 'dd-mm-yyyy'), 384, 106);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (108, 'Pest infestation', to_date('17-03-2024', 'dd-mm-yyyy'), 301, 357);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (109, 'Loose tile', to_date('19-04-2023', 'dd-mm-yyyy'), 266, 246);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (110, 'Stained carpet', to_date('13-07-2023', 'dd-mm-yyyy'), 199, 52);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (111, 'AC not working', to_date('02-03-2023', 'dd-mm-yyyy'), 191, 373);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (112, 'Broken drawer', to_date('06-12-2023', 'dd-mm-yyyy'), 341, 14);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (113, 'Stuck window', to_date('23-11-2023', 'dd-mm-yyyy'), 230, 226);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (114, 'Leaky faucet', to_date('04-09-2023', 'dd-mm-yyyy'), 67, 323);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (115, 'Soggy drywall', to_date('23-09-2023', 'dd-mm-yyyy'), 127, 178);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (116, 'No hot water', to_date('28-05-2023', 'dd-mm-yyyy'), 14, 140);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (117, 'Clogged drain', to_date('07-04-2024', 'dd-mm-yyyy'), 27, 191);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (118, 'Water damage', to_date('28-11-2023', 'dd-mm-yyyy'), 175, 110);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (119, 'Flickering lights', to_date('09-12-2023', 'dd-mm-yyyy'), 247, 104);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (120, 'Rusty faucet', to_date('09-12-2023', 'dd-mm-yyyy'), 268, 100);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (121, 'Hissing radiator', to_date('23-11-2023', 'dd-mm-yyyy'), 35, 15);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (122, 'Soggy drywall', to_date('15-02-2024', 'dd-mm-yyyy'), 227, 58);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (123, 'Graffiti', to_date('19-03-2023', 'dd-mm-yyyy'), 211, 257);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (124, 'Soggy drywall', to_date('08-04-2023', 'dd-mm-yyyy'), 141, 28);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (125, 'Flickering screen', to_date('23-02-2023', 'dd-mm-yyyy'), 373, 374);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (126, 'Broken thermostat', to_date('14-12-2023', 'dd-mm-yyyy'), 25, 362);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (127, 'Flickering lights', to_date('21-02-2023', 'dd-mm-yyyy'), 76, 232);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (128, 'Broken window', to_date('17-11-2023', 'dd-mm-yyyy'), 257, 12);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (129, 'Hissing radiator', to_date('18-06-2023', 'dd-mm-yyyy'), 164, 104);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (130, 'Broken drawer', to_date('09-02-2023', 'dd-mm-yyyy'), 39, 120);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (131, 'Faulty wiring', to_date('15-09-2023', 'dd-mm-yyyy'), 398, 68);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (132, 'Stuck window', to_date('08-03-2024', 'dd-mm-yyyy'), 135, 206);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (133, 'Rodent sighting', to_date('20-03-2024', 'dd-mm-yyyy'), 190, 89);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (134, 'Leaking pipe', to_date('27-07-2023', 'dd-mm-yyyy'), 124, 367);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (135, 'Mold growth', to_date('15-01-2024', 'dd-mm-yyyy'), 217, 43);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (136, 'Broken switch', to_date('20-01-2023', 'dd-mm-yyyy'), 2, 29);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (137, 'Toilet clog', to_date('01-12-2023', 'dd-mm-yyyy'), 204, 116);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (138, 'Damaged fence', to_date('21-03-2024', 'dd-mm-yyyy'), 181, 121);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (139, 'Cracked sidewalk', to_date('24-04-2024', 'dd-mm-yyyy'), 283, 123);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (140, 'Damaged fence', to_date('07-01-2024', 'dd-mm-yyyy'), 271, 316);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (141, 'Flickering lights', to_date('02-09-2023', 'dd-mm-yyyy'), 87, 330);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (142, 'Leaky roof', to_date('02-02-2024', 'dd-mm-yyyy'), 9, 117);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (143, 'Loose tile', to_date('05-02-2024', 'dd-mm-yyyy'), 86, 159);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (144, 'Graffiti', to_date('03-10-2023', 'dd-mm-yyyy'), 157, 102);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (145, 'Squeaky floor', to_date('14-02-2024', 'dd-mm-yyyy'), 152, 109);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (146, 'AC not working', to_date('01-07-2023', 'dd-mm-yyyy'), 196, 397);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (147, 'Damaged fence', to_date('27-06-2023', 'dd-mm-yyyy'), 323, 10);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (148, 'Toilet clog', to_date('07-03-2023', 'dd-mm-yyyy'), 155, 223);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (149, 'Freezing refrigerator', to_date('08-04-2024', 'dd-mm-yyyy'), 350, 196);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (150, 'Smashed mirror', to_date('07-01-2023', 'dd-mm-yyyy'), 314, 274);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (151, 'Broken window', to_date('29-12-2023', 'dd-mm-yyyy'), 45, 84);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (152, 'Leaky faucet', to_date('26-08-2023', 'dd-mm-yyyy'), 236, 71);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (153, 'Foul smell', to_date('04-03-2023', 'dd-mm-yyyy'), 96, 50);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (155, 'Dripping shower', to_date('26-11-2023', 'dd-mm-yyyy'), 73, 13);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (156, 'Water damage', to_date('06-02-2023', 'dd-mm-yyyy'), 275, 365);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (157, 'Plumbing issue', to_date('06-02-2023', 'dd-mm-yyyy'), 143, 159);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (158, 'Window won''t close', to_date('10-01-2024', 'dd-mm-yyyy'), 336, 373);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (159, 'Soggy drywall', to_date('30-11-2023', 'dd-mm-yyyy'), 328, 25);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (160, 'Air conditioning leak', to_date('26-03-2023', 'dd-mm-yyyy'), 349, 261);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (161, 'Broken switch', to_date('28-04-2024', 'dd-mm-yyyy'), 227, 189);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (162, 'Damaged fence', to_date('05-02-2023', 'dd-mm-yyyy'), 35, 69);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (163, 'Damaged fence', to_date('23-05-2023', 'dd-mm-yyyy'), 57, 394);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (164, 'Smashed mirror', to_date('10-04-2024', 'dd-mm-yyyy'), 57, 74);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (165, 'Foul smell', to_date('01-03-2023', 'dd-mm-yyyy'), 11, 340);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (166, 'Stained carpet', to_date('09-01-2024', 'dd-mm-yyyy'), 135, 339);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (167, 'Cracked wall', to_date('26-08-2023', 'dd-mm-yyyy'), 154, 182);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (168, 'Broken switch', to_date('20-01-2023', 'dd-mm-yyyy'), 311, 184);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (169, 'Cracked sidewalk', to_date('23-02-2024', 'dd-mm-yyyy'), 253, 219);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (170, 'Broken drawer', to_date('23-04-2023', 'dd-mm-yyyy'), 396, 253);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (171, 'Rusty faucet', to_date('15-07-2023', 'dd-mm-yyyy'), 113, 394);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (172, 'Damaged countertop', to_date('28-08-2023', 'dd-mm-yyyy'), 193, 243);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (173, 'Leaky roof', to_date('17-05-2024', 'dd-mm-yyyy'), 354, 286);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (175, 'Soggy drywall', to_date('28-03-2024', 'dd-mm-yyyy'), 197, 189);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (176, 'Dripping shower', to_date('31-10-2023', 'dd-mm-yyyy'), 359, 54);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (177, 'Flickering lights', to_date('02-07-2023', 'dd-mm-yyyy'), 52, 204);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (178, 'Freezing refrigerator', to_date('13-08-2023', 'dd-mm-yyyy'), 94, 41);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (179, 'Clogged drain', to_date('25-01-2024', 'dd-mm-yyyy'), 271, 267);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (180, 'Broken thermostat', to_date('01-04-2023', 'dd-mm-yyyy'), 349, 365);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (181, 'Foul taste in water', to_date('15-01-2023', 'dd-mm-yyyy'), 72, 108);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (182, 'Flickering lights', to_date('27-04-2024', 'dd-mm-yyyy'), 192, 100);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (183, 'AC not working', to_date('20-05-2023', 'dd-mm-yyyy'), 120, 42);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (184, 'Cracked sidewalk', to_date('10-11-2023', 'dd-mm-yyyy'), 13, 370);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (185, 'Faulty wiring', to_date('22-06-2023', 'dd-mm-yyyy'), 204, 143);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (186, 'Mold growth', to_date('11-03-2024', 'dd-mm-yyyy'), 106, 267);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (187, 'Damaged fence', to_date('20-02-2023', 'dd-mm-yyyy'), 251, 155);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (188, 'Damaged fence', to_date('03-04-2023', 'dd-mm-yyyy'), 15, 130);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (189, 'Jammed lock', to_date('18-06-2023', 'dd-mm-yyyy'), 305, 244);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (190, 'Pest infestation', to_date('18-07-2023', 'dd-mm-yyyy'), 230, 302);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (191, 'Mold growth', to_date('07-09-2023', 'dd-mm-yyyy'), 15, 230);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (192, 'Toilet clog', to_date('03-03-2023', 'dd-mm-yyyy'), 46, 241);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (193, 'Flickering screen', to_date('08-01-2024', 'dd-mm-yyyy'), 27, 4);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (194, 'Leaking pipe', to_date('09-11-2023', 'dd-mm-yyyy'), 227, 313);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (195, 'Foul taste in water', to_date('13-01-2024', 'dd-mm-yyyy'), 260, 344);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (196, 'Rattling pipes', to_date('09-03-2023', 'dd-mm-yyyy'), 397, 87);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (197, 'Flickering screen', to_date('10-03-2024', 'dd-mm-yyyy'), 10, 288);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (198, 'Ceiling leak', to_date('13-12-2023', 'dd-mm-yyyy'), 3, 289);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (199, 'Broken door', to_date('19-01-2023', 'dd-mm-yyyy'), 380, 230);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (200, 'Jammed garbage disposal', to_date('31-01-2023', 'dd-mm-yyyy'), 210, 29);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (201, 'Broken window', to_date('10-08-2023', 'dd-mm-yyyy'), 327, 289);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (202, 'Flickering lights', to_date('20-01-2024', 'dd-mm-yyyy'), 147, 332);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (203, 'Rusty faucet', to_date('06-05-2023', 'dd-mm-yyyy'), 287, 178);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (204, 'Hissing radiator', to_date('07-03-2024', 'dd-mm-yyyy'), 301, 246);
commit;
prompt 200 records committed...
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (205, 'Water damage', to_date('26-09-2023', 'dd-mm-yyyy'), 328, 392);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (206, 'Clogged drain', to_date('16-12-2023', 'dd-mm-yyyy'), 69, 63);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (207, 'Faulty wiring', to_date('10-05-2023', 'dd-mm-yyyy'), 93, 280);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (208, 'Pest infestation', to_date('06-05-2023', 'dd-mm-yyyy'), 109, 276);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (209, 'Moldy odor', to_date('13-11-2023', 'dd-mm-yyyy'), 180, 211);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (210, 'Broken drawer', to_date('04-03-2023', 'dd-mm-yyyy'), 343, 214);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (211, 'Soggy drywall', to_date('28-04-2023', 'dd-mm-yyyy'), 304, 333);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (212, 'Cracked sidewalk', to_date('30-10-2023', 'dd-mm-yyyy'), 221, 279);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (213, 'Foul taste in water', to_date('27-06-2023', 'dd-mm-yyyy'), 338, 77);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (214, 'Flickering lights', to_date('25-02-2024', 'dd-mm-yyyy'), 163, 56);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (215, 'Heater issue', to_date('05-05-2023', 'dd-mm-yyyy'), 191, 294);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (216, 'Flickering lights', to_date('13-12-2023', 'dd-mm-yyyy'), 279, 365);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (217, 'Jammed lock', to_date('21-05-2024', 'dd-mm-yyyy'), 274, 106);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (218, 'Rattling pipes', to_date('20-11-2023', 'dd-mm-yyyy'), 207, 294);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (220, 'Window won''t close', to_date('09-01-2023', 'dd-mm-yyyy'), 372, 166);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (222, 'Foul smell', to_date('03-01-2023', 'dd-mm-yyyy'), 225, 358);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (223, 'Loose tile', to_date('03-08-2023', 'dd-mm-yyyy'), 205, 388);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (224, 'Damaged fence', to_date('08-07-2023', 'dd-mm-yyyy'), 110, 347);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (225, 'Jammed lock', to_date('06-12-2023', 'dd-mm-yyyy'), 41, 349);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (226, 'Moldy odor', to_date('07-04-2023', 'dd-mm-yyyy'), 50, 278);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (227, 'Air conditioning leak', to_date('24-01-2023', 'dd-mm-yyyy'), 250, 264);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (228, 'Cracked wall', to_date('04-02-2023', 'dd-mm-yyyy'), 237, 238);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (229, 'Clogged drain', to_date('26-04-2023', 'dd-mm-yyyy'), 22, 361);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (230, 'Dripping shower', to_date('29-11-2023', 'dd-mm-yyyy'), 140, 246);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (231, 'Window won''t close', to_date('17-09-2023', 'dd-mm-yyyy'), 277, 189);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (232, 'Clogged drain', to_date('09-04-2023', 'dd-mm-yyyy'), 84, 5);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (233, 'Rodent sighting', to_date('14-05-2024', 'dd-mm-yyyy'), 220, 109);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (234, 'Dripping shower', to_date('24-11-2023', 'dd-mm-yyyy'), 286, 305);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (235, 'Stuck window', to_date('15-10-2023', 'dd-mm-yyyy'), 345, 76);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (236, 'Water damage', to_date('27-04-2024', 'dd-mm-yyyy'), 349, 169);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (237, 'Flickering screen', to_date('13-02-2023', 'dd-mm-yyyy'), 101, 341);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (238, 'Stuck window', to_date('12-08-2023', 'dd-mm-yyyy'), 261, 242);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (239, 'Plumbing issue', to_date('15-11-2023', 'dd-mm-yyyy'), 296, 171);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (240, 'Pest infestation', to_date('24-04-2024', 'dd-mm-yyyy'), 157, 85);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (241, 'Flickering screen', to_date('28-03-2024', 'dd-mm-yyyy'), 55, 228);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (242, 'Hissing radiator', to_date('27-05-2023', 'dd-mm-yyyy'), 174, 229);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (244, 'Mold growth', to_date('25-04-2023', 'dd-mm-yyyy'), 330, 140);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (245, 'Mold growth', to_date('13-01-2024', 'dd-mm-yyyy'), 268, 392);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (246, 'Freezing refrigerator', to_date('27-03-2024', 'dd-mm-yyyy'), 299, 133);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (247, 'Dripping shower', to_date('21-07-2023', 'dd-mm-yyyy'), 28, 10);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (248, 'Cracked sidewalk', to_date('04-04-2023', 'dd-mm-yyyy'), 266, 160);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (249, 'Jammed garbage disposal', to_date('23-05-2023', 'dd-mm-yyyy'), 235, 160);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (250, 'Ceiling leak', to_date('02-01-2023', 'dd-mm-yyyy'), 36, 84);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (252, 'Water damage', to_date('07-06-2023', 'dd-mm-yyyy'), 105, 140);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (253, 'Leaking pipe', to_date('22-12-2023', 'dd-mm-yyyy'), 287, 396);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (254, 'Leaking pipe', to_date('19-12-2023', 'dd-mm-yyyy'), 379, 298);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (255, 'Cracked wall', to_date('14-11-2023', 'dd-mm-yyyy'), 361, 240);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (256, 'Cracked sidewalk', to_date('14-05-2024', 'dd-mm-yyyy'), 190, 339);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (257, 'Foul taste in water', to_date('09-09-2023', 'dd-mm-yyyy'), 326, 323);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (258, 'Mold growth', to_date('03-02-2024', 'dd-mm-yyyy'), 364, 106);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (259, 'Broken lock', to_date('15-08-2023', 'dd-mm-yyyy'), 211, 169);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (260, 'Squeaky floor', to_date('16-03-2023', 'dd-mm-yyyy'), 286, 147);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (261, 'Loose tile', to_date('08-01-2023', 'dd-mm-yyyy'), 21, 107);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (262, 'Faulty wiring', to_date('19-04-2024', 'dd-mm-yyyy'), 363, 4);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (263, 'Plumbing issue', to_date('17-05-2024', 'dd-mm-yyyy'), 12, 57);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (264, 'Window won''t close', to_date('21-05-2023', 'dd-mm-yyyy'), 282, 231);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (265, 'Flickering lights', to_date('29-06-2023', 'dd-mm-yyyy'), 73, 363);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (266, 'Air conditioning leak', to_date('30-03-2024', 'dd-mm-yyyy'), 16, 143);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (267, 'Broken window', to_date('30-03-2023', 'dd-mm-yyyy'), 264, 7);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (268, 'Heater issue', to_date('01-05-2023', 'dd-mm-yyyy'), 392, 70);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (269, 'Broken thermostat', to_date('25-09-2023', 'dd-mm-yyyy'), 101, 55);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (270, 'Flickering screen', to_date('20-02-2024', 'dd-mm-yyyy'), 345, 396);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (271, 'Window won''t close', to_date('13-02-2023', 'dd-mm-yyyy'), 310, 309);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (272, 'Cabinet door broken', to_date('21-03-2024', 'dd-mm-yyyy'), 290, 125);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (273, 'Cabinet door broken', to_date('31-01-2024', 'dd-mm-yyyy'), 78, 47);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (274, 'Clogged drain', to_date('15-12-2023', 'dd-mm-yyyy'), 24, 121);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (275, 'Hissing radiator', to_date('14-07-2023', 'dd-mm-yyyy'), 292, 394);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (276, 'Graffiti', to_date('05-09-2023', 'dd-mm-yyyy'), 232, 32);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (278, 'Cabinet door broken', to_date('25-02-2023', 'dd-mm-yyyy'), 140, 345);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (279, 'Mold growth', to_date('22-05-2024', 'dd-mm-yyyy'), 394, 270);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (281, 'Cracked wall', to_date('10-01-2024', 'dd-mm-yyyy'), 357, 315);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (282, 'Moldy odor', to_date('09-11-2023', 'dd-mm-yyyy'), 116, 8);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (283, 'Flickering lights', to_date('20-10-2023', 'dd-mm-yyyy'), 201, 390);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (284, 'Broken door', to_date('25-12-2023', 'dd-mm-yyyy'), 195, 185);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (285, 'Broken drawer', to_date('09-09-2023', 'dd-mm-yyyy'), 359, 352);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (286, 'Leaking pipe', to_date('17-05-2024', 'dd-mm-yyyy'), 14, 303);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (287, 'Dripping shower', to_date('25-11-2023', 'dd-mm-yyyy'), 295, 363);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (288, 'Rusty faucet', to_date('19-08-2023', 'dd-mm-yyyy'), 294, 73);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (289, 'Damaged flooring', to_date('20-06-2023', 'dd-mm-yyyy'), 340, 255);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (290, 'Jammed lock', to_date('02-05-2023', 'dd-mm-yyyy'), 269, 229);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (291, 'Jammed lock', to_date('26-04-2023', 'dd-mm-yyyy'), 308, 395);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (293, 'Foul taste in water', to_date('25-08-2023', 'dd-mm-yyyy'), 277, 42);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (295, 'Stuck window', to_date('12-09-2023', 'dd-mm-yyyy'), 200, 340);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (296, 'Mold growth', to_date('03-09-2023', 'dd-mm-yyyy'), 359, 29);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (297, 'Foul taste in water', to_date('08-04-2023', 'dd-mm-yyyy'), 265, 342);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (298, 'Freezing refrigerator', to_date('26-08-2023', 'dd-mm-yyyy'), 268, 37);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (299, 'Dripping shower', to_date('17-10-2023', 'dd-mm-yyyy'), 353, 193);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (300, 'Heater issue', to_date('09-07-2023', 'dd-mm-yyyy'), 278, 19);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (301, 'Stuck window', to_date('09-02-2023', 'dd-mm-yyyy'), 34, 154);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (302, 'Jammed garbage disposal', to_date('09-06-2023', 'dd-mm-yyyy'), 226, 130);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (303, 'Foul smell', to_date('19-01-2024', 'dd-mm-yyyy'), 169, 213);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (304, 'Rusty faucet', to_date('27-07-2023', 'dd-mm-yyyy'), 182, 189);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (305, 'Moldy odor', to_date('11-01-2024', 'dd-mm-yyyy'), 389, 323);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (306, 'Freezing refrigerator', to_date('17-03-2024', 'dd-mm-yyyy'), 44, 5);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (307, 'Cabinet door broken', to_date('12-03-2024', 'dd-mm-yyyy'), 184, 50);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (308, 'Broken door', to_date('28-07-2023', 'dd-mm-yyyy'), 261, 396);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (309, 'Ceiling leak', to_date('18-04-2023', 'dd-mm-yyyy'), 130, 276);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (310, 'Cracked sidewalk', to_date('02-08-2023', 'dd-mm-yyyy'), 192, 68);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (311, 'Broken thermostat', to_date('23-09-2023', 'dd-mm-yyyy'), 189, 25);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (312, 'Cabinet door broken', to_date('05-04-2023', 'dd-mm-yyyy'), 280, 316);
commit;
prompt 300 records committed...
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (313, 'Broken appliance', to_date('25-06-2023', 'dd-mm-yyyy'), 286, 117);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (314, 'Broken lock', to_date('25-04-2024', 'dd-mm-yyyy'), 264, 196);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (315, 'Stuck window', to_date('20-11-2023', 'dd-mm-yyyy'), 232, 68);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (316, 'Stained carpet', to_date('21-02-2023', 'dd-mm-yyyy'), 205, 288);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (317, 'Squeaky floor', to_date('01-01-2024', 'dd-mm-yyyy'), 275, 302);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (318, 'Broken switch', to_date('21-09-2023', 'dd-mm-yyyy'), 260, 160);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (319, 'Stuck window', to_date('17-06-2023', 'dd-mm-yyyy'), 138, 93);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (320, 'Cracked sidewalk', to_date('12-09-2023', 'dd-mm-yyyy'), 225, 292);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (321, 'Freezing refrigerator', to_date('03-02-2023', 'dd-mm-yyyy'), 109, 5);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (322, 'Cracked wall', to_date('06-02-2023', 'dd-mm-yyyy'), 24, 71);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (323, 'Rattling pipes', to_date('19-11-2023', 'dd-mm-yyyy'), 392, 205);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (324, 'Leaky roof', to_date('03-03-2023', 'dd-mm-yyyy'), 179, 163);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (325, 'Leaking pipe', to_date('20-10-2023', 'dd-mm-yyyy'), 273, 198);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (326, 'Pest infestation', to_date('11-11-2023', 'dd-mm-yyyy'), 90, 201);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (327, 'Soggy drywall', to_date('05-03-2024', 'dd-mm-yyyy'), 112, 351);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (328, 'Moldy odor', to_date('10-03-2023', 'dd-mm-yyyy'), 161, 143);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (329, 'No hot water', to_date('14-05-2024', 'dd-mm-yyyy'), 276, 268);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (330, 'Cracked wall', to_date('21-04-2023', 'dd-mm-yyyy'), 265, 292);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (331, 'Broken window', to_date('29-01-2024', 'dd-mm-yyyy'), 88, 239);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (332, 'Smashed mirror', to_date('24-05-2023', 'dd-mm-yyyy'), 217, 102);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (333, 'Cracked sidewalk', to_date('21-11-2023', 'dd-mm-yyyy'), 395, 192);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (334, 'Stained carpet', to_date('09-01-2023', 'dd-mm-yyyy'), 205, 199);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (335, 'Broken appliance', to_date('29-02-2024', 'dd-mm-yyyy'), 395, 108);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (336, 'Soggy drywall', to_date('04-01-2024', 'dd-mm-yyyy'), 369, 249);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (337, 'Toilet clog', to_date('26-04-2024', 'dd-mm-yyyy'), 38, 11);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (338, 'Broken window', to_date('24-04-2024', 'dd-mm-yyyy'), 312, 367);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (339, 'Cracked sidewalk', to_date('12-02-2024', 'dd-mm-yyyy'), 387, 106);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (340, 'Moldy odor', to_date('06-03-2023', 'dd-mm-yyyy'), 150, 126);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (341, 'Stuck window', to_date('07-11-2023', 'dd-mm-yyyy'), 172, 88);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (342, 'Plumbing issue', to_date('08-06-2023', 'dd-mm-yyyy'), 7, 266);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (343, 'Electrical problem', to_date('22-03-2024', 'dd-mm-yyyy'), 160, 232);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (344, 'Water damage', to_date('13-03-2024', 'dd-mm-yyyy'), 131, 115);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (346, 'Foul smell', to_date('27-02-2023', 'dd-mm-yyyy'), 199, 352);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (347, 'Broken switch', to_date('22-04-2024', 'dd-mm-yyyy'), 116, 137);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (348, 'Window won''t close', to_date('04-09-2023', 'dd-mm-yyyy'), 78, 251);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (349, 'Flickering screen', to_date('01-03-2024', 'dd-mm-yyyy'), 197, 146);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (350, 'Rusty faucet', to_date('18-02-2024', 'dd-mm-yyyy'), 378, 369);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (351, 'Hissing radiator', to_date('25-04-2023', 'dd-mm-yyyy'), 172, 116);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (352, 'Stained carpet', to_date('24-04-2024', 'dd-mm-yyyy'), 280, 225);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (353, 'Faulty wiring', to_date('12-10-2023', 'dd-mm-yyyy'), 347, 59);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (354, 'Faulty wiring', to_date('31-03-2023', 'dd-mm-yyyy'), 259, 206);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (355, 'Damaged countertop', to_date('19-04-2024', 'dd-mm-yyyy'), 354, 36);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (356, 'Plumbing issue', to_date('24-03-2023', 'dd-mm-yyyy'), 1, 220);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (357, 'Damaged flooring', to_date('12-05-2024', 'dd-mm-yyyy'), 335, 241);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (358, 'Ceiling leak', to_date('04-02-2024', 'dd-mm-yyyy'), 308, 52);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (359, 'Broken door', to_date('29-01-2024', 'dd-mm-yyyy'), 150, 224);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (360, 'Flickering screen', to_date('08-05-2024', 'dd-mm-yyyy'), 249, 93);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (361, 'Heater issue', to_date('24-01-2023', 'dd-mm-yyyy'), 215, 45);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (362, 'Pest infestation', to_date('11-02-2023', 'dd-mm-yyyy'), 87, 137);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (363, 'Broken door', to_date('15-05-2023', 'dd-mm-yyyy'), 30, 91);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (364, 'Ceiling leak', to_date('11-12-2023', 'dd-mm-yyyy'), 350, 388);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (365, 'Heater issue', to_date('14-04-2023', 'dd-mm-yyyy'), 241, 308);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (366, 'Water damage', to_date('29-10-2023', 'dd-mm-yyyy'), 316, 45);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (368, 'Smashed mirror', to_date('25-04-2023', 'dd-mm-yyyy'), 67, 264);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (369, 'Cracked wall', to_date('11-01-2023', 'dd-mm-yyyy'), 289, 4);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (370, 'Broken drawer', to_date('02-02-2024', 'dd-mm-yyyy'), 316, 351);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (371, 'Clogged drain', to_date('06-12-2023', 'dd-mm-yyyy'), 329, 56);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (372, 'Cracked wall', to_date('29-01-2023', 'dd-mm-yyyy'), 354, 86);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (373, 'Cabinet door broken', to_date('19-01-2024', 'dd-mm-yyyy'), 212, 266);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (374, 'Foul smell', to_date('04-08-2023', 'dd-mm-yyyy'), 113, 353);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (375, 'Squeaky floor', to_date('24-06-2023', 'dd-mm-yyyy'), 32, 156);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (376, 'Air conditioning leak', to_date('03-06-2023', 'dd-mm-yyyy'), 75, 15);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (377, 'Broken door', to_date('16-09-2023', 'dd-mm-yyyy'), 139, 220);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (378, 'Stuck window', to_date('22-05-2024', 'dd-mm-yyyy'), 369, 384);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (379, 'Smashed mirror', to_date('17-03-2024', 'dd-mm-yyyy'), 27, 1);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (380, 'Broken thermostat', to_date('21-01-2023', 'dd-mm-yyyy'), 51, 387);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (381, 'Hissing radiator', to_date('10-05-2024', 'dd-mm-yyyy'), 104, 191);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (382, 'Broken drawer', to_date('23-12-2023', 'dd-mm-yyyy'), 111, 330);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (383, 'Stained carpet', to_date('27-01-2024', 'dd-mm-yyyy'), 394, 93);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (384, 'Stuck window', to_date('28-10-2023', 'dd-mm-yyyy'), 341, 314);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (385, 'Leaking pipe', to_date('25-03-2024', 'dd-mm-yyyy'), 366, 27);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (386, 'Foul taste in water', to_date('06-04-2024', 'dd-mm-yyyy'), 393, 38);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (387, 'Electrical problem', to_date('19-11-2023', 'dd-mm-yyyy'), 200, 222);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (388, 'Damaged countertop', to_date('21-02-2024', 'dd-mm-yyyy'), 254, 208);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (389, 'Rodent sighting', to_date('31-03-2024', 'dd-mm-yyyy'), 230, 291);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (390, 'Cracked wall', to_date('07-04-2024', 'dd-mm-yyyy'), 69, 219);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (391, 'Damaged countertop', to_date('13-06-2023', 'dd-mm-yyyy'), 172, 195);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (392, 'Jammed garbage disposal', to_date('02-12-2023', 'dd-mm-yyyy'), 236, 68);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (393, 'Mold growth', to_date('18-11-2023', 'dd-mm-yyyy'), 344, 137);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (394, 'Stained carpet', to_date('25-07-2023', 'dd-mm-yyyy'), 65, 92);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (395, 'Graffiti', to_date('11-10-2023', 'dd-mm-yyyy'), 52, 338);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (396, 'Broken window', to_date('18-02-2024', 'dd-mm-yyyy'), 354, 298);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (397, 'Squeaky floor', to_date('26-02-2024', 'dd-mm-yyyy'), 372, 30);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (398, 'Air conditioning leak', to_date('18-05-2024', 'dd-mm-yyyy'), 84, 132);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (399, 'Freezing refrigerator', to_date('22-02-2023', 'dd-mm-yyyy'), 371, 253);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (400, 'Hissing radiator', to_date('16-07-2023', 'dd-mm-yyyy'), 198, 122);
commit;
prompt 386 records loaded
prompt Loading NEED_FOR...
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (6, 20, 6, 6, 6);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (17, 17, 17, 83, 223);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (19, 19, 19, 16, 183);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (20, 20, 20, 115, 107);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (25, 17, 25, 8, 234);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (28, 20, 28, 108, 37);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (33, 20, 33, 232, 376);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (34, 18, 34, 154, 351);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (35, 16, 35, 286, 192);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (40, 20, 40, 169, 85);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (49, 20, 49, 112, 290);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (51, 17, 51, 45, 9);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (54, 17, 54, 307, 117);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (61, 17, 61, 106, 345);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (64, 19, 64, 338, 103);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (69, 19, 69, 398, 396);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (70, 18, 70, 347, 93);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (74, 18, 74, 226, 27);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (76, 20, 76, 68, 286);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (78, 16, 78, 332, 73);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (81, 20, 81, 59, 183);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (85, 19, 85, 384, 122);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (90, 16, 90, 396, 269);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (95, 20, 95, 175, 354);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (100, 20, 100, 354, 276);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (101, 18, 101, 223, 387);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (102, 16, 102, 109, 100);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (103, 18, 103, 180, 67);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (106, 17, 106, 23, 348);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (108, 19, 108, 235, 313);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (109, 17, 109, 62, 238);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (115, 16, 115, 263, 152);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (117, 18, 117, 103, 190);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (123, 18, 123, 258, 264);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (127, 18, 127, 116, 56);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (142, 19, 142, 116, 323);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (143, 17, 143, 111, 250);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (148, 17, 148, 356, 69);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (154, 17, 154, 147, 276);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (155, 20, 155, 307, 288);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (165, 17, 165, 237, 214);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (166, 17, 166, 42, 43);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (171, 18, 171, 392, 343);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (174, 16, 174, 20, 167);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (179, 16, 179, 233, 184);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (185, 18, 185, 397, 294);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (187, 19, 187, 17, 66);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (189, 18, 189, 18, 201);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (192, 20, 192, 334, 228);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (193, 19, 193, 82, 23);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (195, 16, 195, 227, 338);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (198, 19, 198, 223, 128);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (199, 19, 199, 110, 9);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (201, 19, 201, 87, 292);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (205, 19, 205, 363, 225);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (208, 20, 208, 62, 51);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (212, 17, 212, 277, 158);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (213, 18, 213, 184, 106);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (218, 20, 218, 68, 78);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (222, 17, 222, 283, 297);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (227, 17, 227, 320, 55);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (230, 16, 230, 130, 274);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (231, 16, 231, 360, 285);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (237, 16, 237, 395, 189);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (251, 16, 251, 360, 370);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (253, 19, 253, 199, 19);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (255, 18, 255, 294, 365);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (269, 20, 269, 254, 319);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (274, 19, 274, 78, 143);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (282, 16, 282, 32, 228);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (283, 16, 283, 315, 6);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (287, 17, 287, 161, 59);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (291, 17, 291, 328, 327);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (296, 19, 296, 91, 188);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (297, 19, 297, 300, 398);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (301, 20, 301, 281, 378);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (305, 19, 305, 271, 170);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (320, 16, 320, 264, 330);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (321, 19, 321, 96, 286);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (323, 18, 323, 169, 208);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (325, 16, 325, 146, 340);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (329, 20, 329, 12, 32);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (331, 17, 331, 337, 212);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (332, 20, 332, 66, 71);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (337, 19, 337, 226, 247);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (342, 19, 342, 74, 39);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (343, 18, 343, 49, 388);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (350, 20, 350, 58, 152);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (352, 17, 352, 191, 239);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (360, 19, 360, 18, 111);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (361, 18, 361, 306, 355);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (367, 17, 367, 196, 261);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (371, 16, 371, 202, 184);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (375, 19, 375, 9, 72);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (386, 19, 386, 70, 127);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (393, 16, 393, 195, 86);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (397, 17, 397, 268, 302);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (400, 18, 400, 362, 113);
commit;
prompt 98 records loaded
prompt Loading STAFF_MEMBER_INFO...
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (1, '972-53567890');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (2, '972-52678901');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (3, '972-54789012');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (4, '972-53890123');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (5, '972-52601234');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (6, '972-52212345');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (7, '972-52123456');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (8, '972-53034567');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (9, '972-58745678');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (10, '972-54856789');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (11, '972-532458468');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (12, '972-516926496');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (13, '972-560437641');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (14, '972-560143765');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (15, '972-536673145');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (16, '972-599342084');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (17, '972-523256549');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (18, '972-521919180');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (19, '972-507830103');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (20, '972-597008065');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (21, '972-501244105');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (23, '972-553576317');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (24, '972-521549290');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (25, '972-557754528');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (26, '972-597194179');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (27, '972-539107339');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (28, '972-574077862');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (29, '972-599692734');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (30, '972-539665654');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (32, '972-596875641');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (33, '972-568186721');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (34, '972-540049529');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (35, '972-570279946');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (36, '972-575641254');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (37, '972-596483436');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (38, '972-501165166');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (39, '972-566222176');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (40, '972-552499357');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (41, '972-528644129');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (42, '972-517347450');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (43, '972-541594037');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (44, '972-510226342');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (45, '972-577984918');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (46, '972-522021663');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (47, '972-528682479');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (49, '972-500287526');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (50, '972-597794207');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (51, '972-590118515');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (52, '972-557498693');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (53, '972-544718064');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (54, '972-579866634');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (55, '972-527458675');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (56, '972-513333084');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (57, '972-570015637');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (58, '972-565076392');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (59, '972-581712850');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (60, '972-517795075');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (61, '972-571943108');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (63, '972-569903717');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (64, '972-545377946');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (65, '972-548506981');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (66, '972-530470142');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (67, '972-578634600');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (68, '972-556238184');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (69, '972-500750577');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (70, '972-517131167');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (71, '972-531429741');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (72, '972-541542963');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (73, '972-591896679');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (74, '972-546341320');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (75, '972-541392334');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (76, '972-520136922');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (77, '972-506008994');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (78, '972-519890989');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (79, '972-557872453');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (80, '972-556464675');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (84, '972-519473736');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (85, '972-527288963');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (86, '972-565315211');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (87, '972-503850862');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (88, '972-591194746');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (89, '972-587083300');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (90, '972-504392287');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (91, '972-529341734');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (92, '972-534301085');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (93, '972-598108905');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (97, '972-588791151');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (100, '972-519907759');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (102, '972-548271533');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (103, '972-539594473');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (104, '972-587441505');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (106, '972-562760067');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (107, '972-529319526');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (108, '972-575829625');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (109, '972-530093819');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (110, '972-579992046');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (111, '972-541643633');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (112, '972-500117175');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (113, '972-581144236');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (114, '972-545460492');
commit;
prompt 100 records committed...
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (115, '972-503074859');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (116, '972-563710849');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (117, '972-551553007');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (118, '972-589210222');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (120, '972-531606319');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (121, '972-503623822');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (122, '972-576228648');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (123, '972-598208116');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (125, '972-579673812');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (126, '972-538586109');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (127, '972-565158736');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (128, '972-579559736');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (129, '972-570651779');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (130, '972-506800783');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (132, '972-508056869');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (133, '972-504847376');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (137, '972-539456049');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (138, '972-594656932');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (140, '972-563519659');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (141, '972-501896840');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (142, '972-587052262');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (143, '972-575001102');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (144, '972-502371672');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (145, '972-597174494');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (146, '972-543829859');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (147, '972-557659947');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (148, '972-516016021');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (152, '972-575536654');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (153, '972-560460746');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (154, '972-527363502');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (155, '972-549039055');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (156, '972-503492439');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (158, '972-523925566');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (159, '972-547454822');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (160, '972-572320159');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (162, '972-578502115');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (163, '972-596504716');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (164, '972-529634444');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (165, '972-541976955');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (166, '972-539411850');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (167, '972-533878622');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (168, '972-563181082');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (169, '972-504371522');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (170, '972-558866935');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (171, '972-576901587');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (174, '972-575420273');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (175, '972-546892786');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (176, '972-578156639');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (177, '972-509948165');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (178, '972-558732725');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (179, '972-578477135');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (181, '972-523360954');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (182, '972-542061711');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (183, '972-525425014');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (184, '972-570332552');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (185, '972-539089269');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (188, '972-527194563');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (189, '972-562790299');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (190, '972-545404089');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (191, '972-516158988');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (192, '972-535992149');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (193, '972-526192008');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (195, '972-512953479');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (196, '972-514593076');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (197, '972-563225972');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (198, '972-590951893');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (199, '972-531180571');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (200, '972-528087049');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (201, '972-554386694');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (203, '972-542588594');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (204, '972-544464046');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (205, '972-576594699');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (206, '972-548878059');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (207, '972-533010679');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (208, '972-530207827');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (210, '972-558838580');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (211, '972-518442794');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (212, '972-508444595');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (213, '972-554948912');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (214, '972-563453207');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (215, '972-547536215');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (216, '972-581927465');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (219, '972-513618696');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (220, '972-590076358');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (222, '972-524026499');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (223, '972-560438452');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (224, '972-509892713');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (225, '972-552144092');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (226, '972-518710890');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (227, '972-542899072');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (228, '972-580885779');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (229, '972-551845820');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (230, '972-559774610');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (231, '972-561511513');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (232, '972-538700555');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (233, '972-528323003');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (234, '972-526979666');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (235, '972-517963235');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (236, '972-553627432');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (238, '972-561508595');
commit;
prompt 200 records committed...
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (239, '972-578331399');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (240, '972-504355790');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (241, '972-562320888');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (242, '972-543489173');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (243, '972-563189128');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (244, '972-567696219');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (246, '972-531003628');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (247, '972-591510998');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (248, '972-539204259');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (249, '972-501952676');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (250, '972-534062439');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (251, '972-509058260');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (253, '972-594282386');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (254, '972-548689789');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (255, '972-506983528');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (256, '972-592396337');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (257, '972-545673205');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (258, '972-592943401');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (259, '972-550671579');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (261, '972-592621534');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (263, '972-567827013');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (264, '972-530742465');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (266, '972-511678734');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (267, '972-580688768');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (268, '972-517490919');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (269, '972-562916746');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (270, '972-527415178');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (271, '972-542059780');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (273, '972-574320980');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (274, '972-597488605');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (276, '972-574246193');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (277, '972-538928180');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (278, '972-590750178');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (279, '972-560645491');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (280, '972-588575150');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (281, '972-593911872');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (282, '972-509757324');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (283, '972-500911693');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (284, '972-555534066');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (285, '972-573908260');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (286, '972-539384438');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (287, '972-546386526');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (288, '972-569798575');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (289, '972-562065677');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (290, '972-570524835');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (291, '972-526478278');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (292, '972-556367167');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (293, '972-550382554');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (294, '972-531966838');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (295, '972-512883683');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (297, '972-520081998');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (298, '972-532238898');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (300, '972-571375016');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (302, '972-592419900');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (303, '972-511626217');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (305, '972-576047873');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (306, '972-588776859');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (307, '972-599093724');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (308, '972-589072007');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (309, '972-583905842');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (310, '972-510027326');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (311, '972-519857859');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (312, '972-550698838');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (313, '972-559060575');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (314, '972-545721092');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (315, '972-569219806');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (316, '972-529517384');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (317, '972-593104629');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (319, '972-590322212');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (320, '972-523804467');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (322, '972-589101287');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (323, '972-562165158');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (324, '972-511938617');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (325, '972-574544083');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (327, '972-525248377');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (329, '972-587343352');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (330, '972-592649343');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (332, '972-597088071');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (333, '972-581227068');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (334, '972-534885541');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (336, '972-502444681');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (338, '972-581042319');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (339, '972-593484744');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (340, '972-536504409');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (341, '972-595888541');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (342, '972-581658110');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (343, '972-592534007');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (344, '972-594767222');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (345, '972-577046759');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (347, '972-537474042');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (348, '972-525940819');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (349, '972-561819857');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (351, '972-508352702');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (352, '972-560501778');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (353, '972-508545152');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (354, '972-505174675');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (355, '972-578745209');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (357, '972-559449353');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (358, '972-502475906');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (360, '972-599272738');
commit;
prompt 300 records committed...
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (361, '972-541240737');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (362, '972-515370257');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (363, '972-587105173');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (364, '972-543835579');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (365, '972-599189936');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (366, '972-598203137');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (367, '972-586507639');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (368, '972-582610971');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (369, '972-520345581');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (370, '972-535786354');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (371, '972-503400111');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (373, '972-553863783');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (374, '972-535065374');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (376, '972-535764495');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (378, '972-535634204');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (381, '972-507692457');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (384, '972-501761347');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (386, '972-525655305');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (387, '972-573597504');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (388, '972-531427714');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (390, '972-511285456');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (391, '972-533562932');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (392, '972-580646266');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (394, '972-579147593');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (395, '972-506857655');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (396, '972-586874827');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (397, '972-535209982');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (398, '972-502939244');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (399, '972-534652825');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (400, '972-567267750');
commit;
prompt 330 records loaded
prompt Enabling foreign key constraints for CLEANING_TASK...
alter table CLEANING_TASK enable constraint SYS_C009187;
alter table CLEANING_TASK enable constraint SYS_C009188;
prompt Enabling foreign key constraints for INSPECTION_LOGS...
alter table INSPECTION_LOGS enable constraint SYS_C009202;
prompt Enabling foreign key constraints for MAINTENANCE_REQUEST...
alter table MAINTENANCE_REQUEST enable constraint SYS_C009195;
alter table MAINTENANCE_REQUEST enable constraint SYS_C009196;
prompt Enabling foreign key constraints for NEED_FOR...
alter table NEED_FOR enable constraint SYS_C009209;
alter table NEED_FOR enable constraint SYS_C009210;
prompt Enabling foreign key constraints for STAFF_MEMBER_INFO...
alter table STAFF_MEMBER_INFO enable constraint SYS_C009214;
prompt Enabling triggers for CLEANING_SUPPLY...
alter table CLEANING_SUPPLY enable all triggers;
prompt Enabling triggers for ROOM...
alter table ROOM enable all triggers;
prompt Enabling triggers for STAFF_MEMBER...
alter table STAFF_MEMBER enable all triggers;
prompt Enabling triggers for CLEANING_TASK...
alter table CLEANING_TASK enable all triggers;
prompt Enabling triggers for INSPECTION_LOGS...
alter table INSPECTION_LOGS enable all triggers;
prompt Enabling triggers for MAINTENANCE_REQUEST...
alter table MAINTENANCE_REQUEST enable all triggers;
prompt Enabling triggers for NEED_FOR...
alter table NEED_FOR enable all triggers;
prompt Enabling triggers for STAFF_MEMBER_INFO...
alter table STAFF_MEMBER_INFO enable all triggers;

set feedback on
set define on
prompt Done
