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
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title>Create Your Own Meeting</title>

	<script type="text/javascript"
		src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/heartbeat.js"></script>
</head>
<body>


<%@ include file="bbb_api.jsp"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="java.util.concurrent.Executors" %>
<%@ page import="java.util.concurrent.ScheduledExecutorService"%>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%> 
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>


<%!     



static String username,meetingID,endtime,starttime,coursename,createtime;
static String joinURL,PantherID,b1;
static int rowsaffected=0;


 


%>

<%
	if (request.getParameterMap().isEmpty()) {
		//
		// Assume we want to create a meeting
		//
%>
<%@ include file="demo_header.jsp"%>


<h2>Create Your Own Meeting</h2>

<p />
<FORM NAME="form1" METHOD="GET">
 
<table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>
		
                        <tr>
			<td width="75%"> CSC 1302 Principles Of Computer Science 2:00 PM  - 5:00 PM <input type="hidden"  name="coursename" value="CSC130225" readonly >
			<p />
			</td>
                        <input name="starttime" type="hidden" value="2:00 PM" />
                        <input name="endtime" type="hidden" value="5:00 PM"/>
                         <td>
                        <input id="submit-button" name="b1"type="submit" value="end meeting" /></td>
			<td>
			<input id="submit-button" name="b1"type="submit" value="create meeting" /></td>


</tr>
<INPUT TYPE=hidden NAME=action VALUE="login"> <br />
	</tbody>
</table>
</FORM>
                        <FORM NAME="form2" METHOD="GET">
 
<table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>
                        <tr>
<td width="75%"> CSC 1302 Principles Of Computer Science 10:00 AM - 12:00 AM <input type="hidden" autofocus required name="coursename" value="CSC13021012" readonly >
                       
			<p />
			</td>
                        <input name="starttime" type="hidden" value="10:00 AM" />
                        <input name="endtime" type="hidden" value="12:00 AM"/>
                         <td>
                        <input id="submit-button" name="b1"type="submit" value="end meeting" /></td>
			<td>
			<input id="submit-button" name="b1"type="submit" value="create meeting" /></td>
                         </tr>
<INPUT TYPE=hidden NAME=action VALUE="login"> <br />
</FORM>
</tbody>
</table>
  <FORM NAME="form3" METHOD="GET">
             <table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>        

                      <td width="75%">csc 3302 System Level Programming 2:00 PM- 5:00PM <input type="hidden" autofocus required name="coursename" value="CSC330225" readonly >
                       
			<p />
			</td>
                         <input name="starttime" type="hidden" value="2:00 PM" />
                        <input name="endtime" type="hidden" value="5:00 AM"/>
                          <td>
                        <input id="submit-button" name="b1"type="submit" value="end meeting" /></td>
			<td>
			<input id="submit-button" name="b1"type="submit" value="create meeting" /></td>
                         </tr>
<INPUT TYPE=hidden NAME=action VALUE="login"> <br />

			
	</tbody>
</table>
</FORM>


<%
	} else if (request.getParameter("action").equals("enter")) {

		//
		// User has requested to create a meeting
		//
                 TimeZone.setDefault(TimeZone.getTimeZone("America/New_York"));

                 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                 Date mycreatedate = sdf.parse(sdf.format(new Date()));
 username="Srithi";
 PantherID=request.getParameter("PantherID");
 String createdate=sdf.format(mycreatedate);
int rowseffected=0;
 meetingID=coursename+createdate;
                joinURL =getJoinURL(username, meetingID, "false", "<br>Welcome to %%CONFNAME%%.<br>", null, null);
  PreparedStatement stmt=null,stmt1 = null,stmt2=null;
                ResultSet rs1,rs=null;
 try {
            	 Class.forName("com.mysql.jdbc.Driver");
                 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/demo","root","root");
               

stmt= conn.prepareStatement("select coursename from tutor where tutorid=?");
stmt.setString(1,PantherID);
 rs=stmt.executeQuery();
//conn.close();
}
catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }


if(rs.next()==false)
{
%>
<script>
confirm("You Don't have Permissions to create meeting");
window.location="logincreate.jsp";
</script>
 <%
}
else if(b1.equals("create meeting"))

{

try{
 Class.forName("com.mysql.jdbc.Driver");
                 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/demo","root","root");
stmt1=conn.prepareStatement("select coursename from meeting where meetingID=?");
stmt1.setString(1,meetingID);
 rs1=stmt1.executeQuery();
if(rs1.next()==false)
{
stmt1= conn.prepareStatement("insert into meeting values (?,?,?,?,?,?,?)");
stmt1.setString(1,username);
stmt1.setString(2,coursename);
stmt1.setString(3,meetingID);
stmt1.setString(4,createdate);
stmt1.setString(5,starttime);
stmt1.setString(6,endtime);
stmt1.setString(7,joinURL);
rowsaffected=stmt1.executeUpdate();

           
if(rowsaffected>0){
%>
<script>
confirm("Meeting created successfully");

</script>
<%
 


}
else{
%>
<script>
confirm("enter the details properly");

</script>
<%
}

}
else{
%>
<script>
confirm("meeting already exits");
window.location="VirtualTutoringRoom.jsp";
</script>
<%
}
 
       }
catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }     


}
else if(b1.equals("end meeting"))
{

String status=endMeeting(meetingID,"mp");
if(status=="true")
{
try{
 Class.forName("com.mysql.jdbc.Driver");
 Connection con = DriverManager.getConnection("jdbc:mysql://localhost/demo","root","root");
stmt1=con.prepareStatement("delete from meeting where meetingID=?");
stmt1.setString(1,meetingID);
stmt1.executeUpdate();
}catch (Exception e) 
{
                // TODO Auto-generated catch block
                e.printStackTrace();
            } 
%>
<script>
confirm("Ended successfully");
</script>
<%
}
else
{
%>
<script>
confirm("Issues While ending");
</script>
<%
}
}

}

else if(request.getParameter("action").equals("login")){
coursename=request.getParameter("coursename");
b1=request.getParameter("b1");
starttime=request.getParameter("starttime");
endtime=request.getParameter("endtime");

%>

<%@ include file="demo_header.jsp"%>

 
<div>
<center>
<h2>Create a Session </h2>


<FORM NAME="form1" METHOD="GET">
<table cellpadding="5" cellspacing="5" style="width: 400px; ">
	<tbody>
		<tr>
			<td>
				&nbsp;</td>
			<td style="text-align: right; ">
				PantherID&nbsp;</td>
			<td style="width: 5px; ">
				&nbsp;</td>
			<td style="text-align: left ">
				<input type="text" autofocus required name="PantherID" /></td>
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
<INPUT TYPE=hidden NAME=action VALUE="enter">
</FORM>
 
<%
}
%>



</body>
</html>
