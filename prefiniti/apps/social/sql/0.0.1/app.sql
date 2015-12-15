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
select 'Building database structure for social app...' as ' ';
select ' ' as ' ';

--
-- populate entry in apps table
--

select ' ' as ' ';
select 'Populating apps table for social app...' as ' ';
select ' ' as ' ';

call addApp('social', 'Social Networking', 'Social Networking application', 'Coherent Logic Development', @appsAdded);
