component output="false"
{


    this.name = "prefiniti";
    this.applicationTimeout = createTimeSpan(0, 1, 0, 0);
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0, 0, 30, 0);
    this.setClientCookies = true;   

    public boolean function OnApplicationStart() {

        return true;
    }

    public void function OnApplicationEnd(struct ApplicationScope = structNew()) {

    }

    public void function OnRequest(required string TargetPage) {

    }

    public boolean function OnRequestStart(required string TargetPage) {

        include arguments.TargetPage;                           

        return true;
    }

    public void function OnRequestEnd() {

    }

    public void function OnCFCRequest(string cfc, string method, struct args) {

    }

    public void function OnSessionStart() {
	session.datasource = "prefiniti";
	session.prefinitiSession = new prefiniti.core.api.session(ID = session.sessionid,
							 Username = "guest",
							 IPAddress = CGI.REMOTE_ADDR,
							 UserAgent = CGI.HTTP_USER_AGENT);
    }

    public void function OnSessionEnd(required struct SessionScope, struct ApplicationScope = structNew()) {

//	structClear(arguments.SessionScope);

    }
    
}