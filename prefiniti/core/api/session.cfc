<cfcomponent name="session" extends="prefiniti.core.api.base" accessors="true" output="false">

  <cfproperty name="ID" type="string"/>
  <cfproperty name="Username" type="string"/>
  <cfproperty name="IPAddress" type="string"/>
  <cfproperty name="UserAgent" type="string"/>
  <cfproperty name="OpenedTimestamp" type="date"/>
  <cfproperty name="ClosedTimestamp" type="date"/>
  <cfproperty name="Authenticated" type="boolean" default="false"/>
  <cfproperty name="AuthenticationMessage" type="string" default=""/>

  <cffunction name="init" returntype="component" access="public" output="false" hint="Constructor">
    <cfargument name="ID" type="string" required="true"/>
    <cfargument name="Username" type="string" required="true"/>
    <cfargument name="IPAddress" type="string" required="true"/>
    <cfargument name="UserAgent" type="string" required="true"/>

    <cfscript>
    this.setID(arguments.ID);
    this.setUsername(arguments.Username);
    this.setIPAddress(arguments.IPAddress);
    this.setUserAgent(arguments.UserAgent);
    this.setOpenedTimestamp(now());
    this.setAuthenticated(false);

    authValue = 0;

    </cfscript>

    <cfquery name="q" datasource="#session.datasource#">
      insert into login_sessions 
      	     	  (id,
		  fk_user_id,
		  ip_address,
		  user_agent,
		  opened_timestamp,
		  authenticated)
		  values
		  ('#this.getID()#',
		  '#this.getUsername()#',
		  '#this.getIPAddress()#',
		  '#this.getUserAgent()#',
		  #createODBCDateTime(this.getOpenedTimestamp())#,
		  #authValue#)
    </cfquery>
    
    <cfreturn this>
  </cffunction>

  <cffunction name="save" returntype="component" access="public" output="false">

    <cfscript>
      if(this.getAuthenticated()) {
          authValue = 1;
      }
      else {
          authValue = 0;
      }
    </cfscript>

    <cfquery name="q" datasource="#session.datasource#">
      update login_sessions
      set fk_user_id='#this.getUsername()#',
      	  ip_address='#this.getIPAddress()#',
	  user_agent='#this.getUserAgent()#',
	  authenticated=#authValue#
    </cfquery>

    <cfreturn this>
  </cffunction>

  <cffunction name="authenticate" returntype="component" access="public" output="false">
    <cfargument name="username" type="string" required="true"/>
    <cfargument name="password" type="string" required="true"/>

    <cfscript>
      userRecord = new prefiniti.core.api.user(ID = arguments.username);
      userRecord.open();
      userRecord.authenticate(arguments.password);

      this.setUsername(arguments.username);

      if(userRecord.getAuthenticated()) {
	  this.setAuthenticationMessage("Authentication succeeded.");
	  this.setAuthenticated(true);	
      }
      else {
	  this.setAuthenticationMessage("Invalid username or password.");
	  this.setAuthenticated(false);
      }

      this.user = userRecord;

      this.save();
    </cfscript>

    <cfreturn this>
  </cffunction>
</cfcomponent>
