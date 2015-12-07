<cfcomponent name="base" accessors="true" output="false" hint="The prefiniti.core.api.base component provides global functionality for all Prefiniti API components, including instance configuration and utility functions useful for higher-level applications. Most Prefiniti components extend this component.">

  <cffunction name="init" returntype="component" output="false" hint="Base component constructor. Components extending this component must call super.init() in their own constructor to ensure that instance data for the base component is properly initialized.">

    <cfreturn this>
  </cffunction>

  <cffunction name="readSetting" returntype="string" access="public" output="false" hint="Read a setting from the Prefiniti instance configuration">
    <cfargument name="category" required="true" type="string" hint="Settings category"/>
    <cfargument name="setting" required="true" type="string" hint="Setting to read"/>

    <cfset iniPath = expandPath("/prefiniti.ini")/>

    <cfreturn getProfileString(iniPath, arguments.category, arguments.setting)>   
  </cffunction>

  <cffunction name="writeSetting" returntype="string" access="public" output="false" hint="Write a setting to the Prefiniti instance configuration.">
    <cfargument name="category" required="true" type="string" hint="Settings category"/>
    <cfargument name="setting" required="true" type="string" hint="Setting to save"/>
    <cfargument name="value" required="true" type="string" hint="New value for setting"/>

    <cfset iniPath = expandPath("/prefiniti.ini")/>
    <cfset writeProfileString(iniPath, arguments.category, arguments.setting, arguments.value)/>

    <cfreturn value>
  </cffunction>

</cfcomponent>
