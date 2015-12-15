--
--    procedures.sql
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
select 'Defining stored procedures...' as ' ';
select ' ' as ' ';

delimiter $$


create procedure getAllApps()
begin
	select * from apps;
end $$

create procedure getApp(in appID varchar(255))
begin
	select * from apps where id=appID;
end $$

create procedure addApp(in appID varchar(255),
       		   	in appName varchar(50),
			in appDescription varchar(255),
			in vendorName varchar(255),
			out appsAdded int)
begin
	declare matchingApps int;

	select count(*) into matchingApps from apps where id=appID;

	if matchingApps = 0 then
	   insert into apps(id, app_name, app_description, vendor_name)
	   values (appID, appName, appDescription, vendorName);

	   select 1 into appsAdded;
	else
	   select 0 into appsAdded;
	end if;

end $$

create procedure updateApp(in currentAppID varchar(255),
       		 	   in newAppID varchar(255),
       		 	   in appName varchar(50),
			   in appDescription varchar(255),
			   in vendorName varchar(255),
			   out appsUpdated int)
begin
	declare matchingApps int;
	declare conflictingApps int;

	select count(*) into matchingApps from apps where id=currentAppID;
	select count(*) into conflictingApps from apps where id=newAppID;

	if matchingApps > 0 and conflictingApps = 0 then
	   update apps
	   set	  id=newAppId,
	   	  app_name=appName,
		  app_description=appDescription,
		  vendor_name=vendorName
	   where  id=currentAppID;
	  
	   select 1 into appsUpdated;
	else
	   select 0 into appsUpdated;
	end if;
end $$			   

create procedure removeApp(in appID varchar(255), out appsRemoved int)
begin
	declare matchingApps int;
	select count(*) into matchingApps from apps where id=appID;

	if matchingApps > 0 then
	   delete from app_event_types where fk_app_id=appID;
	   delete from apps where id=appID;

	   select 1 into appsRemoved;
	else
	   select 0 into appsRemoved;
	end if;
end $$

create procedure getAllEventTypes()
begin
	select * from app_event_types;
end $$

create procedure getEventType(eventTypeID varchar(255))
begin
	select * from app_event_types where id=eventTypeID;
end $$


create procedure getEventTypesByApp(in appID varchar(255))
begin
	select * from app_event_types where fk_app_id=appID;
end $$

create procedure addEventType(in appID varchar(255), 
       		 	      in eventType varchar(255), 
			      in eventIcon varchar(50), 
			      out eventTypeID varchar(255),
			      out eventsAdded int)
begin
	declare matchingApps int;
	
	select count(*) into matchingApps from apps where id=appID;

	if matchingApps > 0 then
	   select UUID() into eventTypeID;	  

	   insert into app_event_types (id, fk_app_id, event_type, event_icon)
	   values (eventTypeID, appID, eventType, eventIcon);

	   select count(*) into eventsAdded from app_event_types where id=eventTypeID;	   

	else

	   select 0 into eventsAdded;

        end if;		
end $$

create procedure removeEventType(in eventTypeID varchar(255), out eventTypesRemoved int)
begin
	declare matchingEventTypes int;

	select count(*) into matchingEventTypes from app_event_types where id=eventTypeID;

	if matchingEventTypes > 0 then
	   delete from app_event_types where id=eventTypeID;

	   select 1 into eventTypesRemoved;
	else
	   select 0 into eventTypesRemoved;
	end if;
end $$

create procedure addEvent(in eventTypeID varchar(255), 
       		 	  in eventText varchar(255),
			  out eventID varchar(255),
			  out eventsAdded int)
begin
	declare matchingEventTypes int;

	select count(*) into matchingEventTypes from app_event_types where id=eventTypeID;
	select UUID() into eventID;
	      
	if matchingEventTypes > 0 then
	   insert into app_events (id, fk_app_event_type_id, event_text)
	   values (eventID, eventTypeID, eventText);
	end if

	select count(*) into eventsAdded from app_events where id=eventID;
end $$

create procedure getAllUsers()
begin
	select * from users;
end $$

create procedure getUser(in userName varchar(255))
begin
	select * from users where id=userName;
end $$

create procedure addUserMinimal(in userName varchar(255),
       		 		in password varchar(255),
				in firstName varchar(50),
				in lastName varchar(50),
				in title varchar(50),
				out confirmationID varchar(255),
				out usersAdded int)
begin
	call addUser(userName,
		     '',
		     password,
		     '',
		     '',
		     false,
		     false,
		     '',
		     firstName,
		     '',
		     lastName,
		     title,
		     '',
		     '',
		     '',
		     '',
		     '',
		     '',
		     @confirmationID,
		     @usersAdded);
		     
end $$

create procedure addUser(in userName varchar(255),
       		 	 in emailAddress varchar(255),
			 in password varchar(255),
			 in passwordQuestion varchar(255),
			 in passwordAnswer varchar(255),
			 in passwordExpired bool,
			 in accountEnabled bool,
			 in smsNumber varchar(255),
			 in firstName varchar(50),
			 in middleInitial char(1),
			 in lastName varchar(50),
			 in title varchar(50),
			 in gender char(1),
			 in phone varchar(45),
			 in addressStreet varchar(255),
			 in addressCity varchar(255),
			 in addressState char(2),
			 in addressZIP char(10),
			 out confirmationID varchar(255),
			 out usersAdded int)
begin

	declare passwordHash varchar(255);
	declare matchingUsers int;

	select SHA1(password) into passwordHash;
	select UUID() into confirmationID;

	select count(*) into matchingUsers from users where id=userName or email_address=emailAddress;

	if matchingUsers = 0 then

		insert into users(id,
		                  email_address,
				  password_hash,
			  	  password_question,
				  password_answer,
			  	  password_expired,
			  	  confirmation_id,
			 	  enabled,
			  	  sms_number,
			  	  first_name,
			  	  middle_initial,
			  	  last_name,
			  	  title,
			  	  gender,
			  	  phone,
			  	  street_address,
			  	  city,
			  	  `state`,
			  	  zip)
        	values		 (userName,
			 	 emailAddress,
			 	 passwordHash,
			 	 passwordQuestion,
			 	 passwordAnswer,
			 	 passwordExpired,
			 	 confirmationID,
			 	 enabled,
			 	 smsNumber,
			 	 firstName,
			 	 middleInitial,
			 	 lastName,
			 	 title,
			 	 gender,
			 	 phone,
			 	 addressStreet,
			 	 addressCity,
			 	 addressState,
			 	 addressZIP);		

        	select count(*) into usersAdded from users where id=userName;
	else

		select 0 into usersAdded;

	end if;

end $$			 

create procedure removeUser(in userName varchar(255), out usersRemoved int)
begin

	declare matchingUsers int;

	select count(*) into matchingUsers from users where id=userName;

	if matchingUsers > 0 then
	   delete from users where id=userName;
	   select 1 into usersRemoved;
	else
	   select 0 into usersRemoved;
	end if;

end $$

create procedure addGroup(in groupName varchar(255), out groupsAdded int)
begin

	declare matchingGroups int;

	select count(*) into matchingGroups from groups where id=groupName;

	if matchingGroups = 0 then
	   insert into groups(id) values(groupName);
	   select 1 into groupsAdded;
	else
	   select 0 into groupsAdded;
	end if;

end $$

create procedure removeGroup(in groupName varchar(255), out groupsRemoved int)
begin

	declare matchingGroups int;

	select count(*) into matchingGroups from groups where id=groupName;

	if matchingUsers > 0 then
	   delete from group_memberships where fk_group_id=groupName;
	   delete from groups where id=userName;
	   select 1 into groupsRemoved;
	else
	   select 0 into groupsRemoved;
	end if;

end $$

create procedure joinGroup(in userName varchar(255), in groupName varchar(255), out groupsJoined int)
begin
	declare membershipID varchar(255);
	
	declare matchingUsers int;
	declare matchingGroups int;

	select UUID() into membershipID;	

	select count(*) into matchingUsers from users where id=userName;
	select count(*) into matchingGroups from groups where id=groupName;

	if matchingUsers > 0 and matchingGroups > 0 then
	   insert into group_memberships(id, fk_user_id, fk_group_id)
	   values (membershipID, userName, groupName);

	   select 1 into groupsJoined;
	else
	   select 0 into groupsJoined;
	end if;
end $$

create procedure leaveGroup(in userName varchar(255), in groupName varchar(255), out groupsLeft int)
begin
	declare matchingMemberships int;

	select count(*) into matchingMemberships from group_memberships
	where fk_user_id=userName and fk_group_id=groupName;

	if matchingMemberships > 0 then
	   delete from group_memberships where fk_user_id=userName and fk_group_id=groupName;
	   select 1 into groupsLeft;
	else
	   select 0 into groupsLeft;
	end if;
end $$

create procedure addAdminToGroup(in userName varchar(255), in groupName varchar(255), out adminsAdded int)
begin
	declare matchingGroups int;
	declare matchingUsers int;
	declare adminID varchar(255);

	select count(*) into matchingGroups from groups where id=groupName;
	select count(*) into matchingUsers from users where id=userName;
	select UUID() into adminID;

	if matchingGroups > 0 and matchingUsers > 0 then
	   insert into group_admins(id, fk_user_id, fk_group_id)
	   values (adminID, userName, groupName);

	   select 1 into adminsAdded;
	else
	   select 0 into adminsAdded;
	end if;
end $$

create procedure removeAdminFromGroup(in userName varchar(255), in groupName varchar(255), out adminsRemoved int)
begin
	declare matchingAdmins int;

	select count(*) into matchingAdmins from group_admins
	where fk_user_id=userName and fk_group_id=groupName;

	if matchingAdmins > 0 then
	   delete from group_admins where fk_user_id=userName and fk_group_id=groupName;
	   select 1 into adminsRemoved;
	else
	   select 0 into adminsRemoved;
	end if;
end $$
	   
create procedure addLoginSession(in userName varchar(255),
       		 		 in ipAddress varchar(255),
				 in userAgent varchar(255),
				 out sessionID varchar(255),
				 out sessionsCreated int)
begin
	select UUID() into sessionID;

	insert into login_sessions (id,
	       	    		   fk_user_id,
				   ip_address,
				   user_agent,
				   opened_timestamp)
	values			   (sessionID,
				   userName,
				   ipAddress,
				   userAgent,
				   now());

	select 1 into sessionsCreated;
end $$

create procedure authenticateLoginSession(in username varchar(255),
       		 			  in password varchar(255),
					  in sessionID varchar(255),
					  out authenticationMessage varchar(255),
					  out passwordExpired bool,				  
					  out sessionsAuthenticated int)
begin
	declare matchingAccounts int;
	declare accountEnabled bool;

	select count(*) into matchingAccounts from users 
	where id=username and password_hash=SHA1(password);

	if matchingAccounts > 0 then
	   select enabled into accountEnabled from users where id=username;
	   select password_expired into passwordExpired from users where id=username;

	   if accountEnabled = true then
	      update login_sessions set authenticated=true where id=sessionID;

	      select count(*) into sessionsAuthenticated from login_sessions
	      where id=sessionID and authenticated=true;	     

	      select 'Welcome to Prefiniti' into authenticationMessage;
	   else
	      select 'Account disabled' into authenticationMessage;
	   end if;
	else
	   select false into passwordExpired;
	   select 0 into sessionsAuthenticated;
	   select 'Invalid username or password' into authenticationMessage;
	end if;
end $$
				 
show procedure status where db='prefiniti';