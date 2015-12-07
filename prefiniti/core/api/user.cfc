<cfcomponent name="user" extends="prefiniti.core.api.base" accessors="true" output="false">
  
  <cfproperty name="ID" type="string"/>
  <cfproperty name="EMail" type="string"/>
  <cfproperty name="PasswordHash" type="string"/>
  <cfproperty name="Password" type="string"/>
  <cfproperty name="ConfirmationID" type="string"/>
  <cfproperty name="Enabled" type="boolean"/>
  <cfproperty name="SMSNumber" type="string"/>
  <cfproperty name="FirstName" type="string"/>
  <cfproperty name="MiddleInitial" type="string"/>
  <cfproperty name="LastName" type="string"/>
  <cfproperty name="Gender" type="string"/>
  <cfproperty name="Phone" type="string"/>
  <cfproperty name="StreetAddress" type="string"/>
  <cfproperty name="City" type="string"/>
  <cfproperty name="State" type="string"/>
  <cfproperty name="ZIP" type="string"/>

  <cfproperty name="written" type="boolean" default="false"/>

  <cffunction name="init" returntype="component" access="public" output="false" hint="Constructor">
    <cfset super.init(argumentsCollection=arguments)>

    <cfreturn this>
  </cffunction>

  <cffunction name="open" returntype="component" access="public" output="false" hint="Load a user from the database">
    <cfquery name="qOpen" datasource="#application.datasource#">
      select * from users where id=<cfqueryparam value="#getID()#" cfsqltype="cf_sql_varchar" maxlength="255"/>
    </cfquery>


  </cffunction>

	     
</cfcomponent>
