<!--

BigBlueButton - http://www.bigbluebutton.org

Copyright (c) 2008-2009 by respective authors (see below). All rights reserved.

BigBlueButton is free software; you can redistribute it and/or modify it under the 
terms of the GNU Lesser General Public License as published by the Free Software 
Foundation; either version 3 of the License, or (at your option) any later 
version. 

BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY 
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along 
with BigBlueButton; if not, If not, see <http://www.gnu.org/licenses/>.

Author: Fred Dixon <ffdixon@bigbluebutton.org>

-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	response.setCharacterEncoding("UTF-8"); 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Registration</title>
</head>
<body>

<%@ include file="bbb_api.jsp"%>
 
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Date"%>
<% 

//
// We're going to define some sample courses (meetings) below.  This API exampe shows how you can create a login page for a course. 
// The password below are not available to users as they are compiled on the server.
//

HashMap<String, HashMap> allMeetings = new HashMap<String, HashMap>();
HashMap<String, String> meeting;

// String welcome = "<br>Welcome to %%CONFNAME%%!<br><br>For help see our <a href=\"event:http://www.bigbluebutton.org/content/videos\"><u>tutorial videos</u></a>.<br><br>To join the voice bridge for this meeting:<br>  (1) click the headset icon in the upper-left, or<br>  (2) dial xxx-xxx-xxxx (toll free:1-xxx-xxx-xxxx) and enter conference ID: %%CONFNUM%%.<br><br>";

String welcome = "<br>Welcome to <b>%%CONFNAME%%</b>!<br><br>To understand how BigBlueButton works see our <a href=\"event:http://www.bigbluebutton.org/content/videos\"><u>tutorial videos</u></a>.<br><br>To join the audio bridge click the headset icon (upper-left hand corner). <b>You can mute yourself in the Listeners window.</b>";

//
// English courses
//

meeting = new HashMap<String, String>();
allMeetings.put( "ENGL-2013: Research Methods in English", meeting );	// The title that will appear in the drop-down menu
	meeting.put("welcomeMsg", 	welcome);			// The welcome mesage
	meeting.put("moderatorPW", 	"prof123");			// The password for moderator
	meeting.put("viewerPW", 	"student123");			// The password for viewer
	meeting.put("voiceBridge", 	"72013");			// The extension number for the voice bridge (use if connected to phone system)
	meeting.put("logoutURL", 	"/demo/demo3.jsp");  // The logout URL (use if you want to return to your pages)

meeting = new HashMap<String, String>();
allMeetings.put( "ENGL-2213: Drama Production I", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"72213");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

meeting = new HashMap<String, String>();
allMeetings.put( "ENGL-2023: Survey of English Literature", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"72023");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

//
// Law Courses
//

meeting = new HashMap<String, String>();
allMeetings.put( "LAW-1323: Fundamentals of Advocacy ", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"71232");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

meeting = new HashMap<String, String>();
allMeetings.put( "LAW-2273: Business Organizations", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"72273");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

meeting = new HashMap<String, String>();
allMeetings.put( "LAW-3113: Corporate Finance", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"theprof");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"71642");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");


//
// Professor's Virtaul Office Hours
//

meeting = new HashMap<String, String>();
allMeetings.put( "Virtual Office Hours - Steve Stoyan", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"70001");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

meeting = new HashMap<String, String>();
allMeetings.put( "Virtual Office Hours - Michael Bailetti", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"70002");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");

meeting = new HashMap<String, String>();
allMeetings.put( "Virtual Office Hours - Tony Weiss", meeting );
	meeting.put("welcomeMsg", 	welcome);
	meeting.put("moderatorPW", 	"prof123");
	meeting.put("viewerPW", 	"student123");
	meeting.put("voiceBridge", 	"70003");
	meeting.put("logoutURL", 	"/demo/demo3.jsp");


meeting = null;

Iterator<String> meetingIterator = new TreeSet<String>(allMeetings.keySet()).iterator();

if (request.getParameterMap().isEmpty()) {
		//
		// Assume we want to join a course
		//
	%> 
<%@ include file="demo_header.jsp"%>

<h2>Create a SignUp (password required)</h2>


<FORM NAME="form1" METHOD="GET">
<table cellpadding="5" cellspacing="5" style="width: 400px; ">
	<tbody>
		<tr>
			<td>
				&nbsp;</td>
			<td style="text-align: right; ">
				Full&nbsp;Name:</td>
			<td style="width: 5px; ">
				&nbsp;</td>
			<td style="text-align: left ">
				<input type="text" autofocus required name="FirstName" /></td>
		</tr>
<tr>
			<td>
				&nbsp;</td>
			<td style="text-align: right; ">
				Last&nbsp;Name:</td>
			<td style="width: 5px; ">
				&nbsp;</td>
			<td style="text-align: left ">
				<input type="text" autofocus required name="LastName" /></td>
		</tr>
		
	<tr>
			<td>
				&nbsp;</td>
			<td style="text-align: right; ">
				PantherID</td>
			<td style="width: 5px; ">
				&nbsp;</td>
			<td style="text-align: left ">
				<input type="text" autofocus required name="PantherID" /></td>
		</tr>
		
		
		
		<tr>
			<td>
				&nbsp;</td>
			<td style="text-align: right; ">
				Password:</td>
			<td>
				&nbsp;</td>
			<td>
				<input type="password" required name="password" /></td>
		</tr>
		
		<tr>
			<td>
				&nbsp;</td>
			<td>
				&nbsp;</td>
			<td>
				&nbsp;</td>
			<td>
				<input type="submit" value="Join" /></td>
		</tr>	
	</tbody>
</table>
<INPUT TYPE=hidden NAME=action VALUE="create">
</FORM>




<%
	} else if (request.getParameter("action").equals("create")) {
		
		
		String PantherID = request.getParameter("PantherID");
		String FullName= request.getParameter("FirstName");
		String LastName = request.getParameter("LastName");
                String password = request.getParameter("password");
		
		
		%>

        <%!
       PreparedStatement stmt = null;
       Connection con = null;
       ResultSet rs = null;
       StringBuffer sb = new StringBuffer("");
   %>
 
<%
   try{  
%>

<%
Class.forName("com.mysql.jdbc.Driver");  
%>

<%
 con=DriverManager.getConnection("jdbc:mysql://localhost/demo","root","root"); %>
 
<%
stmt= con.prepareStatement("insert into users(pantherid,fullname,lastname,password) values (?,?,?,?)");
stmt.setString(1,PantherID);
stmt.setString(2,FullName);
stmt.setString(3,LastName);
stmt.setString(4,password);

stmt.executeUpdate();

 
con.close();    
} //try block ends
catch(Exception e)
{ System.out.println(e);}
		
		
%>

<script language="javascript" type="text/javascript">
  window.location.href="VirtualTutoringRoom.jsp";
</script>

<%
	} 
%>
 

</body>
</html>


