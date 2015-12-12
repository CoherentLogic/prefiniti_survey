<cfscript>

pageApp = "";
pageItem = "";
pageView = "";
pageBody = "";

if(!isDefined("session.prefinitiSession")) {
    location("/login.cfm", false);
}

if(!session.prefinitiSession.getAuthenticated()) {
    location("/login.cfm", false);
}

if(isDefined("url.dashboard")) {
    pageBody = "/prefiniti/core/dashboards/" & url.dashboard & ".cfm";
}
else {
    if(isDefined("url.app")) {
	pageApp = url.app;
	
	if(!isDefined("url.view")) {
	    location("/404.cfm", false);
	}
	else {
	    pageView = url.view;

	    if(isDefined("url.item")) {
		pageItem = url.item;
	    }

	    pageBody = "/prefiniti/apps/" & pageApp & "/forms/" & pageView & ".cfm";
	}
    }       
}
</cfscript>