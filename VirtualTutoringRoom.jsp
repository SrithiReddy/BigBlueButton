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
	<title>Join a Session</title>

	<script type="text/javascript"
		src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/heartbeat.js"></script>
</head>
<script>
function check()
{
if(new Date().getHours()>"5"){
document.getElementById("submit-button1").disabled=true;
}
if(new Date().getHours()>"11"){
document.getElementById("submit-button2").disabled=true;
}
if(new Date().getHours()>"5"){
document.getElementById("submit-button3").disabled=true;
}
}
</script>
<body >


<%@ include file="bbb_api.jsp"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%> 
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>



<br>

<%
	if (request.getParameterMap().isEmpty()) {

		//
		// Assume we want to create a meeting
		//
%>
<%@ include file="demo_header.jsp"%>
<h2>Join a session</h2>

<p />
<FORM NAME="form1" METHOD="GET">
 
<table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>
		
                        <tr>
			<td width="75%"> CSC 1302 Principles Of Computer Science 2:00 PM  - 5:00 PM <input type="hidden" id="c1" name="coursename" value="CSC130225" readonly >
			<p />
			</td>
                     
                        <td>
                        
		
			<input id="submit-button1" type="submit" value="join meeting" /></td>
</tr>
<INPUT TYPE=hidden NAME=action VALUE="enter"> <br />
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
                      
                         <td>
                        
			
			<input id="submit-button2" type="submit" value="join meeting" /></td>
                         </tr>
<INPUT TYPE=hidden NAME=action VALUE="enter"> <br />
</FORM>
</tbody>
</table>
  <FORM NAME="form3" METHOD="GET">
             <table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>        

                      <td width="75%">CSC 3302 System Level Programming 2:00 PM- 5:00PM <input type="hidden" autofocus required name="coursename" value="CSC330225" readonly >
                       
			<p />
			</td>
                        
                         <td>
                        
			
			<input id="submit-button3" type="submit" value="join meeting" /></td>
                         </tr>
<INPUT TYPE=hidden NAME=action VALUE="enter"> <br />
</FORM>
			
	</tbody>
</table>









<%
	} else if (request.getParameter("action").equals("enter")) {
		//
		// The user is now attempting to joing the meeting
		//
		String coursename = request.getParameter("coursename");
String joinURL=null;
 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                 Date mycreatedate = sdf.parse(sdf.format(new Date()));
String createdate=sdf.format(mycreatedate);
		String meetingID= coursename+createdate;
try {
            	 Class.forName("com.mysql.jdbc.Driver");
                 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/demo","root","root");
                 PreparedStatement stmt = null;
stmt= conn.prepareStatement("select url from meeting where meetingID=?");
stmt.setString(1,meetingID);
ResultSet rs=stmt.executeQuery();
if(rs.next()==false)
{
%>
<script type="text/javascript">
confirm("Meeting is not yet created by tutor");
window.location="VirtualTutoringRoom.jsp";
</script>
<%
}
else
{

 joinURL=rs.getString("url");

if(joinURL==null)
{
%>
<script>

confirm("Meeting is not properly created by tutor or meeting has already over");
window.location="VirtualTutoringRoom.jsp";
</script>

<%
}
else
{
%>
<script>
window.location = "<%=joinURL%>";
</script>
<%
}
}
           

            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

		
}
%>















</body>
</html>
