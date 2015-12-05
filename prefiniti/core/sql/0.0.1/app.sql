drop database if exists 'prefiniti';
create database 'prefiniti';

use prefiniti;

--
-- create users table
--
create table users (
       id varchar(255) not null,
       email_address varchar(255) not null default '',
       password_hash varchar(255) not null,	
       confirmation_id varchar(255) not null default '',
       enabled tinyint(3) not null default '0',
       sms_number varchar(255) not null default '',
       first_name varchar(50) not null default '',
       middle_initial char(1) not null default '',
       last_name varchar(50) not null default '',  
       gender char(1) not null default '',
       phone varchar(45) not null default '',
       street_address varchar(255) not null default '',
       city varchar(255) not null default '',
       `state` char(2) not null default '',
       zip char(10) not null default '',
       primary key ('id')   
);             

--
-- populate standard users
--
lock tables 'users' write;
insert into users 
       (id,
       password_hash,
       enabled,
       first_name,
       last_name)
values ('admin',
       SHA1('password1234'),
       1,
       'Default',
       'Administrator');
unlock tables;

--
-- create groups table
--
create table groups (
       id varchar(255) not null,
       primary key ('id')
);

--
-- populate standard groups
--
lock tables 'groups' write;
insert into groups 
values ('Site Admins'),
       ('Business Managers'),
       ('Financial Managers'),
       ('Project Managers'),
       ('Technical Managers'),
       ('Surveyors'),
       ('Party Chiefs'),
       ('Field Assistants'),
       ('Drafters'),
       ('GIS Technicians'),
       ('Legal'),
       ('Financial'),
       ('Marketing'),
       ('Information Technology'),
       ('Software Developers'),
       ('Customers');
unlock tables;

-- 
-- group_memberships table
--
create table group_memberships (
       id varchar(255) not null,
       fk_user_id varchar(255) not null,
       fk_group_id varchar(255) not null,
       primary key ('id')
);

-- 
-- populate standard memberships
--
lock tables 'group_memberships' write;
insert into group_memberships
values (UUID(), 'admin', 'Site Admins', 1);
unlock tables;

--
-- group_admins table
--
create table group_admins (
       id varchar(255) not null,
       fk_user_id varchar(255) not null,
       fk_group_id varchar(255) not null,
       primary key ('id')
);

--
-- make admin user an administrator of all groups
--
lock tables 'group_administrators' write;
insert into group_admins
values (UUID(), 'admin', 'Site Admins'),
       (UUID(), 'admin', 'Business Managers'),
       (UUID(), 'admin', 'Financial Managers'),
       (UUID(), 'admin', 'Project Managers'),
       (UUID(), 'admin', 'Technical Managers'),
       (UUID(), 'admin', 'Surveyors'),
       (UUID(), 'admin', 'Party Chiefs'),
       (UUID(), 'admin', 'Field Assistants'),
       (UUID(), 'admin', 'Drafters'),
       (UUID(), 'admin', 'GIS Technicians'),
       (UUID(), 'admin', 'Legal'),
       (UUID(), 'admin', 'Financial'),
       (UUID(), 'admin', 'Marketing'),
       (UUID(), 'admin', 'Information Technology'),
       (UUID(), 'admin', 'Software Developers'),
       (UUID(), 'admin', 'Customers');
unlock tables;
