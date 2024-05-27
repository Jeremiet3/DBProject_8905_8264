prompt PL/SQL Developer Export Tables for user SYSTEM@XE
prompt Created by Admin on Friday, May 24, 2024
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
  last_name_ VARCHAR2(30) not null
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
  status VARCHAR2(30) not null,
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
  references ROOM (RID);
alter table CLEANING_TASK
  add foreign key (SID)
  references STAFF_MEMBER (SID);

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
  references ROOM (RID);

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
  references ROOM (RID);
alter table MAINTENANCE_REQUEST
  add foreign key (SID)
  references STAFF_MEMBER (SID);

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
  references CLEANING_SUPPLY (SUID);
alter table NEED_FOR
  add foreign key (TID, RID, SID)
  references CLEANING_TASK (TID, RID, SID);

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
  add foreign key (SID)
  references STAFF_MEMBER (SID);

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
alter table CLEANING_TASK disable constraint SYS_C008905;
alter table CLEANING_TASK disable constraint SYS_C008906;
prompt Disabling foreign key constraints for INSPECTION_LOGS...
alter table INSPECTION_LOGS disable constraint SYS_C008920;
prompt Disabling foreign key constraints for MAINTENANCE_REQUEST...
alter table MAINTENANCE_REQUEST disable constraint SYS_C008913;
alter table MAINTENANCE_REQUEST disable constraint SYS_C008914;
prompt Disabling foreign key constraints for NEED_FOR...
alter table NEED_FOR disable constraint SYS_C008927;
alter table NEED_FOR disable constraint SYS_C008928;
prompt Disabling foreign key constraints for STAFF_MEMBER_INFO...
alter table STAFF_MEMBER_INFO disable constraint SYS_C008932;
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
values (1, 'Detergent', 100, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (2, 'Bleach', 50, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (3, 'Mop', 30, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (4, 'Broom', 20, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (5, 'Vacuum', 15, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (6, 'Trash Bags', 200, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (7, 'Glass Cleaner', 40, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (8, 'Air Freshener', 60, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (9, 'Disinfectant', 70, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (10, 'Floor Polish', 25, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (11, 'Lint Roller', 238, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (12, 'Window Squeegee', 375, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (13, 'Lint Roller', 179, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (14, 'Grout Cleaner', 217, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (15, 'Stainless Steel Cleaner', 132, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (16, 'Grout Cleaner', 124, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (17, 'Detergent', 175, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (18, 'Bathroom Deodorizer', 154, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (19, 'Toilet Bowl Cleaner', 88, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (20, 'Sponges', 319, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (21, 'Baking Soda', 125, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (22, 'Paper Towels', 280, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (23, 'Shoe Deodorizer', 185, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (24, 'White Vinegar', 297, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (25, 'Oven Cleaner', 383, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (26, 'Bathroom Deodorizer', 268, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (27, 'Lint Roller', 80, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (28, 'Dish Soap', 224, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (29, 'Carpet Cleaner', 211, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (30, 'Oven Cleaner', 71, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (31, 'Mop', 258, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (32, 'Fabric Softener', 500, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (33, 'Dish Soap', 99, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (34, 'Broom', 111, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (35, 'Dish Soap', 108, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (36, 'Sponges', 367, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (37, 'Stove Degreaser', 423, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (38, 'Oven Cleaner', 279, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (39, 'Dryer Sheets', 336, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (40, 'Carpet Cleaner', 273, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (41, 'Microfiber Cloths', 443, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (42, 'Air Freshener', 406, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (43, 'Wood Polish', 296, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (44, 'Stove Degreaser', 379, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (45, 'Lemon Juice', 329, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (46, 'Bathroom Deodorizer', 64, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (47, 'Broom', 103, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (48, 'Glass Cleaner', 494, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (49, 'Dryer Sheets', 180, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (50, 'Fabric Softener', 87, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (51, 'Microfiber Cloths', 326, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (52, 'Hand Sanitizer', 481, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (53, 'Vacuum', 424, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (54, 'Lint Roller', 11, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (55, 'Hand Sanitizer', 22, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (56, 'Grout Cleaner', 260, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (57, 'Rubber Gloves', 270, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (58, 'Rubber Gloves', 433, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (59, 'Oven Cleaner', 414, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (60, 'All-Purpose Cleaner', 164, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (61, 'Stove Degreaser', 317, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (62, 'Essential Oils', 326, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (63, 'Essential Oils', 480, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (64, 'Laundry Detergent', 65, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (65, 'Baking Soda', 350, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (66, 'Toilet Bowl Cleaner', 28, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (67, 'Mop', 345, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (68, 'Laundry Detergent', 209, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (69, 'Vacuum', 140, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (70, 'Lint Roller', 174, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (71, 'Dryer Sheets', 473, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (72, 'Stove Degreaser', 468, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (73, 'Detergent', 411, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (74, 'Stainless Steel Cleaner', 189, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (75, 'Floor Polish', 16, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (76, 'Toilet Bowl Cleaner', 212, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (77, 'Essential Oils', 270, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (78, 'Sponges', 105, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (79, 'White Vinegar', 251, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (80, 'Broom', 176, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (81, 'Grout Cleaner', 279, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (82, 'White Vinegar', 231, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (83, 'All-Purpose Cleaner', 498, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (84, 'Lemon Juice', 418, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (85, 'Rubber Gloves', 343, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (86, 'Stove Degreaser', 229, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (87, 'Rubber Gloves', 62, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (88, 'Air Freshener', 414, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (89, 'Dryer Sheets', 372, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (90, 'Shoe Deodorizer', 251, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (91, 'Grout Cleaner', 221, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (92, 'Dish Soap', 40, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (93, 'Shoe Deodorizer', 17, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (94, 'Trash Bags', 495, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (95, 'Floor Polish', 406, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (96, 'Mop', 375, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (97, 'Detergent', 266, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (98, 'Paper Towels', 145, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (99, 'Lint Roller', 29, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (100, 'Fabric Softener', 384, 'Storage A');
commit;
prompt 100 records committed...
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (101, 'Sponges', 17, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (102, 'Broom', 150, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (103, 'Broom', 350, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (104, 'Dish Soap', 421, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (105, 'Lemon Juice', 488, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (106, 'White Vinegar', 241, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (107, 'Oven Cleaner', 405, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (108, 'Hand Sanitizer', 39, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (109, 'Dish Soap', 500, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (110, 'Air Freshener', 295, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (111, 'Fabric Softener', 293, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (112, 'Sponges', 296, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (113, 'Sponges', 166, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (114, 'Trash Bags', 127, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (115, 'Air Freshener', 201, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (116, 'Baking Soda', 273, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (117, 'Hand Sanitizer', 196, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (118, 'Detergent', 209, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (119, 'Toilet Bowl Cleaner', 348, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (120, 'Shoe Deodorizer', 179, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (121, 'Carpet Cleaner', 356, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (122, 'Bleach', 88, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (123, 'Air Freshener', 314, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (124, 'Stove Degreaser', 36, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (125, 'Fabric Softener', 243, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (126, 'Glass Cleaner', 212, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (127, 'Stove Degreaser', 221, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (128, 'Carpet Cleaner', 183, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (129, 'Lint Roller', 279, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (130, 'Window Squeegee', 238, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (131, 'Disinfectant', 21, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (132, 'Dish Soap', 193, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (133, 'Broom', 435, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (134, 'Grout Cleaner', 267, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (135, 'Mop', 107, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (136, 'Grout Cleaner', 246, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (137, 'Mop', 220, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (138, 'Disinfectant', 302, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (139, 'Broom', 222, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (140, 'Dish Soap', 305, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (141, 'Sponges', 174, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (142, 'Bleach', 194, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (143, 'Stainless Steel Cleaner', 142, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (144, 'Paper Towels', 426, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (145, 'Broom', 279, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (146, 'Trash Bags', 33, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (147, 'Floor Polish', 329, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (148, 'Stainless Steel Cleaner', 225, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (149, 'Scrub Brushes', 187, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (150, 'Hand Sanitizer', 57, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (151, 'Bathroom Deodorizer', 379, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (152, 'Laundry Detergent', 116, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (153, 'Grout Cleaner', 386, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (154, 'Air Freshener', 287, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (155, 'Floor Polish', 99, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (156, 'Oven Cleaner', 127, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (157, 'Essential Oils', 94, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (158, 'Dish Soap', 194, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (159, 'Disinfectant', 299, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (160, 'Dish Soap', 122, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (161, 'Dish Soap', 97, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (162, 'Hand Sanitizer', 308, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (163, 'Hand Sanitizer', 21, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (164, 'Lint Roller', 451, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (165, 'Air Freshener', 189, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (166, 'Glass Cleaner', 436, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (167, 'Paper Towels', 319, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (168, 'Broom', 216, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (169, 'Oven Cleaner', 145, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (170, 'Floor Polish', 90, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (171, 'Disinfectant', 259, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (172, 'Rubber Gloves', 271, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (173, 'Trash Bags', 54, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (174, 'Lint Roller', 447, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (175, 'Paper Towels', 391, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (176, 'Mop', 50, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (177, 'Vacuum', 328, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (178, 'Rubber Gloves', 429, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (179, 'Glass Cleaner', 127, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (180, 'White Vinegar', 494, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (181, 'Shoe Deodorizer', 401, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (182, 'Air Freshener', 227, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (183, 'Floor Polish', 91, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (184, 'Disinfectant', 457, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (185, 'Detergent', 142, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (186, 'Paper Towels', 186, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (187, 'Rubber Gloves', 36, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (188, 'White Vinegar', 83, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (189, 'Broom', 271, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (190, 'Dryer Sheets', 274, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (191, 'Rubber Gloves', 224, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (192, 'Laundry Detergent', 248, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (193, 'Trash Bags', 169, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (194, 'White Vinegar', 86, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (195, 'Scrub Brushes', 43, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (196, 'Lint Roller', 44, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (197, 'Disinfectant', 411, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (198, 'Dryer Sheets', 425, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (199, 'Laundry Detergent', 37, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (200, 'Laundry Detergent', 274, 'Storage C');
commit;
prompt 200 records committed...
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (201, 'Dish Soap', 315, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (202, 'Essential Oils', 283, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (203, 'White Vinegar', 395, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (204, 'Hand Sanitizer', 459, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (205, 'Lemon Juice', 48, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (206, 'Stove Degreaser', 323, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (207, 'Microfiber Cloths', 351, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (208, 'Rubber Gloves', 43, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (209, 'Broom', 277, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (210, 'Broom', 53, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (211, 'Shoe Deodorizer', 134, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (212, 'Toilet Bowl Cleaner', 356, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (213, 'Floor Polish', 320, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (214, 'Laundry Detergent', 47, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (215, 'Scrub Brushes', 346, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (216, 'Essential Oils', 122, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (217, 'Bathroom Deodorizer', 296, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (218, 'Trash Bags', 84, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (219, 'White Vinegar', 159, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (220, 'Trash Bags', 445, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (221, 'Air Freshener', 136, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (222, 'Bathroom Deodorizer', 387, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (223, 'Mop', 264, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (224, 'Floor Polish', 44, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (225, 'Hand Sanitizer', 217, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (226, 'Scrub Brushes', 17, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (227, 'Scrub Brushes', 418, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (228, 'Toilet Bowl Cleaner', 356, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (229, 'Oven Cleaner', 158, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (230, 'Dish Soap', 345, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (231, 'Wood Polish', 219, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (232, 'Toilet Bowl Cleaner', 36, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (233, 'Window Squeegee', 300, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (234, 'Microfiber Cloths', 61, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (235, 'Window Squeegee', 86, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (236, 'Lint Roller', 206, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (237, 'Essential Oils', 193, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (238, 'Window Squeegee', 175, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (239, 'White Vinegar', 18, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (240, 'Sponges', 212, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (241, 'Window Squeegee', 340, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (242, 'Grout Cleaner', 320, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (243, 'Shoe Deodorizer', 224, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (244, 'Vacuum', 107, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (245, 'Toilet Bowl Cleaner', 290, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (246, 'Trash Bags', 168, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (247, 'Stainless Steel Cleaner', 482, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (248, 'Air Freshener', 155, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (249, 'Hand Sanitizer', 52, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (250, 'Vacuum', 254, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (251, 'Shoe Deodorizer', 83, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (252, 'Sponges', 78, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (253, 'Carpet Cleaner', 159, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (254, 'Floor Polish', 76, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (255, 'Scrub Brushes', 387, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (256, 'White Vinegar', 379, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (257, 'Disinfectant', 215, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (258, 'Sponges', 277, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (259, 'Air Freshener', 316, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (260, 'Essential Oils', 350, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (261, 'Dish Soap', 333, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (262, 'Dish Soap', 164, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (263, 'Essential Oils', 299, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (264, 'Stove Degreaser', 258, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (265, 'Hand Sanitizer', 168, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (266, 'Dryer Sheets', 57, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (267, 'Wood Polish', 333, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (268, 'Baking Soda', 111, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (269, 'Detergent', 168, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (270, 'Oven Cleaner', 454, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (271, 'Dryer Sheets', 69, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (272, 'Fabric Softener', 281, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (273, 'Window Squeegee', 497, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (274, 'Broom', 413, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (275, 'White Vinegar', 95, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (276, 'Oven Cleaner', 81, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (277, 'Baking Soda', 53, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (278, 'White Vinegar', 116, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (279, 'Vacuum', 274, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (280, 'Essential Oils', 290, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (281, 'Carpet Cleaner', 97, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (282, 'Carpet Cleaner', 457, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (283, 'Baking Soda', 474, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (284, 'Dish Soap', 93, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (285, 'Shoe Deodorizer', 453, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (286, 'Grout Cleaner', 455, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (287, 'Trash Bags', 262, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (288, 'Oven Cleaner', 77, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (289, 'Rubber Gloves', 390, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (290, 'Grout Cleaner', 284, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (291, 'Window Squeegee', 207, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (292, 'Air Freshener', 13, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (293, 'Carpet Cleaner', 251, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (294, 'Trash Bags', 194, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (295, 'Wood Polish', 148, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (296, 'All-Purpose Cleaner', 386, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (297, 'Fabric Softener', 487, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (298, 'Stove Degreaser', 386, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (299, 'Scrub Brushes', 239, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (300, 'Essential Oils', 77, 'Storage A');
commit;
prompt 300 records committed...
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (301, 'Carpet Cleaner', 273, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (302, 'Shoe Deodorizer', 239, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (303, 'Window Squeegee', 393, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (304, 'Bleach', 380, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (305, 'Shoe Deodorizer', 488, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (306, 'Carpet Cleaner', 229, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (307, 'Stainless Steel Cleaner', 247, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (308, 'Vacuum', 159, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (309, 'Wood Polish', 217, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (310, 'Hand Sanitizer', 252, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (311, 'Laundry Detergent', 425, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (312, 'Detergent', 420, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (313, 'Lint Roller', 143, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (314, 'Shoe Deodorizer', 430, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (315, 'Glass Cleaner', 102, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (316, 'Mop', 411, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (317, 'Oven Cleaner', 277, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (318, 'Wood Polish', 284, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (319, 'Lint Roller', 240, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (320, 'Air Freshener', 328, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (321, 'Floor Polish', 241, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (322, 'Detergent', 169, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (323, 'Trash Bags', 380, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (324, 'Paper Towels', 348, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (325, 'Dryer Sheets', 95, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (326, 'Disinfectant', 108, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (327, 'Paper Towels', 72, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (328, 'Trash Bags', 26, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (329, 'Shoe Deodorizer', 358, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (330, 'Glass Cleaner', 161, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (331, 'Dryer Sheets', 450, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (332, 'Broom', 292, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (333, 'Disinfectant', 447, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (334, 'Rubber Gloves', 181, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (335, 'Wood Polish', 86, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (336, 'Grout Cleaner', 64, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (337, 'Microfiber Cloths', 307, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (338, 'Lemon Juice', 378, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (339, 'All-Purpose Cleaner', 25, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (340, 'Broom', 261, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (341, 'Shoe Deodorizer', 294, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (342, 'Oven Cleaner', 303, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (343, 'Dish Soap', 110, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (344, 'Baking Soda', 109, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (345, 'Paper Towels', 399, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (346, 'Dish Soap', 378, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (347, 'Baking Soda', 261, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (348, 'Window Squeegee', 256, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (349, 'Laundry Detergent', 495, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (350, 'All-Purpose Cleaner', 388, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (351, 'Trash Bags', 375, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (352, 'Mop', 278, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (353, 'Laundry Detergent', 11, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (354, 'Broom', 284, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (355, 'Rubber Gloves', 461, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (356, 'Lint Roller', 437, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (357, 'Scrub Brushes', 423, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (358, 'Sponges', 419, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (359, 'Dryer Sheets', 326, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (360, 'Floor Polish', 418, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (361, 'Air Freshener', 363, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (362, 'Oven Cleaner', 435, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (363, 'Lint Roller', 208, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (364, 'Mop', 242, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (365, 'Scrub Brushes', 267, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (366, 'Laundry Detergent', 49, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (367, 'Paper Towels', 402, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (368, 'Carpet Cleaner', 276, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (369, 'Sponges', 199, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (370, 'Hand Sanitizer', 219, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (371, 'Bleach', 70, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (372, 'Window Squeegee', 346, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (373, 'Broom', 171, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (374, 'Lemon Juice', 336, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (375, 'Vacuum', 415, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (376, 'Essential Oils', 66, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (377, 'Bleach', 101, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (378, 'Broom', 483, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (379, 'Disinfectant', 352, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (380, 'All-Purpose Cleaner', 117, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (381, 'Stove Degreaser', 136, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (382, 'Lemon Juice', 217, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (383, 'Stove Degreaser', 420, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (384, 'Mop', 460, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (385, 'White Vinegar', 197, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (386, 'Dish Soap', 222, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (387, 'Laundry Detergent', 386, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (388, 'Broom', 380, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (389, 'Fabric Softener', 205, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (390, 'Glass Cleaner', 18, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (391, 'Sponges', 129, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (392, 'Vacuum', 19, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (393, 'Shoe Deodorizer', 111, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (394, 'Lemon Juice', 274, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (395, 'Essential Oils', 298, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (396, 'Detergent', 193, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (397, 'All-Purpose Cleaner', 425, 'Storage A');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (398, 'Floor Polish', 203, 'Storage B');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (399, 'Laundry Detergent', 330, 'Storage C');
insert into CLEANING_SUPPLY (suid, name, total_quantity, location)
values (400, 'Wood Polish', 401, 'Storage A');
commit;
prompt 400 records loaded
prompt Loading ROOM...
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (1, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (2, 'Double', 'Vacant', 'Dirty');
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
values (8, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (9, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (10, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (11, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (12, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (13, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (14, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (15, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (16, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (17, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (18, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (19, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (20, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (21, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (22, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (23, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (24, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (25, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (26, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (27, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (28, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (29, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (30, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (31, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (32, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (33, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (34, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (35, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (36, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (37, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (38, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (39, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (40, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (41, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (42, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (43, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (44, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (45, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (46, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (47, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (48, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (49, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (50, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (51, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (52, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (53, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (54, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (55, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (56, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (57, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (58, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (59, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (60, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (61, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (62, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (63, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (64, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (65, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (66, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (67, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (68, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (69, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (70, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (71, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (72, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (73, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (74, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (75, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (76, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (77, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (78, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (79, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (80, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (81, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (82, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (83, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (84, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (85, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (86, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (87, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (88, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (89, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (90, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (91, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (92, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (93, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (94, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (95, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (96, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (97, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (98, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (99, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (100, 'Suite', 'Vacant', 'Dirty');
commit;
prompt 100 records committed...
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (101, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (102, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (103, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (104, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (105, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (106, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (107, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (108, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (109, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (110, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (111, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (112, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (113, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (114, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (115, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (116, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (117, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (118, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (119, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (120, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (121, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (122, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (123, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (124, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (125, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (126, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (127, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (128, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (129, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (130, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (131, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (132, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (133, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (134, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (135, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (136, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (137, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (138, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (139, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (140, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (141, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (142, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (143, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (144, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (145, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (146, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (147, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (148, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (149, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (150, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (151, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (152, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (153, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (154, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (155, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (156, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (157, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (158, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (159, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (160, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (161, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (162, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (163, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (164, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (165, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (166, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (167, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (168, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (169, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (170, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (171, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (172, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (173, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (174, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (175, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (176, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (177, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (178, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (179, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (180, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (181, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (182, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (183, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (184, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (185, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (186, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (187, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (188, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (189, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (190, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (191, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (192, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (193, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (194, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (195, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (196, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (197, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (198, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (199, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (200, 'Double', 'Occupied', 'Clean');
commit;
prompt 200 records committed...
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (201, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (202, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (203, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (204, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (205, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (206, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (207, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (208, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (209, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (210, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (211, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (212, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (213, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (214, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (215, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (216, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (217, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (218, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (219, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (220, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (221, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (222, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (223, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (224, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (225, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (226, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (227, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (228, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (229, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (230, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (231, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (232, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (233, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (234, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (235, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (236, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (237, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (238, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (239, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (240, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (241, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (242, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (243, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (244, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (245, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (246, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (247, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (248, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (249, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (250, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (251, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (252, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (253, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (254, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (255, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (256, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (257, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (258, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (259, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (260, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (261, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (262, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (263, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (264, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (265, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (266, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (267, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (268, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (269, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (270, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (271, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (272, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (273, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (274, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (275, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (276, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (277, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (278, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (279, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (280, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (281, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (282, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (283, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (284, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (285, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (286, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (287, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (288, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (289, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (290, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (291, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (292, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (293, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (294, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (295, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (296, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (297, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (298, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (299, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (300, 'Suite', 'Vacant', 'Dirty');
commit;
prompt 300 records committed...
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (301, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (302, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (303, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (304, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (305, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (306, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (307, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (308, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (309, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (310, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (311, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (312, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (313, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (314, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (315, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (316, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (317, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (318, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (319, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (320, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (321, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (322, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (323, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (324, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (325, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (326, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (327, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (328, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (329, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (330, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (331, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (332, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (333, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (334, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (335, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (336, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (337, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (338, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (339, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (340, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (341, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (342, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (343, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (344, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (345, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (346, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (347, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (348, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (349, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (350, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (351, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (352, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (353, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (354, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (355, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (356, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (357, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (358, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (359, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (360, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (361, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (362, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (363, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (364, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (365, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (366, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (367, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (368, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (369, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (370, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (371, 'Single', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (372, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (373, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (374, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (375, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (376, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (377, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (378, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (379, 'Double', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (380, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (381, 'Double', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (382, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (383, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (384, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (385, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (386, 'Single', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (387, 'Suite', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (388, 'Double', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (389, 'Suite', 'Occupied', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (390, 'Suite', 'Vacant', 'Dirty');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (391, 'Single', 'Vacant', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (392, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (393, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (394, 'Double', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (395, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (396, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (397, 'Single', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (398, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (399, 'Suite', 'Occupied', 'Clean');
insert into ROOM (rid, type, occupancy_status, cleaning_status)
values (400, 'Suite', 'Occupied', 'Dirty');
commit;
prompt 400 records loaded
prompt Loading STAFF_MEMBER...
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (1, 'John', 'Doe');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (2, 'Jane', 'Smith');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (3, 'Alice', 'Johnson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (4, 'Bob', 'Williams');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (5, 'Charlie', 'Brown');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (6, 'David', 'Jones');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (7, 'Emma', 'Garcia');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (8, 'Frank', 'Martinez');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (9, 'Grace', 'Rodriguez');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (10, 'Hank', 'Lopez');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (11, 'Elvis', 'Yorn');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (12, 'Maureen', 'Farina');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (13, 'Natacha', 'Quinn');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (14, 'Lily', 'Esposito');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (15, 'Neve', 'Gugino');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (16, 'Quentin', 'Quinones');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (17, 'Larenz', 'Costa');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (18, 'Xander', 'Church');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (19, 'Jane', 'Whitley');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (20, 'Nicole', 'Allan');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (21, 'Roscoe', 'Willis');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (22, 'Alfred', 'Streep');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (23, 'Courtney', 'Plimpton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (24, 'Ronnie', 'Plowright');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (25, 'Rickie', 'Santa Rosa');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (26, 'Eric', 'Lynch');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (27, 'Vertical', 'Lapointe');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (28, 'Nicole', 'Franks');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (29, 'Veruca', 'Parish');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (30, 'Jeff', 'Schwimmer');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (31, 'Devon', 'Douglas');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (32, 'Gordie', 'Raybon');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (33, 'Quentin', 'Hopkins');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (34, 'Dick', 'McCormack');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (35, 'Marty', 'Devine');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (36, 'Ricky', 'O''Hara');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (37, 'Geoff', 'Frampton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (38, 'Geggy', 'Levine');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (39, 'Emilio', 'Pitt');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (40, 'Gena', 'Penn');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (41, 'Gabriel', 'Deejay');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (42, 'Isaiah', 'Gill');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (43, 'Leon', 'Steenburgen');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (44, 'Geena', 'Haggard');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (45, 'Nora', 'Vicious');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (46, 'Cate', 'Abraham');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (47, 'Mekhi', 'Checker');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (48, 'Lucy', 'Vannelli');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (49, 'Sammy', 'Shalhoub');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (50, 'Joe', 'Mars');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (51, 'Dom', 'Sample');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (52, 'Edie', 'Tennison');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (53, 'Garry', 'Spiner');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (54, 'Mary', 'Atkins');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (55, 'Jesse', 'Rankin');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (56, 'Gary', 'Law');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (57, 'Celia', 'Trejo');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (58, 'Melanie', 'Skaggs');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (59, 'Joaquim', 'Sisto');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (60, 'Mary', 'Vince');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (61, 'Rachid', 'Griffiths');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (62, 'Hazel', 'Foxx');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (63, 'Loren', 'Harris');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (64, 'Julio', 'Gayle');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (65, 'Glenn', 'Arquette');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (66, 'Danny', 'Schiavelli');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (67, 'Claude', 'Union');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (68, 'Thomas', 'Paige');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (69, 'Wallace', 'Harnes');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (70, 'Corey', 'Postlethwaite');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (71, 'Maury', 'Hurt');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (72, 'Ellen', 'Hewitt');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (73, 'Tracy', 'Chung');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (74, 'Shannon', 'Garza');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (75, 'Larenz', 'Reid');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (76, 'Madeline', 'Wakeling');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (77, 'Christian', 'Cockburn');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (78, 'Kristin', 'Horton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (79, 'Rhett', 'Griggs');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (80, 'Julianne', 'Walker');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (81, 'Lupe', 'Lachey');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (82, 'Connie', 'Plimpton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (83, 'Rik', 'Landau');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (84, 'Judd', 'Holland');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (85, 'Parker', 'Zahn');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (86, 'Vickie', 'Cage');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (87, 'Roddy', 'Klugh');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (88, 'Armin', 'Mirren');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (89, 'Cliff', 'Bracco');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (90, 'Brian', 'Sherman');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (91, 'Davy', 'LaSalle');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (92, 'Clarence', 'Ryder');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (93, 'Dianne', 'Stamp');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (94, 'Lou', 'Craven');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (95, 'Vincent', 'McCoy');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (96, 'Hope', 'Phillips');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (97, 'Miko', 'Liu');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (98, 'Dustin', 'Hart');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (99, 'Ani', 'Watson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (100, 'Lance', 'Witherspoon');
commit;
prompt 100 records committed...
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (101, 'Frederic', 'Chambers');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (102, 'Karen', 'Vega');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (103, 'Victor', 'Orlando');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (104, 'Teena', 'Fichtner');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (105, 'Balthazar', 'O''Donnell');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (106, 'Kimberly', 'Balk');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (107, 'Isaiah', 'Mazzello');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (108, 'Carla', 'Frakes');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (109, 'Maceo', 'Fishburne');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (110, 'Corey', 'Perry');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (111, 'Shelby', 'Melvin');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (112, 'Illeana', 'LaPaglia');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (113, 'Howie', 'Diggs');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (114, 'Horace', 'Neeson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (115, 'Garry', 'Freeman');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (116, 'Lloyd', 'Pfeiffer');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (117, 'Neneh', 'McDiarmid');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (118, 'Alex', 'Brosnan');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (119, 'Beth', 'Skarsgard');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (120, 'Katie', 'Mazzello');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (121, 'Loretta', 'Ontiveros');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (122, 'Jena', 'Hampton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (123, 'Lennie', 'Ball');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (124, 'Catherine', 'Shand');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (125, 'Brent', 'Paltrow');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (126, 'Marley', 'Dafoe');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (127, 'Denzel', 'Blaine');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (128, 'Carlene', 'Costa');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (129, 'Jane', 'McKellen');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (130, 'Pablo', 'Wopat');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (131, 'Lynn', 'Crosby');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (132, 'Willie', 'Gaynor');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (133, 'Carol', 'Horton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (134, 'Gwyneth', 'Rapaport');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (135, 'Claire', 'Visnjic');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (136, 'Simon', 'Liu');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (137, 'Juice', 'Porter');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (138, 'Fairuza', 'Washington');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (139, 'Mae', 'Logue');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (140, 'Rhys', 'Begley');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (141, 'Shannon', 'Kutcher');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (142, 'Richard', 'Danes');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (143, 'Sally', 'Playboys');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (144, 'Kirk', 'Mann');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (145, 'Buddy', 'Guilfoyle');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (146, 'Kylie', 'Northam');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (147, 'Garland', 'Rio');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (148, 'Angie', 'Cantrell');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (149, 'Bridgette', 'Bonham');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (150, 'Angelina', 'Cornell');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (151, 'Elias', 'Whitman');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (152, 'Jeremy', 'Condition');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (153, 'Emm', 'Dukakis');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (154, 'Morris', 'McDormand');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (155, 'Andie', 'Dzundza');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (156, 'Lee', 'Davis');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (157, 'Emily', 'McCann');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (158, 'Elle', 'Hawke');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (159, 'Jose', 'Fonda');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (160, 'Yolanda', 'Harper');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (161, 'Maria', 'Clarkson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (162, 'Davey', 'Macht');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (163, 'Jonny Lee', 'Rooker');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (164, 'Stephanie', 'Rapaport');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (165, 'Ivan', 'Field');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (166, 'Chrissie', 'White');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (167, 'Jake', 'Armatrading');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (168, 'Andy', 'Latifah');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (169, 'Donna', 'Mantegna');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (170, 'Garland', 'Scheider');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (171, 'Rod', 'Barrymore');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (172, 'Raymond', 'Willis');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (173, 'Alfred', 'Buscemi');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (174, 'Edward', 'Monk');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (175, 'Tom', 'Rickles');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (176, 'Faye', 'Goodman');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (177, 'Sally', 'Herrmann');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (178, 'Gabrielle', 'Fierstein');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (179, 'Larnelle', 'Marx');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (180, 'Lloyd', 'Frakes');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (181, 'Boyd', 'Coleman');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (182, 'Kelli', 'Shatner');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (183, 'Mint', 'Durning');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (184, 'Sheena', 'Irving');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (185, 'Jeremy', 'Pressly');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (186, 'Bradley', 'Shepherd');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (187, 'Jim', 'Dickinson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (188, 'Nikka', 'Humphrey');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (189, 'Yolanda', 'Mazzello');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (190, 'Manu', 'Zappacosta');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (191, 'Andre', 'Aniston');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (192, 'Louise', 'Ceasar');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (193, 'Jonny Lee', 'Gugino');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (194, 'Lari', 'Derringer');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (195, 'Lance', 'Belushi');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (196, 'Bebe', 'Isaak');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (197, 'Jesse', 'Bridges');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (198, 'Kasey', 'Perrineau');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (199, 'Brooke', 'Waite');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (200, 'Kylie', 'Summer');
commit;
prompt 200 records committed...
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (201, 'Mike', 'Osmond');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (202, 'Ahmad', 'McDowall');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (203, 'Viggo', 'Saxon');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (204, 'Julianne', 'Channing');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (205, 'Ice', 'Sartain');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (206, 'Rhona', 'Schneider');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (207, 'Madeline', 'Bullock');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (208, 'Jake', 'Gold');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (209, 'Udo', 'Chan');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (210, 'Nik', 'Harris');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (211, 'Wendy', 'Rain');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (212, 'Cole', 'Church');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (213, 'Anthony', 'Schiff');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (214, 'Cole', 'Pryce');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (215, 'Robin', 'Harper');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (216, 'Angela', 'O''Keefe');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (217, 'Juan', 'Clayton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (218, 'Daniel', 'Pollak');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (219, 'Stanley', 'Duschel');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (220, 'Charlize', 'Cassel');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (221, 'Ned', 'Van Shelton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (222, 'Tilda', 'MacLachlan');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (223, 'Karen', 'Chaykin');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (224, 'Oded', 'Magnuson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (225, 'Judge', 'Newton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (226, 'Rick', 'King');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (227, 'Terrence', 'Ontiveros');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (228, 'Merillee', 'Warren');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (229, 'Patrick', 'Hampton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (230, 'Donal', 'Dunaway');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (231, 'Stewart', 'Winger');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (232, 'Philip', 'Maxwell');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (233, 'Don', 'Rockwell');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (234, 'Whoopi', 'Lowe');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (235, 'Donna', 'Raitt');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (236, 'Maceo', 'Stormare');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (237, 'Louise', 'Isaak');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (238, 'Rhys', 'Tyler');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (239, 'Lisa', 'Garcia');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (240, 'Roscoe', 'Eastwood');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (241, 'Annette', 'Mortensen');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (242, 'Teena', 'Warburton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (243, 'Suzi', 'LaSalle');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (244, 'Belinda', 'Robinson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (245, 'Marisa', 'Craddock');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (246, 'Angie', 'Soda');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (247, 'Johnny', 'Davidtz');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (248, 'Joe', 'Gunton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (249, 'Benicio', 'Uggams');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (250, 'Rene', 'Brown');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (251, 'Maxine', 'Thornton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (252, 'Miguel', 'English');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (253, 'Beth', 'Chappelle');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (254, 'Reese', 'Sevenfold');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (255, 'Norm', 'Underwood');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (256, 'Joaquim', 'Willard');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (257, 'Heath', 'Oldman');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (258, 'Freddie', 'Wagner');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (259, 'Wes', 'Keitel');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (260, 'Victoria', 'Andrews');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (261, 'Art', 'Williams');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (262, 'Kimberly', 'Dickinson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (263, 'Morgan', 'Oates');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (264, 'Garland', 'Rea');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (265, 'Rosanna', 'Sobieski');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (266, 'Chubby', 'Chan');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (267, 'Buddy', 'Arquette');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (268, 'Alessandro', 'Quinones');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (269, 'Irene', 'Condition');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (270, 'Trini', 'Goldberg');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (271, 'Ronnie', 'Eckhart');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (272, 'Oded', 'Branch');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (273, 'Whoopi', 'Chilton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (274, 'Holly', 'Ferrer');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (275, 'Rawlins', 'Gryner');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (276, 'Nora', 'Loveless');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (277, 'Naomi', 'Robinson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (278, 'Garland', 'Haynes');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (279, 'Miriam', 'Vance');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (280, 'Suzi', 'Glover');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (281, 'CeCe', 'Mitchell');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (282, 'Scarlett', 'Buffalo');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (283, 'Elijah', 'Warwick');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (284, 'Elijah', 'Belles');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (285, 'Brenda', 'Wopat');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (286, 'Vondie', 'Shand');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (287, 'Rene', 'Sawa');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (288, 'Candice', 'Yorn');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (289, 'Cevin', 'Garfunkel');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (290, 'Mos', 'Mann');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (291, 'Greg', 'McConaughey');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (292, 'Martha', 'Neil');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (293, 'Jack', 'Weir');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (294, 'Natasha', 'Keitel');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (295, 'Martin', 'Renfro');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (296, 'Carlos', 'Sampson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (297, 'Jane', 'Carlisle');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (298, 'Neil', 'Cattrall');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (299, 'Delbert', 'Broza');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (300, 'Talvin', 'Loring');
commit;
prompt 300 records committed...
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (301, 'Timothy', 'Harrison');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (302, 'Collin', 'Raye');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (303, 'Larry', 'Arkenstone');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (304, 'Larnelle', 'Armstrong');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (305, 'Spencer', 'Drive');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (306, 'Scott', 'Winger');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (307, 'Harold', 'Bloch');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (308, 'Saul', 'Boyle');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (309, 'Howard', 'Diddley');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (310, 'Kirk', 'Shalhoub');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (311, 'Nik', 'Tsettos');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (312, 'Gin', 'Myles');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (313, 'Samantha', 'Brooke');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (314, 'Natacha', 'Branch');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (315, 'Mac', 'Kinski');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (316, 'Embeth', 'Tillis');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (317, 'Vanessa', 'Kidman');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (318, 'Leonardo', 'Shaye');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (319, 'Angelina', 'Lavigne');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (320, 'Elizabeth', 'Kane');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (321, 'Ahmad', 'Sewell');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (322, 'Pablo', 'Lawrence');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (323, 'Timothy', 'Harrison');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (324, 'Joseph', 'Bonneville');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (325, 'Benicio', 'Norton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (326, 'Hal', 'Arkin');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (327, 'Casey', 'Farrow');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (328, 'Eric', 'Haslam');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (329, 'Gilberto', 'Bragg');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (330, 'Vince', 'Leguizamo');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (331, 'Kyle', 'Norton');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (332, 'Ming-Na', 'Gleeson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (333, 'Judy', 'Phoenix');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (334, 'Ned', 'Wopat');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (335, 'Debi', 'Trevino');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (336, 'Will', 'MacDonald');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (337, 'Blair', 'Raitt');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (338, 'Edgar', 'Sanders');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (339, 'Naomi', 'Moorer');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (340, 'Jill', 'Farina');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (341, 'CeCe', 'Magnuson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (342, 'Holland', 'Silverman');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (343, 'Brittany', 'Shearer');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (344, 'Bebe', 'Lemmon');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (345, 'Mark', 'Kershaw');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (346, 'Roberta', 'O''Keefe');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (347, 'Nancy', 'Rush');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (348, 'Debbie', 'Leguizamo');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (349, 'Brittany', 'Sossamon');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (350, 'Salma', 'Goodall');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (351, 'Benicio', 'Woods');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (352, 'Penelope', 'Kier');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (353, 'Jimmie', 'Mac');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (354, 'Laurie', 'Crystal');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (355, 'Robbie', 'Kristofferson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (356, 'Martin', 'Shorter');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (357, 'Lea', 'Mulroney');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (358, 'Jake', 'Dench');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (359, 'Seann', 'MacNeil');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (360, 'Cuba', 'Hunter');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (361, 'Cathy', 'Judd');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (362, 'Matthew', 'Lapointe');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (363, 'Deborah', 'Michaels');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (364, 'Warren', 'Kotto');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (365, 'Mickey', 'Arjona');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (366, 'Suzanne', 'Devine');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (367, 'Lindsay', 'Lynn');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (368, 'Adina', 'Harris');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (369, 'Dar', 'Morse');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (370, 'Rose', 'Sampson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (371, 'Vin', 'Douglas');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (372, 'Parker', 'England');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (373, 'Latin', 'Tinsley');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (374, 'Taryn', 'Hawkins');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (375, 'Mel', 'Mars');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (376, 'Lindsay', 'Lennix');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (377, 'Carolyn', 'Branch');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (378, 'Will', 'Paymer');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (379, 'Ryan', 'Idle');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (380, 'Stanley', 'Sepulveda');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (381, 'Dom', 'Navarro');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (382, 'Hazel', 'Colin Young');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (383, 'Ozzy', 'Kidman');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (384, 'Mac', 'Hall');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (385, 'Davis', 'Connelly');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (386, 'Jonathan', 'Gano');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (387, 'Guy', 'Robbins');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (388, 'Jackie', 'Nunn');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (389, 'Maria', 'Popper');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (390, 'Vertical', 'Patillo');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (391, 'Night', 'Belle');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (392, 'Judi', 'Boyle');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (393, 'Lucy', 'Dawson');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (394, 'Lois', 'McGill');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (395, 'Ozzy', 'Choice');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (396, 'Petula', 'Leguizamo');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (397, 'Earl', 'Kennedy');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (398, 'John', 'Street');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (399, 'Leslie', 'Redford');
insert into STAFF_MEMBER (sid, first_name, last_name_)
values (400, 'Rebecca', 'LaSalle');
commit;
prompt 400 records loaded
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
values (11, 'Completed', 250, 159);
insert into CLEANING_TASK (tid, status, rid, sid)
values (12, 'Completed', 281, 249);
insert into CLEANING_TASK (tid, status, rid, sid)
values (13, 'Completed', 328, 346);
insert into CLEANING_TASK (tid, status, rid, sid)
values (14, 'Completed', 83, 138);
insert into CLEANING_TASK (tid, status, rid, sid)
values (15, 'Pending', 219, 122);
insert into CLEANING_TASK (tid, status, rid, sid)
values (16, 'Completed', 327, 135);
insert into CLEANING_TASK (tid, status, rid, sid)
values (17, 'Completed', 137, 311);
insert into CLEANING_TASK (tid, status, rid, sid)
values (18, 'Pending', 366, 223);
insert into CLEANING_TASK (tid, status, rid, sid)
values (19, 'Pending', 331, 346);
insert into CLEANING_TASK (tid, status, rid, sid)
values (20, 'Pending', 264, 355);
insert into CLEANING_TASK (tid, status, rid, sid)
values (21, 'Pending', 219, 131);
insert into CLEANING_TASK (tid, status, rid, sid)
values (22, 'Pending', 258, 1);
insert into CLEANING_TASK (tid, status, rid, sid)
values (23, 'Pending', 240, 195);
insert into CLEANING_TASK (tid, status, rid, sid)
values (24, 'Pending', 263, 269);
insert into CLEANING_TASK (tid, status, rid, sid)
values (25, 'Pending', 1, 394);
insert into CLEANING_TASK (tid, status, rid, sid)
values (26, 'Completed', 54, 101);
insert into CLEANING_TASK (tid, status, rid, sid)
values (27, 'Pending', 13, 360);
insert into CLEANING_TASK (tid, status, rid, sid)
values (28, 'Pending', 25, 305);
insert into CLEANING_TASK (tid, status, rid, sid)
values (29, 'Pending', 89, 48);
insert into CLEANING_TASK (tid, status, rid, sid)
values (30, 'Pending', 141, 345);
insert into CLEANING_TASK (tid, status, rid, sid)
values (31, 'Completed', 321, 214);
insert into CLEANING_TASK (tid, status, rid, sid)
values (32, 'Completed', 251, 205);
insert into CLEANING_TASK (tid, status, rid, sid)
values (33, 'Pending', 316, 58);
insert into CLEANING_TASK (tid, status, rid, sid)
values (34, 'Completed', 241, 78);
insert into CLEANING_TASK (tid, status, rid, sid)
values (35, 'Completed', 398, 339);
insert into CLEANING_TASK (tid, status, rid, sid)
values (36, 'Completed', 346, 242);
insert into CLEANING_TASK (tid, status, rid, sid)
values (37, 'Completed', 233, 241);
insert into CLEANING_TASK (tid, status, rid, sid)
values (38, 'Pending', 126, 121);
insert into CLEANING_TASK (tid, status, rid, sid)
values (39, 'Completed', 324, 336);
insert into CLEANING_TASK (tid, status, rid, sid)
values (40, 'Completed', 127, 150);
insert into CLEANING_TASK (tid, status, rid, sid)
values (41, 'Completed', 139, 181);
insert into CLEANING_TASK (tid, status, rid, sid)
values (42, 'Pending', 65, 343);
insert into CLEANING_TASK (tid, status, rid, sid)
values (43, 'Pending', 258, 335);
insert into CLEANING_TASK (tid, status, rid, sid)
values (44, 'Completed', 172, 85);
insert into CLEANING_TASK (tid, status, rid, sid)
values (45, 'Pending', 277, 302);
insert into CLEANING_TASK (tid, status, rid, sid)
values (46, 'Pending', 172, 235);
insert into CLEANING_TASK (tid, status, rid, sid)
values (47, 'Pending', 44, 339);
insert into CLEANING_TASK (tid, status, rid, sid)
values (48, 'Completed', 51, 197);
insert into CLEANING_TASK (tid, status, rid, sid)
values (49, 'Pending', 215, 330);
insert into CLEANING_TASK (tid, status, rid, sid)
values (50, 'Completed', 12, 329);
insert into CLEANING_TASK (tid, status, rid, sid)
values (51, 'Pending', 317, 282);
insert into CLEANING_TASK (tid, status, rid, sid)
values (52, 'Completed', 88, 302);
insert into CLEANING_TASK (tid, status, rid, sid)
values (53, 'Pending', 272, 325);
insert into CLEANING_TASK (tid, status, rid, sid)
values (54, 'Pending', 146, 187);
insert into CLEANING_TASK (tid, status, rid, sid)
values (55, 'Pending', 394, 19);
insert into CLEANING_TASK (tid, status, rid, sid)
values (56, 'Completed', 36, 29);
insert into CLEANING_TASK (tid, status, rid, sid)
values (57, 'Pending', 97, 325);
insert into CLEANING_TASK (tid, status, rid, sid)
values (58, 'Completed', 254, 10);
insert into CLEANING_TASK (tid, status, rid, sid)
values (59, 'Completed', 337, 137);
insert into CLEANING_TASK (tid, status, rid, sid)
values (60, 'Completed', 87, 334);
insert into CLEANING_TASK (tid, status, rid, sid)
values (61, 'Pending', 52, 358);
insert into CLEANING_TASK (tid, status, rid, sid)
values (62, 'Pending', 110, 168);
insert into CLEANING_TASK (tid, status, rid, sid)
values (63, 'Pending', 249, 203);
insert into CLEANING_TASK (tid, status, rid, sid)
values (64, 'Pending', 196, 143);
insert into CLEANING_TASK (tid, status, rid, sid)
values (65, 'Pending', 310, 280);
insert into CLEANING_TASK (tid, status, rid, sid)
values (66, 'Completed', 246, 311);
insert into CLEANING_TASK (tid, status, rid, sid)
values (67, 'Completed', 18, 367);
insert into CLEANING_TASK (tid, status, rid, sid)
values (68, 'Completed', 178, 32);
insert into CLEANING_TASK (tid, status, rid, sid)
values (69, 'Completed', 318, 202);
insert into CLEANING_TASK (tid, status, rid, sid)
values (70, 'Pending', 383, 176);
insert into CLEANING_TASK (tid, status, rid, sid)
values (71, 'Pending', 353, 292);
insert into CLEANING_TASK (tid, status, rid, sid)
values (72, 'Pending', 309, 96);
insert into CLEANING_TASK (tid, status, rid, sid)
values (73, 'Pending', 144, 352);
insert into CLEANING_TASK (tid, status, rid, sid)
values (74, 'Completed', 255, 329);
insert into CLEANING_TASK (tid, status, rid, sid)
values (75, 'Completed', 122, 364);
insert into CLEANING_TASK (tid, status, rid, sid)
values (76, 'Completed', 320, 115);
insert into CLEANING_TASK (tid, status, rid, sid)
values (77, 'Completed', 141, 131);
insert into CLEANING_TASK (tid, status, rid, sid)
values (78, 'Completed', 328, 362);
insert into CLEANING_TASK (tid, status, rid, sid)
values (79, 'Pending', 256, 140);
insert into CLEANING_TASK (tid, status, rid, sid)
values (80, 'Pending', 314, 177);
insert into CLEANING_TASK (tid, status, rid, sid)
values (81, 'Completed', 268, 228);
insert into CLEANING_TASK (tid, status, rid, sid)
values (82, 'Completed', 8, 195);
insert into CLEANING_TASK (tid, status, rid, sid)
values (83, 'Pending', 215, 381);
insert into CLEANING_TASK (tid, status, rid, sid)
values (84, 'Completed', 78, 56);
insert into CLEANING_TASK (tid, status, rid, sid)
values (85, 'Completed', 88, 135);
insert into CLEANING_TASK (tid, status, rid, sid)
values (86, 'Completed', 266, 193);
insert into CLEANING_TASK (tid, status, rid, sid)
values (87, 'Pending', 274, 253);
insert into CLEANING_TASK (tid, status, rid, sid)
values (88, 'Pending', 135, 109);
insert into CLEANING_TASK (tid, status, rid, sid)
values (89, 'Completed', 176, 331);
insert into CLEANING_TASK (tid, status, rid, sid)
values (90, 'Completed', 67, 348);
insert into CLEANING_TASK (tid, status, rid, sid)
values (91, 'Completed', 244, 199);
insert into CLEANING_TASK (tid, status, rid, sid)
values (92, 'Pending', 4, 193);
insert into CLEANING_TASK (tid, status, rid, sid)
values (93, 'Pending', 180, 88);
insert into CLEANING_TASK (tid, status, rid, sid)
values (94, 'Pending', 117, 43);
insert into CLEANING_TASK (tid, status, rid, sid)
values (95, 'Pending', 73, 317);
insert into CLEANING_TASK (tid, status, rid, sid)
values (96, 'Pending', 17, 366);
insert into CLEANING_TASK (tid, status, rid, sid)
values (97, 'Completed', 48, 350);
insert into CLEANING_TASK (tid, status, rid, sid)
values (98, 'Pending', 336, 39);
insert into CLEANING_TASK (tid, status, rid, sid)
values (99, 'Pending', 336, 110);
insert into CLEANING_TASK (tid, status, rid, sid)
values (100, 'Completed', 345, 63);
commit;
prompt 100 records committed...
insert into CLEANING_TASK (tid, status, rid, sid)
values (101, 'Completed', 269, 47);
insert into CLEANING_TASK (tid, status, rid, sid)
values (102, 'Pending', 359, 11);
insert into CLEANING_TASK (tid, status, rid, sid)
values (103, 'Completed', 281, 49);
insert into CLEANING_TASK (tid, status, rid, sid)
values (104, 'Pending', 203, 124);
insert into CLEANING_TASK (tid, status, rid, sid)
values (105, 'Completed', 246, 300);
insert into CLEANING_TASK (tid, status, rid, sid)
values (106, 'Completed', 78, 263);
insert into CLEANING_TASK (tid, status, rid, sid)
values (107, 'Pending', 16, 234);
insert into CLEANING_TASK (tid, status, rid, sid)
values (108, 'Completed', 275, 160);
insert into CLEANING_TASK (tid, status, rid, sid)
values (109, 'Completed', 42, 268);
insert into CLEANING_TASK (tid, status, rid, sid)
values (110, 'Completed', 119, 362);
insert into CLEANING_TASK (tid, status, rid, sid)
values (111, 'Completed', 320, 370);
insert into CLEANING_TASK (tid, status, rid, sid)
values (112, 'Completed', 326, 232);
insert into CLEANING_TASK (tid, status, rid, sid)
values (113, 'Completed', 26, 101);
insert into CLEANING_TASK (tid, status, rid, sid)
values (114, 'Pending', 273, 310);
insert into CLEANING_TASK (tid, status, rid, sid)
values (115, 'Pending', 57, 157);
insert into CLEANING_TASK (tid, status, rid, sid)
values (116, 'Completed', 53, 326);
insert into CLEANING_TASK (tid, status, rid, sid)
values (117, 'Pending', 248, 150);
insert into CLEANING_TASK (tid, status, rid, sid)
values (118, 'Completed', 384, 394);
insert into CLEANING_TASK (tid, status, rid, sid)
values (119, 'Completed', 72, 108);
insert into CLEANING_TASK (tid, status, rid, sid)
values (120, 'Pending', 128, 11);
insert into CLEANING_TASK (tid, status, rid, sid)
values (121, 'Pending', 282, 88);
insert into CLEANING_TASK (tid, status, rid, sid)
values (122, 'Pending', 290, 343);
insert into CLEANING_TASK (tid, status, rid, sid)
values (123, 'Pending', 155, 93);
insert into CLEANING_TASK (tid, status, rid, sid)
values (124, 'Pending', 101, 355);
insert into CLEANING_TASK (tid, status, rid, sid)
values (125, 'Completed', 357, 107);
insert into CLEANING_TASK (tid, status, rid, sid)
values (126, 'Completed', 342, 126);
insert into CLEANING_TASK (tid, status, rid, sid)
values (127, 'Pending', 156, 223);
insert into CLEANING_TASK (tid, status, rid, sid)
values (128, 'Pending', 303, 278);
insert into CLEANING_TASK (tid, status, rid, sid)
values (129, 'Completed', 316, 41);
insert into CLEANING_TASK (tid, status, rid, sid)
values (130, 'Completed', 89, 7);
insert into CLEANING_TASK (tid, status, rid, sid)
values (131, 'Pending', 22, 373);
insert into CLEANING_TASK (tid, status, rid, sid)
values (132, 'Pending', 217, 33);
insert into CLEANING_TASK (tid, status, rid, sid)
values (133, 'Pending', 233, 364);
insert into CLEANING_TASK (tid, status, rid, sid)
values (134, 'Completed', 44, 20);
insert into CLEANING_TASK (tid, status, rid, sid)
values (135, 'Completed', 47, 357);
insert into CLEANING_TASK (tid, status, rid, sid)
values (136, 'Pending', 271, 189);
insert into CLEANING_TASK (tid, status, rid, sid)
values (137, 'Completed', 219, 342);
insert into CLEANING_TASK (tid, status, rid, sid)
values (138, 'Completed', 345, 253);
insert into CLEANING_TASK (tid, status, rid, sid)
values (139, 'Completed', 312, 58);
insert into CLEANING_TASK (tid, status, rid, sid)
values (140, 'Completed', 103, 195);
insert into CLEANING_TASK (tid, status, rid, sid)
values (141, 'Pending', 242, 269);
insert into CLEANING_TASK (tid, status, rid, sid)
values (142, 'Completed', 193, 318);
insert into CLEANING_TASK (tid, status, rid, sid)
values (143, 'Pending', 2, 113);
insert into CLEANING_TASK (tid, status, rid, sid)
values (144, 'Pending', 68, 316);
insert into CLEANING_TASK (tid, status, rid, sid)
values (145, 'Completed', 100, 59);
insert into CLEANING_TASK (tid, status, rid, sid)
values (146, 'Pending', 103, 393);
insert into CLEANING_TASK (tid, status, rid, sid)
values (147, 'Pending', 168, 278);
insert into CLEANING_TASK (tid, status, rid, sid)
values (148, 'Pending', 23, 11);
insert into CLEANING_TASK (tid, status, rid, sid)
values (149, 'Pending', 179, 147);
insert into CLEANING_TASK (tid, status, rid, sid)
values (150, 'Completed', 254, 10);
insert into CLEANING_TASK (tid, status, rid, sid)
values (151, 'Completed', 30, 252);
insert into CLEANING_TASK (tid, status, rid, sid)
values (152, 'Completed', 368, 343);
insert into CLEANING_TASK (tid, status, rid, sid)
values (153, 'Pending', 118, 352);
insert into CLEANING_TASK (tid, status, rid, sid)
values (154, 'Completed', 349, 381);
insert into CLEANING_TASK (tid, status, rid, sid)
values (155, 'Completed', 194, 294);
insert into CLEANING_TASK (tid, status, rid, sid)
values (156, 'Pending', 384, 97);
insert into CLEANING_TASK (tid, status, rid, sid)
values (157, 'Completed', 222, 63);
insert into CLEANING_TASK (tid, status, rid, sid)
values (158, 'Pending', 97, 226);
insert into CLEANING_TASK (tid, status, rid, sid)
values (159, 'Completed', 268, 220);
insert into CLEANING_TASK (tid, status, rid, sid)
values (160, 'Completed', 227, 188);
insert into CLEANING_TASK (tid, status, rid, sid)
values (161, 'Pending', 152, 3);
insert into CLEANING_TASK (tid, status, rid, sid)
values (162, 'Pending', 314, 314);
insert into CLEANING_TASK (tid, status, rid, sid)
values (163, 'Pending', 53, 289);
insert into CLEANING_TASK (tid, status, rid, sid)
values (164, 'Completed', 245, 248);
insert into CLEANING_TASK (tid, status, rid, sid)
values (165, 'Completed', 314, 320);
insert into CLEANING_TASK (tid, status, rid, sid)
values (166, 'Pending', 358, 51);
insert into CLEANING_TASK (tid, status, rid, sid)
values (167, 'Pending', 397, 399);
insert into CLEANING_TASK (tid, status, rid, sid)
values (168, 'Completed', 154, 153);
insert into CLEANING_TASK (tid, status, rid, sid)
values (169, 'Pending', 293, 276);
insert into CLEANING_TASK (tid, status, rid, sid)
values (170, 'Completed', 98, 362);
insert into CLEANING_TASK (tid, status, rid, sid)
values (171, 'Completed', 289, 76);
insert into CLEANING_TASK (tid, status, rid, sid)
values (172, 'Pending', 350, 201);
insert into CLEANING_TASK (tid, status, rid, sid)
values (173, 'Completed', 359, 75);
insert into CLEANING_TASK (tid, status, rid, sid)
values (174, 'Pending', 327, 368);
insert into CLEANING_TASK (tid, status, rid, sid)
values (175, 'Pending', 75, 284);
insert into CLEANING_TASK (tid, status, rid, sid)
values (176, 'Completed', 101, 94);
insert into CLEANING_TASK (tid, status, rid, sid)
values (177, 'Completed', 160, 297);
insert into CLEANING_TASK (tid, status, rid, sid)
values (178, 'Pending', 22, 323);
insert into CLEANING_TASK (tid, status, rid, sid)
values (179, 'Pending', 377, 143);
insert into CLEANING_TASK (tid, status, rid, sid)
values (180, 'Completed', 279, 220);
insert into CLEANING_TASK (tid, status, rid, sid)
values (181, 'Pending', 62, 87);
insert into CLEANING_TASK (tid, status, rid, sid)
values (182, 'Completed', 162, 121);
insert into CLEANING_TASK (tid, status, rid, sid)
values (183, 'Pending', 399, 182);
insert into CLEANING_TASK (tid, status, rid, sid)
values (184, 'Pending', 388, 19);
insert into CLEANING_TASK (tid, status, rid, sid)
values (185, 'Completed', 240, 162);
insert into CLEANING_TASK (tid, status, rid, sid)
values (186, 'Pending', 303, 3);
insert into CLEANING_TASK (tid, status, rid, sid)
values (187, 'Pending', 193, 210);
insert into CLEANING_TASK (tid, status, rid, sid)
values (188, 'Pending', 139, 302);
insert into CLEANING_TASK (tid, status, rid, sid)
values (189, 'Completed', 372, 386);
insert into CLEANING_TASK (tid, status, rid, sid)
values (190, 'Completed', 225, 212);
insert into CLEANING_TASK (tid, status, rid, sid)
values (191, 'Pending', 385, 37);
insert into CLEANING_TASK (tid, status, rid, sid)
values (192, 'Pending', 343, 113);
insert into CLEANING_TASK (tid, status, rid, sid)
values (193, 'Completed', 55, 171);
insert into CLEANING_TASK (tid, status, rid, sid)
values (194, 'Completed', 254, 13);
insert into CLEANING_TASK (tid, status, rid, sid)
values (195, 'Pending', 112, 123);
insert into CLEANING_TASK (tid, status, rid, sid)
values (196, 'Completed', 361, 16);
insert into CLEANING_TASK (tid, status, rid, sid)
values (197, 'Pending', 171, 66);
insert into CLEANING_TASK (tid, status, rid, sid)
values (198, 'Completed', 352, 212);
insert into CLEANING_TASK (tid, status, rid, sid)
values (199, 'Completed', 85, 186);
insert into CLEANING_TASK (tid, status, rid, sid)
values (200, 'Completed', 276, 183);
commit;
prompt 200 records committed...
insert into CLEANING_TASK (tid, status, rid, sid)
values (201, 'Pending', 354, 180);
insert into CLEANING_TASK (tid, status, rid, sid)
values (202, 'Pending', 212, 208);
insert into CLEANING_TASK (tid, status, rid, sid)
values (203, 'Completed', 132, 262);
insert into CLEANING_TASK (tid, status, rid, sid)
values (204, 'Completed', 42, 165);
insert into CLEANING_TASK (tid, status, rid, sid)
values (205, 'Completed', 168, 5);
insert into CLEANING_TASK (tid, status, rid, sid)
values (206, 'Pending', 231, 307);
insert into CLEANING_TASK (tid, status, rid, sid)
values (207, 'Pending', 319, 27);
insert into CLEANING_TASK (tid, status, rid, sid)
values (208, 'Completed', 370, 133);
insert into CLEANING_TASK (tid, status, rid, sid)
values (209, 'Pending', 131, 287);
insert into CLEANING_TASK (tid, status, rid, sid)
values (210, 'Pending', 187, 133);
insert into CLEANING_TASK (tid, status, rid, sid)
values (211, 'Pending', 21, 283);
insert into CLEANING_TASK (tid, status, rid, sid)
values (212, 'Pending', 195, 265);
insert into CLEANING_TASK (tid, status, rid, sid)
values (213, 'Completed', 35, 110);
insert into CLEANING_TASK (tid, status, rid, sid)
values (214, 'Completed', 124, 60);
insert into CLEANING_TASK (tid, status, rid, sid)
values (215, 'Pending', 233, 225);
insert into CLEANING_TASK (tid, status, rid, sid)
values (216, 'Completed', 101, 259);
insert into CLEANING_TASK (tid, status, rid, sid)
values (217, 'Pending', 62, 38);
insert into CLEANING_TASK (tid, status, rid, sid)
values (218, 'Pending', 40, 305);
insert into CLEANING_TASK (tid, status, rid, sid)
values (219, 'Completed', 89, 180);
insert into CLEANING_TASK (tid, status, rid, sid)
values (220, 'Pending', 334, 260);
insert into CLEANING_TASK (tid, status, rid, sid)
values (221, 'Completed', 359, 286);
insert into CLEANING_TASK (tid, status, rid, sid)
values (222, 'Pending', 302, 6);
insert into CLEANING_TASK (tid, status, rid, sid)
values (223, 'Pending', 288, 38);
insert into CLEANING_TASK (tid, status, rid, sid)
values (224, 'Pending', 184, 174);
insert into CLEANING_TASK (tid, status, rid, sid)
values (225, 'Pending', 376, 160);
insert into CLEANING_TASK (tid, status, rid, sid)
values (226, 'Completed', 379, 318);
insert into CLEANING_TASK (tid, status, rid, sid)
values (227, 'Pending', 188, 73);
insert into CLEANING_TASK (tid, status, rid, sid)
values (228, 'Completed', 379, 56);
insert into CLEANING_TASK (tid, status, rid, sid)
values (229, 'Completed', 221, 333);
insert into CLEANING_TASK (tid, status, rid, sid)
values (230, 'Completed', 7, 65);
insert into CLEANING_TASK (tid, status, rid, sid)
values (231, 'Completed', 269, 164);
insert into CLEANING_TASK (tid, status, rid, sid)
values (232, 'Pending', 242, 353);
insert into CLEANING_TASK (tid, status, rid, sid)
values (233, 'Completed', 344, 15);
insert into CLEANING_TASK (tid, status, rid, sid)
values (234, 'Pending', 191, 168);
insert into CLEANING_TASK (tid, status, rid, sid)
values (235, 'Completed', 131, 321);
insert into CLEANING_TASK (tid, status, rid, sid)
values (236, 'Completed', 290, 80);
insert into CLEANING_TASK (tid, status, rid, sid)
values (237, 'Completed', 397, 361);
insert into CLEANING_TASK (tid, status, rid, sid)
values (238, 'Pending', 344, 388);
insert into CLEANING_TASK (tid, status, rid, sid)
values (239, 'Completed', 317, 320);
insert into CLEANING_TASK (tid, status, rid, sid)
values (240, 'Pending', 200, 310);
insert into CLEANING_TASK (tid, status, rid, sid)
values (241, 'Completed', 193, 386);
insert into CLEANING_TASK (tid, status, rid, sid)
values (242, 'Completed', 387, 12);
insert into CLEANING_TASK (tid, status, rid, sid)
values (243, 'Completed', 341, 361);
insert into CLEANING_TASK (tid, status, rid, sid)
values (244, 'Pending', 225, 67);
insert into CLEANING_TASK (tid, status, rid, sid)
values (245, 'Pending', 193, 137);
insert into CLEANING_TASK (tid, status, rid, sid)
values (246, 'Pending', 289, 218);
insert into CLEANING_TASK (tid, status, rid, sid)
values (247, 'Completed', 195, 343);
insert into CLEANING_TASK (tid, status, rid, sid)
values (248, 'Pending', 204, 191);
insert into CLEANING_TASK (tid, status, rid, sid)
values (249, 'Completed', 256, 380);
insert into CLEANING_TASK (tid, status, rid, sid)
values (250, 'Completed', 82, 343);
insert into CLEANING_TASK (tid, status, rid, sid)
values (251, 'Pending', 327, 273);
insert into CLEANING_TASK (tid, status, rid, sid)
values (252, 'Pending', 19, 68);
insert into CLEANING_TASK (tid, status, rid, sid)
values (253, 'Completed', 291, 156);
insert into CLEANING_TASK (tid, status, rid, sid)
values (254, 'Pending', 233, 387);
insert into CLEANING_TASK (tid, status, rid, sid)
values (255, 'Pending', 367, 13);
insert into CLEANING_TASK (tid, status, rid, sid)
values (256, 'Pending', 267, 199);
insert into CLEANING_TASK (tid, status, rid, sid)
values (257, 'Completed', 126, 65);
insert into CLEANING_TASK (tid, status, rid, sid)
values (258, 'Pending', 395, 195);
insert into CLEANING_TASK (tid, status, rid, sid)
values (259, 'Completed', 177, 265);
insert into CLEANING_TASK (tid, status, rid, sid)
values (260, 'Completed', 392, 89);
insert into CLEANING_TASK (tid, status, rid, sid)
values (261, 'Pending', 36, 34);
insert into CLEANING_TASK (tid, status, rid, sid)
values (262, 'Pending', 239, 228);
insert into CLEANING_TASK (tid, status, rid, sid)
values (263, 'Pending', 114, 7);
insert into CLEANING_TASK (tid, status, rid, sid)
values (264, 'Completed', 38, 243);
insert into CLEANING_TASK (tid, status, rid, sid)
values (265, 'Pending', 260, 22);
insert into CLEANING_TASK (tid, status, rid, sid)
values (266, 'Completed', 172, 174);
insert into CLEANING_TASK (tid, status, rid, sid)
values (267, 'Completed', 283, 87);
insert into CLEANING_TASK (tid, status, rid, sid)
values (268, 'Pending', 282, 345);
insert into CLEANING_TASK (tid, status, rid, sid)
values (269, 'Completed', 335, 226);
insert into CLEANING_TASK (tid, status, rid, sid)
values (270, 'Pending', 239, 117);
insert into CLEANING_TASK (tid, status, rid, sid)
values (271, 'Completed', 263, 371);
insert into CLEANING_TASK (tid, status, rid, sid)
values (272, 'Completed', 297, 206);
insert into CLEANING_TASK (tid, status, rid, sid)
values (273, 'Pending', 385, 230);
insert into CLEANING_TASK (tid, status, rid, sid)
values (274, 'Completed', 39, 307);
insert into CLEANING_TASK (tid, status, rid, sid)
values (275, 'Completed', 87, 370);
insert into CLEANING_TASK (tid, status, rid, sid)
values (276, 'Pending', 303, 151);
insert into CLEANING_TASK (tid, status, rid, sid)
values (277, 'Pending', 186, 272);
insert into CLEANING_TASK (tid, status, rid, sid)
values (278, 'Completed', 137, 42);
insert into CLEANING_TASK (tid, status, rid, sid)
values (279, 'Completed', 153, 126);
insert into CLEANING_TASK (tid, status, rid, sid)
values (280, 'Pending', 172, 47);
insert into CLEANING_TASK (tid, status, rid, sid)
values (281, 'Completed', 346, 271);
insert into CLEANING_TASK (tid, status, rid, sid)
values (282, 'Pending', 381, 326);
insert into CLEANING_TASK (tid, status, rid, sid)
values (283, 'Pending', 257, 291);
insert into CLEANING_TASK (tid, status, rid, sid)
values (284, 'Pending', 324, 229);
insert into CLEANING_TASK (tid, status, rid, sid)
values (285, 'Pending', 33, 370);
insert into CLEANING_TASK (tid, status, rid, sid)
values (286, 'Completed', 254, 193);
insert into CLEANING_TASK (tid, status, rid, sid)
values (287, 'Completed', 17, 388);
insert into CLEANING_TASK (tid, status, rid, sid)
values (288, 'Completed', 88, 124);
insert into CLEANING_TASK (tid, status, rid, sid)
values (289, 'Pending', 170, 65);
insert into CLEANING_TASK (tid, status, rid, sid)
values (290, 'Completed', 35, 370);
insert into CLEANING_TASK (tid, status, rid, sid)
values (291, 'Pending', 281, 359);
insert into CLEANING_TASK (tid, status, rid, sid)
values (292, 'Pending', 377, 45);
insert into CLEANING_TASK (tid, status, rid, sid)
values (293, 'Completed', 346, 263);
insert into CLEANING_TASK (tid, status, rid, sid)
values (294, 'Completed', 92, 376);
insert into CLEANING_TASK (tid, status, rid, sid)
values (295, 'Pending', 391, 223);
insert into CLEANING_TASK (tid, status, rid, sid)
values (296, 'Pending', 31, 138);
insert into CLEANING_TASK (tid, status, rid, sid)
values (297, 'Pending', 157, 325);
insert into CLEANING_TASK (tid, status, rid, sid)
values (298, 'Pending', 122, 113);
insert into CLEANING_TASK (tid, status, rid, sid)
values (299, 'Pending', 292, 327);
insert into CLEANING_TASK (tid, status, rid, sid)
values (300, 'Pending', 90, 166);
commit;
prompt 300 records committed...
insert into CLEANING_TASK (tid, status, rid, sid)
values (301, 'Pending', 223, 264);
insert into CLEANING_TASK (tid, status, rid, sid)
values (302, 'Completed', 217, 259);
insert into CLEANING_TASK (tid, status, rid, sid)
values (303, 'Pending', 154, 20);
insert into CLEANING_TASK (tid, status, rid, sid)
values (304, 'Completed', 348, 308);
insert into CLEANING_TASK (tid, status, rid, sid)
values (305, 'Pending', 199, 337);
insert into CLEANING_TASK (tid, status, rid, sid)
values (306, 'Pending', 196, 318);
insert into CLEANING_TASK (tid, status, rid, sid)
values (307, 'Pending', 313, 234);
insert into CLEANING_TASK (tid, status, rid, sid)
values (308, 'Completed', 247, 50);
insert into CLEANING_TASK (tid, status, rid, sid)
values (309, 'Completed', 21, 400);
insert into CLEANING_TASK (tid, status, rid, sid)
values (310, 'Pending', 77, 35);
insert into CLEANING_TASK (tid, status, rid, sid)
values (311, 'Completed', 382, 396);
insert into CLEANING_TASK (tid, status, rid, sid)
values (312, 'Completed', 264, 367);
insert into CLEANING_TASK (tid, status, rid, sid)
values (313, 'Completed', 316, 274);
insert into CLEANING_TASK (tid, status, rid, sid)
values (314, 'Pending', 320, 20);
insert into CLEANING_TASK (tid, status, rid, sid)
values (315, 'Completed', 135, 167);
insert into CLEANING_TASK (tid, status, rid, sid)
values (316, 'Completed', 61, 51);
insert into CLEANING_TASK (tid, status, rid, sid)
values (317, 'Pending', 5, 81);
insert into CLEANING_TASK (tid, status, rid, sid)
values (318, 'Pending', 136, 314);
insert into CLEANING_TASK (tid, status, rid, sid)
values (319, 'Pending', 38, 216);
insert into CLEANING_TASK (tid, status, rid, sid)
values (320, 'Completed', 125, 389);
insert into CLEANING_TASK (tid, status, rid, sid)
values (321, 'Pending', 29, 18);
insert into CLEANING_TASK (tid, status, rid, sid)
values (322, 'Pending', 266, 121);
insert into CLEANING_TASK (tid, status, rid, sid)
values (323, 'Pending', 207, 345);
insert into CLEANING_TASK (tid, status, rid, sid)
values (324, 'Pending', 190, 59);
insert into CLEANING_TASK (tid, status, rid, sid)
values (325, 'Pending', 235, 294);
insert into CLEANING_TASK (tid, status, rid, sid)
values (326, 'Completed', 342, 41);
insert into CLEANING_TASK (tid, status, rid, sid)
values (327, 'Pending', 279, 148);
insert into CLEANING_TASK (tid, status, rid, sid)
values (328, 'Pending', 169, 232);
insert into CLEANING_TASK (tid, status, rid, sid)
values (329, 'Pending', 147, 126);
insert into CLEANING_TASK (tid, status, rid, sid)
values (330, 'Pending', 240, 230);
insert into CLEANING_TASK (tid, status, rid, sid)
values (331, 'Pending', 367, 340);
insert into CLEANING_TASK (tid, status, rid, sid)
values (332, 'Completed', 267, 356);
insert into CLEANING_TASK (tid, status, rid, sid)
values (333, 'Completed', 62, 320);
insert into CLEANING_TASK (tid, status, rid, sid)
values (334, 'Completed', 114, 34);
insert into CLEANING_TASK (tid, status, rid, sid)
values (335, 'Pending', 194, 138);
insert into CLEANING_TASK (tid, status, rid, sid)
values (336, 'Completed', 224, 10);
insert into CLEANING_TASK (tid, status, rid, sid)
values (337, 'Completed', 185, 108);
insert into CLEANING_TASK (tid, status, rid, sid)
values (338, 'Pending', 338, 306);
insert into CLEANING_TASK (tid, status, rid, sid)
values (339, 'Pending', 381, 210);
insert into CLEANING_TASK (tid, status, rid, sid)
values (340, 'Completed', 153, 302);
insert into CLEANING_TASK (tid, status, rid, sid)
values (341, 'Completed', 61, 186);
insert into CLEANING_TASK (tid, status, rid, sid)
values (342, 'Pending', 251, 155);
insert into CLEANING_TASK (tid, status, rid, sid)
values (343, 'Pending', 362, 7);
insert into CLEANING_TASK (tid, status, rid, sid)
values (344, 'Completed', 319, 397);
insert into CLEANING_TASK (tid, status, rid, sid)
values (345, 'Completed', 205, 32);
insert into CLEANING_TASK (tid, status, rid, sid)
values (346, 'Completed', 313, 348);
insert into CLEANING_TASK (tid, status, rid, sid)
values (347, 'Completed', 324, 363);
insert into CLEANING_TASK (tid, status, rid, sid)
values (348, 'Pending', 122, 50);
insert into CLEANING_TASK (tid, status, rid, sid)
values (349, 'Completed', 386, 27);
insert into CLEANING_TASK (tid, status, rid, sid)
values (350, 'Pending', 377, 99);
insert into CLEANING_TASK (tid, status, rid, sid)
values (351, 'Completed', 237, 385);
insert into CLEANING_TASK (tid, status, rid, sid)
values (352, 'Completed', 238, 342);
insert into CLEANING_TASK (tid, status, rid, sid)
values (353, 'Completed', 282, 263);
insert into CLEANING_TASK (tid, status, rid, sid)
values (354, 'Completed', 84, 87);
insert into CLEANING_TASK (tid, status, rid, sid)
values (355, 'Completed', 371, 145);
insert into CLEANING_TASK (tid, status, rid, sid)
values (356, 'Pending', 371, 73);
insert into CLEANING_TASK (tid, status, rid, sid)
values (357, 'Completed', 344, 384);
insert into CLEANING_TASK (tid, status, rid, sid)
values (358, 'Completed', 297, 209);
insert into CLEANING_TASK (tid, status, rid, sid)
values (359, 'Completed', 161, 354);
insert into CLEANING_TASK (tid, status, rid, sid)
values (360, 'Pending', 383, 222);
insert into CLEANING_TASK (tid, status, rid, sid)
values (361, 'Completed', 396, 111);
insert into CLEANING_TASK (tid, status, rid, sid)
values (362, 'Completed', 157, 325);
insert into CLEANING_TASK (tid, status, rid, sid)
values (363, 'Completed', 24, 356);
insert into CLEANING_TASK (tid, status, rid, sid)
values (364, 'Pending', 245, 131);
insert into CLEANING_TASK (tid, status, rid, sid)
values (365, 'Pending', 5, 222);
insert into CLEANING_TASK (tid, status, rid, sid)
values (366, 'Pending', 94, 318);
insert into CLEANING_TASK (tid, status, rid, sid)
values (367, 'Pending', 394, 225);
insert into CLEANING_TASK (tid, status, rid, sid)
values (368, 'Pending', 372, 13);
insert into CLEANING_TASK (tid, status, rid, sid)
values (369, 'Pending', 350, 221);
insert into CLEANING_TASK (tid, status, rid, sid)
values (370, 'Pending', 378, 285);
insert into CLEANING_TASK (tid, status, rid, sid)
values (371, 'Pending', 358, 85);
insert into CLEANING_TASK (tid, status, rid, sid)
values (372, 'Pending', 400, 53);
insert into CLEANING_TASK (tid, status, rid, sid)
values (373, 'Pending', 226, 277);
insert into CLEANING_TASK (tid, status, rid, sid)
values (374, 'Completed', 133, 219);
insert into CLEANING_TASK (tid, status, rid, sid)
values (375, 'Pending', 380, 245);
insert into CLEANING_TASK (tid, status, rid, sid)
values (376, 'Pending', 157, 87);
insert into CLEANING_TASK (tid, status, rid, sid)
values (377, 'Completed', 108, 274);
insert into CLEANING_TASK (tid, status, rid, sid)
values (378, 'Completed', 207, 188);
insert into CLEANING_TASK (tid, status, rid, sid)
values (379, 'Completed', 92, 275);
insert into CLEANING_TASK (tid, status, rid, sid)
values (380, 'Completed', 283, 346);
insert into CLEANING_TASK (tid, status, rid, sid)
values (381, 'Completed', 308, 124);
insert into CLEANING_TASK (tid, status, rid, sid)
values (382, 'Completed', 207, 153);
insert into CLEANING_TASK (tid, status, rid, sid)
values (383, 'Pending', 229, 13);
insert into CLEANING_TASK (tid, status, rid, sid)
values (384, 'Pending', 67, 235);
insert into CLEANING_TASK (tid, status, rid, sid)
values (385, 'Completed', 162, 22);
insert into CLEANING_TASK (tid, status, rid, sid)
values (386, 'Pending', 120, 259);
insert into CLEANING_TASK (tid, status, rid, sid)
values (387, 'Completed', 292, 11);
insert into CLEANING_TASK (tid, status, rid, sid)
values (388, 'Pending', 138, 235);
insert into CLEANING_TASK (tid, status, rid, sid)
values (389, 'Completed', 72, 170);
insert into CLEANING_TASK (tid, status, rid, sid)
values (390, 'Completed', 196, 124);
insert into CLEANING_TASK (tid, status, rid, sid)
values (391, 'Completed', 26, 239);
insert into CLEANING_TASK (tid, status, rid, sid)
values (392, 'Pending', 183, 115);
insert into CLEANING_TASK (tid, status, rid, sid)
values (393, 'Completed', 328, 48);
insert into CLEANING_TASK (tid, status, rid, sid)
values (394, 'Completed', 134, 157);
insert into CLEANING_TASK (tid, status, rid, sid)
values (395, 'Completed', 86, 334);
insert into CLEANING_TASK (tid, status, rid, sid)
values (396, 'Completed', 340, 318);
insert into CLEANING_TASK (tid, status, rid, sid)
values (397, 'Completed', 365, 177);
insert into CLEANING_TASK (tid, status, rid, sid)
values (398, 'Pending', 254, 44);
insert into CLEANING_TASK (tid, status, rid, sid)
values (399, 'Completed', 170, 17);
insert into CLEANING_TASK (tid, status, rid, sid)
values (400, 'Pending', 226, 324);
commit;
prompt 400 records loaded
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
values (24, 'AC not working', to_date('08-05-2023', 'dd-mm-yyyy'), 236, 99);
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
values (57, 'Leaky faucet', to_date('14-04-2023', 'dd-mm-yyyy'), 321, 359);
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
commit;
prompt 100 records committed...
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (101, 'Broken window', to_date('27-12-2023', 'dd-mm-yyyy'), 166, 120);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (102, 'AC not working', to_date('23-07-2023', 'dd-mm-yyyy'), 48, 212);
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
values (154, 'Pest infestation', to_date('12-04-2023', 'dd-mm-yyyy'), 315, 379);
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
values (174, 'Broken window', to_date('10-02-2023', 'dd-mm-yyyy'), 396, 136);
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
commit;
prompt 200 records committed...
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (201, 'Broken window', to_date('10-08-2023', 'dd-mm-yyyy'), 327, 289);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (202, 'Flickering lights', to_date('20-01-2024', 'dd-mm-yyyy'), 147, 332);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (203, 'Rusty faucet', to_date('06-05-2023', 'dd-mm-yyyy'), 287, 178);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (204, 'Hissing radiator', to_date('07-03-2024', 'dd-mm-yyyy'), 301, 246);
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
values (219, 'Leaking pipe', to_date('03-05-2023', 'dd-mm-yyyy'), 354, 31);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (220, 'Window won''t close', to_date('09-01-2023', 'dd-mm-yyyy'), 372, 166);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (221, 'Leaking pipe', to_date('02-04-2023', 'dd-mm-yyyy'), 307, 187);
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
values (243, 'Faulty wiring', to_date('24-03-2023', 'dd-mm-yyyy'), 218, 217);
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
values (251, 'Jammed lock', to_date('10-01-2023', 'dd-mm-yyyy'), 355, 346);
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
values (277, 'Cracked wall', to_date('30-01-2023', 'dd-mm-yyyy'), 149, 157);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (278, 'Cabinet door broken', to_date('25-02-2023', 'dd-mm-yyyy'), 140, 345);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (279, 'Mold growth', to_date('22-05-2024', 'dd-mm-yyyy'), 394, 270);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (280, 'Water damage', to_date('08-03-2023', 'dd-mm-yyyy'), 315, 172);
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
values (292, 'Broken appliance', to_date('28-04-2023', 'dd-mm-yyyy'), 170, 296);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (293, 'Foul taste in water', to_date('25-08-2023', 'dd-mm-yyyy'), 277, 42);
insert into MAINTENANCE_REQUEST (mid, issue_description, date_reported, rid, sid)
values (294, 'No hot water', to_date('07-01-2023', 'dd-mm-yyyy'), 227, 221);
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
commit;
prompt 300 records committed...
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
values (345, 'Foul taste in water', to_date('31-01-2023', 'dd-mm-yyyy'), 217, 131);
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
values (367, 'Rodent sighting', to_date('22-01-2023', 'dd-mm-yyyy'), 392, 375);
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
prompt 400 records loaded
prompt Loading NEED_FOR...
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (1, 10, 1, 1, 1);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (2, 5, 2, 2, 2);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (3, 3, 3, 3, 3);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (4, 2, 4, 4, 4);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (5, 1, 5, 5, 5);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (6, 20, 6, 6, 6);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (7, 4, 7, 7, 7);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (8, 6, 8, 8, 8);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (9, 7, 9, 9, 9);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (10, 2, 10, 10, 10);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (34, 3, 11, 250, 159);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (243, 16, 12, 281, 249);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (387, 12, 13, 328, 346);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (261, 8, 14, 83, 138);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (22, 19, 15, 219, 122);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (204, 4, 16, 327, 135);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (366, 8, 17, 137, 311);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (87, 5, 18, 366, 223);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (278, 5, 19, 331, 346);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (158, 9, 20, 264, 355);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (298, 7, 21, 219, 131);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (376, 16, 22, 258, 1);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (235, 19, 23, 240, 195);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (74, 5, 24, 263, 269);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (315, 1, 25, 1, 394);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (305, 12, 26, 54, 101);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (102, 16, 27, 13, 360);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (177, 14, 28, 25, 305);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (67, 4, 29, 89, 48);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (240, 11, 30, 141, 345);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (329, 6, 31, 321, 214);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (173, 10, 32, 251, 205);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (190, 5, 33, 316, 58);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (111, 10, 34, 241, 78);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (256, 4, 35, 398, 339);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (153, 10, 36, 346, 242);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (317, 9, 37, 233, 241);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (106, 6, 38, 126, 121);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (385, 3, 39, 324, 336);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (283, 18, 40, 127, 150);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (173, 8, 41, 139, 181);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (244, 17, 42, 65, 343);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (332, 5, 43, 258, 335);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (276, 6, 44, 172, 85);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (90, 6, 45, 277, 302);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (368, 14, 46, 172, 235);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (180, 2, 47, 44, 339);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (155, 8, 48, 51, 197);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (50, 18, 49, 215, 330);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (122, 12, 50, 12, 329);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (83, 7, 51, 317, 282);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (191, 16, 52, 88, 302);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (375, 17, 53, 272, 325);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (61, 20, 54, 146, 187);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (320, 14, 55, 394, 19);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (116, 19, 56, 36, 29);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (97, 6, 57, 97, 325);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (328, 11, 58, 254, 10);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (337, 15, 59, 337, 137);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (148, 18, 60, 87, 334);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (278, 6, 61, 52, 358);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (169, 16, 62, 110, 168);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (344, 11, 63, 249, 203);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (295, 18, 64, 196, 143);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (284, 5, 65, 310, 280);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (138, 10, 66, 246, 311);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (189, 10, 67, 18, 367);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (85, 7, 68, 178, 32);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (14, 10, 69, 318, 202);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (133, 18, 70, 383, 176);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (242, 13, 71, 353, 292);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (318, 4, 72, 309, 96);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (114, 10, 73, 144, 352);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (224, 16, 74, 255, 329);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (304, 11, 75, 122, 364);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (36, 4, 76, 320, 115);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (157, 12, 77, 141, 131);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (323, 14, 78, 328, 362);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (361, 10, 79, 256, 140);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (392, 19, 80, 314, 177);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (235, 15, 81, 268, 228);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (17, 18, 82, 8, 195);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (19, 6, 83, 215, 381);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (64, 10, 84, 78, 56);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (183, 12, 85, 88, 135);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (37, 18, 86, 266, 193);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (243, 4, 87, 274, 253);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (158, 7, 88, 135, 109);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (79, 11, 89, 176, 331);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (151, 16, 90, 67, 348);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (163, 18, 91, 244, 199);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (296, 6, 92, 4, 193);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (376, 19, 93, 180, 88);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (57, 11, 94, 117, 43);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (292, 18, 95, 73, 317);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (146, 9, 96, 17, 366);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (105, 10, 97, 48, 350);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (239, 18, 98, 336, 39);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (9, 4, 99, 336, 110);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (188, 18, 100, 345, 63);
commit;
prompt 100 records committed...
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (119, 7, 101, 269, 47);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (6, 3, 102, 359, 11);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (84, 9, 103, 281, 49);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (269, 6, 104, 203, 124);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (245, 3, 105, 246, 300);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (32, 15, 106, 78, 263);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (372, 16, 107, 16, 234);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (225, 5, 108, 275, 160);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (136, 10, 109, 42, 268);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (65, 16, 110, 119, 362);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (190, 6, 111, 320, 370);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (118, 14, 112, 326, 232);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (15, 5, 113, 26, 101);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (388, 15, 114, 273, 310);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (77, 15, 115, 57, 157);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (71, 16, 116, 53, 326);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (134, 20, 117, 248, 150);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (243, 5, 118, 384, 394);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (84, 7, 119, 72, 108);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (159, 10, 120, 128, 11);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (303, 11, 121, 282, 88);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (104, 7, 122, 290, 343);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (248, 16, 123, 155, 93);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (124, 10, 124, 101, 355);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (160, 5, 125, 357, 107);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (40, 5, 126, 342, 126);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (46, 20, 127, 156, 223);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (72, 20, 128, 303, 278);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (243, 1, 129, 316, 41);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (215, 13, 130, 89, 7);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (301, 8, 131, 22, 373);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (311, 20, 132, 217, 33);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (399, 14, 133, 233, 364);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (169, 5, 134, 44, 20);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (245, 19, 135, 47, 357);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (121, 9, 136, 271, 189);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (352, 3, 137, 219, 342);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (192, 17, 138, 345, 253);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (171, 5, 139, 312, 58);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (254, 18, 140, 103, 195);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (280, 15, 141, 242, 269);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (162, 15, 142, 193, 318);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (170, 3, 143, 2, 113);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (394, 11, 144, 68, 316);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (210, 19, 145, 100, 59);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (161, 10, 146, 103, 393);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (122, 8, 147, 168, 278);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (56, 9, 148, 23, 11);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (148, 8, 149, 179, 147);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (328, 7, 150, 254, 10);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (42, 15, 151, 30, 252);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (305, 5, 152, 368, 343);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (160, 14, 153, 118, 352);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (81, 15, 154, 349, 381);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (82, 12, 155, 194, 294);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (146, 6, 156, 384, 97);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (31, 12, 157, 222, 63);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (133, 5, 158, 97, 226);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (220, 19, 159, 268, 220);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (64, 19, 160, 227, 188);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (32, 11, 161, 152, 3);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (173, 12, 162, 314, 314);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (26, 9, 163, 53, 289);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (309, 2, 164, 245, 248);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (231, 6, 165, 314, 320);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (200, 14, 166, 358, 51);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (388, 7, 167, 397, 399);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (308, 6, 168, 154, 153);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (340, 13, 169, 293, 276);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (88, 7, 170, 98, 362);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (111, 15, 171, 289, 76);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (132, 18, 172, 350, 201);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (394, 20, 173, 359, 75);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (356, 12, 174, 327, 368);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (66, 1, 175, 75, 284);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (237, 8, 176, 101, 94);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (354, 15, 177, 160, 297);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (81, 3, 178, 22, 323);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (367, 20, 179, 377, 143);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (372, 4, 180, 279, 220);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (156, 6, 181, 62, 87);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (64, 8, 182, 162, 121);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (372, 15, 183, 399, 182);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (72, 12, 184, 388, 19);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (390, 13, 185, 240, 162);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (308, 10, 186, 303, 3);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (239, 10, 187, 193, 210);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (389, 14, 188, 139, 302);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (207, 12, 189, 372, 386);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (11, 10, 190, 225, 212);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (375, 17, 191, 385, 37);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (243, 8, 192, 343, 113);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (270, 9, 193, 55, 171);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (268, 11, 194, 254, 13);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (51, 14, 195, 112, 123);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (204, 19, 196, 361, 16);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (301, 3, 197, 171, 66);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (215, 6, 198, 352, 212);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (233, 18, 199, 85, 186);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (332, 7, 200, 276, 183);
commit;
prompt 200 records committed...
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (156, 3, 201, 354, 180);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (224, 18, 202, 212, 208);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (223, 13, 203, 132, 262);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (65, 5, 204, 42, 165);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (102, 17, 205, 168, 5);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (66, 5, 206, 231, 307);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (365, 17, 207, 319, 27);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (221, 1, 208, 370, 133);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (363, 9, 209, 131, 287);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (327, 5, 210, 187, 133);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (34, 1, 211, 21, 283);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (193, 5, 212, 195, 265);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (192, 6, 213, 35, 110);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (279, 10, 214, 124, 60);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (205, 15, 215, 233, 225);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (275, 17, 216, 101, 259);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (116, 15, 217, 62, 38);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (166, 3, 218, 40, 305);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (126, 16, 219, 89, 180);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (320, 5, 220, 334, 260);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (155, 15, 221, 359, 286);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (344, 9, 222, 302, 6);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (89, 1, 223, 288, 38);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (305, 13, 224, 184, 174);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (236, 17, 225, 376, 160);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (379, 8, 226, 379, 318);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (266, 18, 227, 188, 73);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (224, 10, 228, 379, 56);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (334, 16, 229, 221, 333);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (7, 7, 230, 7, 65);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (269, 5, 231, 269, 164);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (344, 14, 232, 242, 353);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (44, 6, 233, 344, 15);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (105, 19, 234, 191, 168);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (131, 13, 235, 131, 321);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (290, 12, 236, 290, 80);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (397, 20, 237, 397, 361);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (344, 3, 238, 344, 388);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (317, 8, 239, 317, 320);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (200, 20, 240, 200, 310);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (193, 15, 241, 193, 386);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (387, 5, 242, 387, 12);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (341, 1, 243, 341, 361);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (225, 16, 244, 225, 67);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (193, 6, 245, 193, 137);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (289, 7, 246, 289, 218);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (195, 4, 247, 195, 343);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (204, 14, 248, 204, 191);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (256, 17, 249, 256, 380);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (82, 12, 250, 82, 343);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (327, 13, 251, 327, 273);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (19, 9, 252, 19, 68);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (291, 20, 253, 291, 156);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (233, 2, 254, 233, 387);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (367, 19, 255, 367, 13);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (267, 17, 256, 267, 199);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (126, 8, 257, 126, 65);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (395, 16, 258, 395, 195);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (177, 7, 259, 177, 265);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (392, 3, 260, 392, 89);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (36, 11, 261, 36, 34);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (239, 20, 262, 239, 228);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (114, 10, 263, 114, 7);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (38, 19, 264, 38, 243);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (260, 6, 265, 260, 22);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (172, 13, 266, 172, 174);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (283, 20, 267, 283, 87);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (282, 12, 268, 282, 345);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (335, 11, 269, 335, 226);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (239, 8, 270, 239, 117);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (263, 6, 271, 263, 371);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (297, 19, 272, 297, 206);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (385, 16, 273, 385, 230);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (39, 1, 274, 39, 307);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (87, 9, 275, 87, 370);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (303, 15, 276, 303, 151);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (186, 20, 277, 186, 272);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (137, 10, 278, 137, 42);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (153, 5, 279, 153, 126);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (172, 20, 280, 172, 47);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (346, 10, 281, 346, 271);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (381, 9, 282, 381, 326);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (257, 2, 283, 257, 291);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (324, 14, 284, 324, 229);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (33, 6, 285, 33, 370);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (254, 16, 286, 254, 193);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (17, 1, 287, 17, 388);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (88, 9, 288, 88, 124);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (170, 10, 289, 170, 65);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (35, 8, 290, 35, 370);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (281, 20, 291, 281, 359);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (377, 18, 292, 377, 45);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (346, 1, 293, 346, 263);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (92, 11, 294, 92, 376);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (391, 16, 295, 391, 223);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (31, 13, 296, 31, 138);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (157, 14, 297, 157, 325);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (122, 16, 298, 122, 113);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (292, 19, 299, 292, 327);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (90, 5, 300, 90, 166);
commit;
prompt 300 records committed...
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (223, 15, 301, 223, 264);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (217, 11, 302, 217, 259);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (21, 10, 309, 21, 400);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (77, 15, 310, 77, 35);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (382, 20, 311, 382, 396);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (264, 19, 312, 264, 367);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (316, 8, 313, 316, 274);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (320, 1, 314, 320, 20);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (135, 8, 315, 135, 167);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (61, 19, 316, 61, 51);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (5, 9, 317, 5, 81);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (136, 10, 318, 136, 314);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (38, 11, 319, 38, 216);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (125, 18, 320, 125, 389);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (29, 7, 321, 29, 18);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (266, 17, 322, 266, 121);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (207, 8, 323, 207, 345);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (190, 20, 324, 190, 59);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (235, 6, 325, 235, 294);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (342, 17, 326, 342, 41);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (279, 2, 327, 279, 148);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (169, 6, 328, 169, 232);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (147, 9, 329, 147, 126);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (240, 7, 330, 240, 230);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (367, 5, 331, 367, 340);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (267, 2, 332, 267, 356);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (62, 14, 333, 62, 320);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (114, 10, 334, 114, 34);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (194, 17, 335, 194, 138);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (224, 2, 336, 224, 10);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (185, 11, 337, 185, 108);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (338, 20, 338, 338, 306);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (381, 14, 339, 381, 210);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (153, 9, 340, 153, 302);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (61, 15, 341, 61, 186);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (251, 13, 342, 251, 155);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (362, 10, 343, 362, 7);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (319, 12, 344, 319, 397);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (205, 10, 345, 205, 32);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (313, 14, 346, 313, 348);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (324, 15, 347, 324, 363);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (122, 13, 348, 122, 50);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (386, 2, 349, 386, 27);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (282, 7, 353, 282, 263);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (363, 5, 371, 358, 85);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (85, 12, 372, 400, 53);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (277, 3, 373, 226, 277);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (143, 11, 374, 133, 219);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (259, 17, 375, 380, 245);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (204, 8, 376, 157, 87);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (394, 15, 377, 108, 274);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (288, 4, 378, 207, 188);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (61, 10, 379, 92, 275);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (284, 6, 380, 283, 346);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (362, 14, 381, 308, 124);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (107, 2, 382, 207, 153);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (290, 7, 383, 229, 13);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (202, 19, 384, 67, 235);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (356, 16, 385, 162, 22);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (215, 1, 386, 120, 259);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (359, 18, 387, 292, 11);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (21, 9, 388, 138, 235);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (293, 13, 389, 72, 170);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (8, 20, 390, 196, 124);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (239, 5, 391, 26, 239);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (164, 12, 392, 183, 115);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (204, 3, 393, 328, 48);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (283, 11, 394, 134, 157);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (164, 17, 395, 86, 334);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (127, 4, 396, 340, 318);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (245, 14, 397, 365, 177);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (260, 6, 398, 254, 44);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (326, 19, 399, 170, 17);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (398, 2, 400, 226, 324);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (348, 20, 303, 154, 20);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (199, 14, 304, 348, 308);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (196, 6, 305, 199, 337);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (361, 5, 306, 196, 318);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (380, 12, 307, 313, 234);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (157, 9, 308, 247, 50);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (282, 5, 350, 377, 99);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (84, 14, 351, 237, 385);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (371, 13, 352, 238, 342);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (161, 18, 354, 84, 87);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (396, 7, 355, 371, 145);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (24, 4, 356, 371, 73);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (245, 17, 357, 344, 384);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (5, 14, 358, 297, 209);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (94, 10, 359, 161, 354);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (394, 8, 360, 383, 222);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (372, 19, 361, 396, 111);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (350, 15, 362, 157, 325);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (378, 7, 363, 24, 356);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (358, 18, 364, 245, 131);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (400, 5, 365, 5, 222);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (226, 8, 366, 94, 318);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (133, 15, 367, 394, 225);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (380, 7, 368, 372, 13);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (157, 13, 369, 350, 221);
insert into NEED_FOR (suid, quantity, tid, rid, sid)
values (108, 6, 370, 378, 285);
commit;
prompt 400 records loaded
prompt Loading STAFF_MEMBER_INFO...
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (1, '972-5356-7890');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (2, '972-5267-8901');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (3, '972-5478-9012');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (4, '972-5389-0123');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (5, '972-5260-1234');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (6, '972-5221-2345');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (7, '972-5212-3456');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (8, '972-5303-4567');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (9, '972-5874-5678');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (10, '972-5485-6789');
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
values (22, '972-574772244');
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
values (31, '972-507794638');
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
values (48, '972-541588725');
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
values (62, '972-546169810');
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
values (81, '972-531692258');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (82, '972-574675402');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (83, '972-508381148');
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
values (94, '972-590897906');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (95, '972-581502999');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (96, '972-537254918');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (97, '972-588791151');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (98, '972-581029498');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (99, '972-549816337');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (100, '972-519907759');
commit;
prompt 100 records committed...
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (101, '972-509215046');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (102, '972-548271533');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (103, '972-539594473');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (104, '972-587441505');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (105, '972-525750412');
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
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (115, '972-503074859');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (116, '972-563710849');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (117, '972-551553007');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (118, '972-589210222');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (119, '972-584284956');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (120, '972-531606319');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (121, '972-503623822');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (122, '972-576228648');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (123, '972-598208116');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (124, '972-583129813');
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
values (131, '972-595237930');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (132, '972-508056869');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (133, '972-504847376');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (134, '972-549777002');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (135, '972-511952781');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (136, '972-592068682');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (137, '972-539456049');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (138, '972-594656932');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (139, '972-522917913');
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
values (149, '972-542003737');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (150, '972-579418305');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (151, '972-517776031');
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
values (157, '972-594176313');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (158, '972-523925566');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (159, '972-547454822');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (160, '972-572320159');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (161, '972-518909384');
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
values (172, '972-592892271');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (173, '972-565078410');
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
values (180, '972-550035185');
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
values (186, '972-566404015');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (187, '972-512083821');
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
values (194, '972-543173858');
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
commit;
prompt 200 records committed...
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (201, '972-554386694');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (202, '972-525525565');
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
values (209, '972-584879732');
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
values (217, '972-570829779');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (218, '972-573094607');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (219, '972-513618696');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (220, '972-590076358');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (221, '972-547229567');
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
values (237, '972-562442315');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (238, '972-561508595');
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
values (245, '972-560642692');
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
values (252, '972-579481873');
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
values (260, '972-569251748');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (261, '972-592621534');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (262, '972-551969695');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (263, '972-567827013');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (264, '972-530742465');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (265, '972-596001794');
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
values (272, '972-516011716');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (273, '972-574320980');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (274, '972-597488605');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (275, '972-594988493');
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
values (296, '972-508112915');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (297, '972-520081998');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (298, '972-532238898');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (299, '972-563699906');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (300, '972-571375016');
commit;
prompt 300 records committed...
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (301, '972-517672098');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (302, '972-592419900');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (303, '972-511626217');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (304, '972-536980265');
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
values (318, '972-538762812');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (319, '972-590322212');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (320, '972-523804467');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (321, '972-540331369');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (322, '972-589101287');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (323, '972-562165158');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (324, '972-511938617');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (325, '972-574544083');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (326, '972-552021499');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (327, '972-525248377');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (328, '972-577823694');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (329, '972-587343352');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (330, '972-592649343');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (331, '972-504974470');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (332, '972-597088071');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (333, '972-581227068');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (334, '972-534885541');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (335, '972-556270367');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (336, '972-502444681');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (337, '972-531517408');
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
values (346, '972-579091872');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (347, '972-537474042');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (348, '972-525940819');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (349, '972-561819857');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (350, '972-508152014');
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
values (356, '972-544781011');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (357, '972-559449353');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (358, '972-502475906');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (359, '972-557902225');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (360, '972-599272738');
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
values (372, '972-599572825');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (373, '972-553863783');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (374, '972-535065374');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (375, '972-502111717');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (376, '972-535764495');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (377, '972-551329225');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (378, '972-535634204');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (379, '972-517789505');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (380, '972-579791678');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (381, '972-507692457');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (382, '972-586085724');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (383, '972-573310106');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (384, '972-501761347');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (385, '972-535438739');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (386, '972-525655305');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (387, '972-573597504');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (388, '972-531427714');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (389, '972-596740481');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (390, '972-511285456');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (391, '972-533562932');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (392, '972-580646266');
insert into STAFF_MEMBER_INFO (sid, phone_number)
values (393, '972-519307425');
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
prompt 400 records loaded
prompt Enabling foreign key constraints for CLEANING_TASK...
alter table CLEANING_TASK enable constraint SYS_C008905;
alter table CLEANING_TASK enable constraint SYS_C008906;
prompt Enabling foreign key constraints for INSPECTION_LOGS...
alter table INSPECTION_LOGS enable constraint SYS_C008920;
prompt Enabling foreign key constraints for MAINTENANCE_REQUEST...
alter table MAINTENANCE_REQUEST enable constraint SYS_C008913;
alter table MAINTENANCE_REQUEST enable constraint SYS_C008914;
prompt Enabling foreign key constraints for NEED_FOR...
alter table NEED_FOR enable constraint SYS_C008927;
alter table NEED_FOR enable constraint SYS_C008928;
prompt Enabling foreign key constraints for STAFF_MEMBER_INFO...
alter table STAFF_MEMBER_INFO enable constraint SYS_C008932;
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
