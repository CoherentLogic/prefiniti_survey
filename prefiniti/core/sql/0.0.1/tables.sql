--
--    tables.sql
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

--
-- create apps table
--
select ' ' as ' ';
select 'Creating apps table...' as ' ';
select ' ' as ' ';

create table apps (
       id varchar(255) not null,
       app_name varchar(50) not null default '',
       app_description varchar(255) not null default '',
       vendor_name varchar(255) not null default '',
       primary key (id)
);

describe apps;

--
-- create app_event_types table
--

select ' ' as ' ';
select 'Creating app_event_types table...' as ' ';
select ' ' as ' ';

create table app_event_types (
       id varchar(255) not null,
       fk_app_id varchar(255) not null,
       event_type varchar(255) not null,
       event_icon varchar(50) not null default 'fa-info-circle',
       foreign key (fk_app_id) references apps(id) on update cascade on delete restrict,
       primary key (id)
);

--
-- create app_events table
--

select ' ' as ' ';
select 'Creating app_events table...' as '';
select ' ' as ' ';

create table app_events (
       id varchar(255),
       fk_app_event_type_id varchar(255) not null,
       event_text varchar(255) not null,
       foreign key (fk_app_event_type_id) references app_event_types(id) on update cascade on delete restrict,
       primary key (id)
);

describe app_events;


--
-- create users table
--

select ' ' as ' ';
select 'Creating users table...' as ' ';
select ' ' as ' ';

create table users (
       id varchar(255) not null,
       email_address varchar(255) not null default '',
       password_hash varchar(255) not null,	
       password_question varchar(255) not null default '',
       password_answer varchar(255) not null default '',
       password_expired bool not null default false,
       confirmation_id varchar(255) not null default '',
       enabled bool not null default false,       
       sms_number varchar(255) not null default '',
       first_name varchar(50) not null default '',
       middle_initial char(1) not null default '',
       last_name varchar(50) not null default '',  
       title varchar(50) not null default '',
       gender char(1) not null default '',
       phone varchar(45) not null default '',
       street_address varchar(255) not null default '',
       city varchar(255) not null default '',
       `state` char(2) not null default '',
       zip char(10) not null default '',
       unique(email_address),
       primary key (id)   
);             

describe users;

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
-- group_memberships table
--

select ' ' as ' ';
select 'Creating group_memberships table...' as ' ';
select ' ' as ' ';

create table group_memberships (
       id varchar(255) not null,
       fk_user_id varchar(255) not null,
       fk_group_id varchar(255) not null,
       foreign key (fk_user_id) references users(id) on update cascade on delete restrict,
       foreign key (fk_group_id) references groups(id) on update cascade on delete restrict,
       primary key (id)
);

describe group_memberships;


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
       foreign key (fk_user_id) references users(id) on update cascade on delete restrict,
       foreign key (fk_group_id) references groups(id) on update cascade on delete restrict,
       primary key (id)
);

describe group_admins;

-- 
-- set up sessions table
--

select ' ' as ' ';
select 'Creating login_sessions table...' as ' ';
select ' ' as ' ';

create table login_sessions (
       id varchar(255) not null,
       fk_user_id varchar(255) not null,
       ip_address varchar(255) not null default '',
       user_agent varchar(255) not null default '',       
       opened_timestamp datetime,
       closed_timestamp datetime,
       authenticated bool not null default false,
       foreign key (fk_user_id) references users(id) on update cascade on delete restrict,
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