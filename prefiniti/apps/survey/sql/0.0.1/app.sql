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

-- 
-- SQL statements in this script depend on the core database being built.
-- To do this, go to the root of the project and type the following command:
--
-- $ make coredb
--


use prefiniti;

select ' ' as ' ';
select 'Building database structure for survey app...' as ' ';

--
-- create survey_orders table
--
select 'Creating survey_orders table...' as ' ';
select ' ' as ' ';

--
-- status: 0 - awaiting agent input, 1 - awaiting customer input,  2 - processed
--
create table survey_orders (
       id varchar(255) not null,
       fk_ordering_user_id varchar(255) not null,
       fk_client_user_id varchar(255) not null,
       fk_processing_agent_id varchar(255),
       fk_location_id varchar(255) not null,
       fk_filing_id varchar(255) not null,
       fk_project_id varchar(255) not null,
       fk_survey_workflow_id varchar(255) not null,
       placed_date datetime,
       status smallint,    
       due_date datetime not null,
       processed_date datetime,
       reversed_date datetime,              
       allow_publication tinyint(3),
       primary key (id)
);

create index survey_orders_ordering_id on survey_orders(fk_ordering_user_id) using hash;
create index survey_orders_client_id on survey_orders(fk_client_user_id) using hash;
create index survey_orders_processor_id on survey_orders(fk_processing_agent_id) using hash;

describe survey_orders;

--
-- create survey_order_comments table
--

select ' ' as ' ';
select 'Creating survey_order_comments table...' as ' ';
select ' ' as ' ';

create table survey_order_comments (
       id varchar(255) not null,
       fk_order_id varchar(255) not null,
       fk_user_id varchar(255) not null,
       comment_timestamp datetime not null,
       comment_text varchar(255) not null,       
       primary key (id)
);

create index survey_order_comments_order_id on survey_order_comments(fk_order_id) using hash;

describe survey_order_comments;

--
-- create survey_locations table
--

select ' ' as ' ';
select 'Creating survey_locations table...' as ' ';
select ' ' as ' ';

create table survey_locations (
       id varchar(255) not null,
       l_subdivision varchar(255),
       l_block varchar(255),
       l_lot varchar(255),
       l_section varchar(255),
       l_township varchar(255),
       l_range varchar(255),
       l_address varchar(255),
       l_city varchar(255),
       l_state varchar(255),
       l_zip varchar(255),
       l_latitude varchar(255),
       l_longitude varchar(255),
       fk_geodigraph_server_id varchar(255),
       fk_geodigraph_layer_id varchar(255),
       fk_geodigraph_pkey varchar(255),
       primary key (id)
);

describe survey_locations;

--
-- create survey_filings table
--

select ' ' as ' ';
select 'Creating survey_filings table...' as ' ';
select ' ' as ' ';

create table survey_filings (
       id varchar(255) not null,
       document_name varchar(255),       
       filing_category enum('File', 'Storage', 'Deed', 'Subdivision'),
       filing_container enum('Cabinet', 'Shelf', 'Plat', 'Book'),
       filing_division varchar(255),
       filing_material_type enum('Folder', 'Box', 'Page', 'Slide'),
       filing_number varchar(255),
       document_number varchar(255),
       document_url varchar(255),
       usrs_parcel varchar(255),
       usrs_sheet varchar(255),
       filed_with varchar(255),
       primary key (id)
);

create index survey_filings_document_name on survey_filings(document_name) using hash;
       
describe survey_filings;

--
-- create survey_workflows table
--

select ' ' as ' ';
select 'Creating survey_workflows table...' as ' ';
select ' ' as ' ';

create table survey_workflows (
       id varchar(255) not null,
       workflow_name varchar(255) not null,
       primary key (id)
);

describe survey_workflows;

-- 
-- create survey_workflow_steps table
--

select ' ' as ' ';
select 'Creating survey_workflow_steps table...' as ' ';
select ' ' as ' ';

create table survey_workflow_steps (
       id varchar(255) not null,
       fk_survey_workflow_id varchar(255) not null,
       step_name varchar(255) not null,
       step_number integer not null,       
       primary key(id)
);

describe survey_workflow_steps;

--
-- create survey_projects table
--

select ' ' as ' ';
select 'Creating survey_projects table...' as ' ';
select ' ' as ' ';

-- note that id is equivalent to clsJobNumber in the original prefiniti db
create table survey_projects (
       id varchar(255) not null,
       fk_survey_order_id varchar(255) not null,
       fk_survey_workflow_id varchar(255) not null,
       due_date datetime,
       primary key(id)
);

describe survey_projects;

--
-- populate entry in apps table
--

select ' ' as ' ';
select 'Populating apps table for survey app...' as ' ';
select ' ' as ' ';

call addApp('survey', 'Survey', 'Survey project management application', 'Coherent Logic Development');
