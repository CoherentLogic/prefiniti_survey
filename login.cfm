<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Prefiniti | Login</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

</head>

<body class="gray-bg">

  <cfif isDefined("url.logout")>
    <cfset session.prefinitiSession.setAuthenticated(false)/>
    <cfset session.prefinitiSession.user.setAuthenticated(false)/>
  </cfif>

    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div>

	  <cfif isDefined("form.submit")>
	    <cfset session.prefinitiSession.authenticate(form.username, form.password)/>
	    <cfif session.prefinitiSession.getAuthenticated()>
	      <cflocation url="/dashboards/default" addtoken="no">
	    </cfif>
	  </cfif>

            <h3>Welcome to Prefiniti</h3>

            <form class="m-t" role="form" action="login.cfm" method="post">
	      <cfif isDefined("form.submit") AND NOT session.prefinitiSession.getAuthenticated()>
		<div><cfoutput>#session.prefinitiSession.getAuthenticationMessage()#</cfoutput></div>
	      </cfif>
                <div class="form-group">
                    <input name="username" type="text" class="form-control" placeholder="Username" required="">
                </div>
                <div class="form-group">
                    <input name="password" type="password" class="form-control" placeholder="Password" required="">
                </div>
                <button type="submit" name="submit" class="btn btn-primary block full-width m-b">Login</button>

                <a href="forgot_password.cfm"><small>Forgot password?</small></a>
                <p class="text-muted text-center"><small>Do not have an account?</small></p>
                <a class="btn btn-sm btn-white btn-block" href="register.cfm">Create an account</a>
            </form>
            <p class="m-t"> <small>Copyright &copy; 2015 Coherent Logic Development LLC</small> </p>
        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="js/jquery-2.1.1.js"></script>
    <script src="js/bootstrap.min.js"></script>

</body>

</html>
