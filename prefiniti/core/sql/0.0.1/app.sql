--
--    app.sql
--     
--    This file is part of Prefiniti.
--
--    Prefiniti is free software: you can redistribute it and/or modify
--    it under the terms of the GNU Affero General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    Prefiniti is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU Affero General Public License for more details.
--
--    You should have received a copy of the GNU Affero General Public License
--    along with Prefiniti.  If not, see <http://www.gnu.org/licenses/>.
--

select 'Creating prefiniti database...' as ' ';

drop database if exists prefiniti;
create database prefiniti;

use prefiniti;

select ' ' as ' ';
select 'Creating users table...' as ' ';
select ' ' as ' ';

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
       primary key (id)   
);             

describe users;

--
-- populate standard users
--
lock tables users write;
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

select ' ' as ' ';
select 'Creating groups table...' as ' ';
select ' ' as ' ';

create table groups (
       id varchar(255) not null,
       primary key (id)
);

describe groups;

--
-- populate standard groups
--
lock tables groups write;
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

select ' ' as ' ';
select 'Creating group_memberships table...' as ' ';
select ' ' as ' ';

create table group_memberships (
       id varchar(255) not null,
       fk_user_id varchar(255) not null,
       fk_group_id varchar(255) not null,
       primary key (id)
);

describe group_memberships;

-- 
-- populate standard memberships
--
lock tables group_memberships write;
insert into group_memberships
values (UUID(), 'admin', 'Site Admins');
unlock tables;

--
-- group_admins table
--

select ' ' as ' ';
select 'Creating group_admins table...' as ' ';
select ' ' as ' ';

create table group_admins (
       id varchar(255) not null,
       fk_user_id varchar(255) not null,
       fk_group_id varchar(255) not null,
       primary key (id)
);

describe group_admins;

--
-- make admin user an administrator of all groups
--
lock tables group_admins write;
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

-- 
-- set up sessions table
--

select ' ' as ' ';
select 'Creating login_sessions table...' as ' ';
select ' ' as ' ';

create table login_sessions (
       id varchar(255) not null,
       cf_token varchar(255) not null default '',
       ip_address varchar(255) not null default '',
       user_agent varchar(255) not null default '',
       username varchar(255) not null,
       opened_timestamp datetime,
       closed_timestamp datetime,
       primary key(id)
);

-- 
-- set up permissions
--

select ' ' as ' ';
select 'Setting up database permissions...' as ' ';
select ' ' as ' ';

grant all on prefiniti.* to prefiniti@'localhost' identified by 'prefiniti';
flush privileges;

select ' ' as ' ';

show tables;