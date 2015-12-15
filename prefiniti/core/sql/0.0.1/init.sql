--
--    init.sql
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

use prefiniti;

select ' ' as ' ';
select 'Initializing core database data...' as ' ';
select ' ' as ' ';


call addApp('core', 'Prefiniti Core', 'Prefiniti core functionality', 'Coherent Logic Development', @appsAdded);

call addUserMinimal('admin', 'password1234', 'Default', 'Administrator', 'Built-in account', @confID, @usersAdded);

call addGroup('Site Admins', @groupsAdded);
call addGroup('Business Managers', @groupsAdded);
call addGroup('Financial Managers', @groupsAdded);
call addGroup('Project Managers', @groupsAdded);
call addGroup('Technical Managers', @groupsAdded);
call addGroup('Surveyors', @groupsAdded);
call addGroup('Party Chiefs', @groupsAdded);
call addGroup('Field Assistants', @groupsAdded);
call addGroup('Drafters', @groupsAdded);
call addGroup('GIS Technicians', @groupsAdded);
call addGroup('Legal', @groupsAdded);
call addGroup('Financial', @groupsAdded);
call addGroup('Marketing', @groupsAdded);
call addGroup('Information Technology', @groupsAdded);
call addGroup('Software Developers', @groupsAdded);
call addGroup('Customers', @groupsAdded);

call joinGroup('admin', 'Site Admins', @groupsJoined);

call addAdminToGroup('admin', 'Site Admins', @adminsAdded);
call addAdminToGroup('admin', 'Business Managers', @adminsAdded);
call addAdminToGroup('admin', 'Financial Managers', @adminsAdded);
call addAdminToGroup('admin', 'Project Managers', @adminsAdded);
call addAdminToGroup('admin', 'Technical Managers', @adminsAdded);
call addAdminToGroup('admin', 'Surveyors', @adminsAdded);
call addAdminToGroup('admin', 'Party Chiefs', @adminsAdded);
call addAdminToGroup('admin', 'Field Assistants', @adminsAdded);
call addAdminToGroup('admin', 'Drafters', @adminsAdded);
call addAdminToGroup('admin', 'GIS Technicians', @adminsAdded);
call addAdminToGroup('admin', 'Legal', @adminsAdded);
call addAdminToGroup('admin', 'Financial', @adminsAdded);
call addAdminToGroup('admin', 'Marketing', @adminsAdded);
call addAdminToGroup('admin', 'Information Technology', @adminsAdded);
call addAdminToGroup('admin', 'Software Developers', @adminsAdded);
call addAdminToGroup('admin', 'Customers', @adminsAdded);