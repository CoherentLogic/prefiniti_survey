<cfcomponent name="user" extends="prefiniti.core.api.base" accessors="true" output="false">
  
  <cfproperty name="ID" type="string"/>
  <cfproperty name="EMail" type="string"/>
  <cfproperty name="PasswordHash" type="string"/>
  <cfproperty name="PasswordQuestion" type="string"/>
  <cfproperty name="PasswordAnswer" type="string"/>
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

    <cfquery name="q" datasource="#application.datasource#">
      select * from users where id=<cfqueryparam value="#this.getID()#" cfsqltype="cf_sql_varchar" maxlength="255"/>
    </cfquery>

    <cfscript>
      this.setEMail(q.email_address);
      this.setPasswordHash(q.password_hash);
      this.setPasswordQuestion(q.password_question);
      this.setPasswordAnswer(q.password_answer);
      this.setConfirmationID(q.confirmation_id);
      this.setEnabled(q.enabled);
      this.setSMSNumber(q.sms_number);
      this.setFirstName(q.first_name);
      this.setMiddleInitial(q.middle_initial);
      this.setLastName(q.last_name);
      this.setGender(q.gender);
      this.setPhone(q.phone);
      this.setStreetAddress(q.street_address);
      this.setCity(q.city);
      this.setState(q.state);
      this.setZIP(q.ZIP);
      this.setWritten(true);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="save" returntype="component" access="public" output="false" hint="Save a user to the database">

    <cfscript>

      if(this.getWritten()) {
        this.updateExisting();
      }
      else {
        this.writeNew();
      }

    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="writeNew" returntype="component" access="public" output="false">

    <cfquery name="q" datasource="#application.datasource#">
      insert into users (id,
                        email_address,
      			confirmation_id,
			enabled,
			sms_number,
			first_name,
			middle_initial,
			last_name,
			gender,
			phone,
			street_address,
			city,
			`state`,
			zip)
      values		
			('#this.getID()#',
			'#this.getEmail()#',
			'#this.getConfirmationID()#',
			#this.getEnabled()#,
			'#this.getSMSNumber()#',
			'#this.getFirstName()#',
			'#this.getMiddleInitial()#',
			'#this.getLastName()#',
			'#this.getGender()#',
			'#this.getPhone()#',
			'#this.getStreetAddress()#',
			'#this.getCity()#',
			'#this.getState()#',
			'#this.getZIP()#')      
    </cfquery>

    <cfscript>
      this.setWritten(true);
    </cfscript>

    <cfreturn this>
  </cffunction>

  <cffunction name="updateExisting" returntype="component" access="public" output="false">
  
    <cfquery name="q" datasource="#application.datasource#">
      update users 
      set email_address='#this.getEmail()#',
	  confirmation_id='#this.getConfirmationID()#',
	  enabled=#this.getEnabled()#,
	  sms_number='#this.getSMSNumber()#',
	  first_name='#this.getFirstName()#',
	  middle_initial='#this.getMiddleInitial()#',
	  last_name='#this.getLastName()#',
	  gender='#this.getGender()#',
	  phone='#this.getPhone()#',
	  street_address='#this.getStreetAddress()#',
	  city='#this.getCity()#',
	  `state`='#this.getState()#',
	  zip='#this.getZIP()#'
      where id='#this.getID()#'
    </cfquery>

    <cfreturn this>
  </cffunction>

  <cffunction name="updatePassword" returntype="component" access="public" output="false">
    <cfargument name="password" type="string" required="true"/>
    <cfargument name="passwordQuestion" type="string" required="true"/>
    <cfargument name="passwordAnswer" type="string" required="true"/>

    <cfscript>
      this.setPasswordHash(hash(arguments.password, "SHA"));
      this.setPasswordQuestion(arguments.passwordQuestion);
      this.setPasswordAnswer(arguments.passwordAnswer);
    </cfscript>

    <cfquery name="q" datasource="#application.datasource#">
      update users
      set password_hash='#this.getPasswordHash()#',
      	  password_question='#this.getPasswordQuestion()#',
	  password_answer='#this.getPasswordAnswer()#'
      where id='#this.getID()#'
    </cfquery>

    <cfreturn this>
  </cffunction>
	     
</cfcomponent>
