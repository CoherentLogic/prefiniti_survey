component name="prefiniti" output="true"
{

    this = {
	name: "prefiniti",
	applicationTimeout: createTimeSpan(0, 1, 0, 0),
	sessionManagement: true,
	sessionTimeout: createTimeSpan(0, 0, 30, 0),
	setClientCookies: true,
	datasource: "prefiniti"
    };
    
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

    }

    public void function OnSessionEnd(required struct SessionScope, struct ApplicationScope = structNew()) {

	structClear(arguments.SessionScope);

    }
    
}