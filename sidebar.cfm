<nav class="navbar-default navbar-static-side" role="navigation">
  <div class="sidebar-collapse">
    <ul class="nav metismenu" id="side-menu">
      <li class="nav-header">
	<img src="/img/prefiniti-small.png" alt="Large Prefiniti Logo" style="margin-bottom: 20px;">
        <div class="dropdown profile-element"> <span>
            <img alt="image" class="img-circle" src="/img/profile_small.jpg" />
          </span>
          <a data-toggle="dropdown" class="dropdown-toggle" href="#">
            <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold"><cfoutput>#session.prefinitiSession.user.getFirstName()# #session.prefinitiSession.user.getLastName()#</cfoutput></strong>
              </span> <span class="text-muted text-xs block"><cfoutput>#session.prefinitiSession.user.getTitle()#</cfoutput> <b class="caret"></b></span> </span> </a>
          <ul class="dropdown-menu animated fadeInRight m-t-xs">
            <li><a href="profile.html">Profile</a></li>
            <li><a href="contacts.html">Contacts</a></li>
            <li><a href="mailbox.html">Mailbox</a></li>
            <li class="divider"></li>
            <li><a href="login.cfm?logout=true">Logout</a></li>
          </ul>
        </div>
        <div class="logo-element">
          <img src="/img/prefiniti-square.png" alt="Small Prefiniti Logo">
        </div>
      </li>
      <li class="active">
        <a href="index.html"><i class="fa fa-th-large"></i> <span class="nav-label">Dashboards</span> <span class="fa arrow"></span></a>
        <ul class="nav nav-second-level">
          <li class="active"><a href="/dashboards/default">Default</a></li>
        </ul>
      </li>
      <li>
        <a href="mailbox.html"><i class="fa fa-envelope"></i> <span class="nav-label">Mailbox </span><span class="label label-warning pull-right">16/24</span></a>
        <ul class="nav nav-second-level collapse">
          <li><a href="mailbox.html">Inbox</a></li>
          <li><a href="mail_detail.html">Email view</a></li>
          <li><a href="mail_compose.html">Compose email</a></li>
          <li><a href="email_template.html">Email templates</a></li>
        </ul>
      </li>
      <li>
	<a href="#"><i class="fa fa-globe"></i> <span class="nav-label">Survey </span> <span class="fa arrow"></span></a>
	<ul class="nav nav-second-level collapse">
	  <li><a href="/apps/survey/list"><i class="fa fa-cube"></i> <span class="nav-label">Projects </span></a></li>
	</ul>
      </li>
      <li>
	<a href="/apps/timecard/list"><i class="fa fa-clock-o"></i> <span class="nav-label">Time Cards </span></a>
      </li>
    </ul>
  </div>
</nav>
