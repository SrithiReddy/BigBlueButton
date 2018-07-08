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

<%!     



static String tablename;
ResultSet rs;



 


%>

<br>

<%

	if (request.getParameterMap().isEmpty()) {

		//
		// Assume we want to create a meeting
		//
%>
<%@ include file="demo_header.jsp"%>
<h2>Display Tables</h2>

<p /><br />
<FORM NAME="form1" METHOD="GET">
 <table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>
		
                        <tr>
			<td width="75%"> USERS :  <input type="hidden"  autofocus required name="display" value="users" readonly >
			<p />
			</td>
                     
                        <td>
                        
		
			<input id="submit-button1" type="submit" value="Users" /></td>
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
<td width="75%"> Meeting : <input type="hidden" autofocus required name="display" value="meeting" readonly >
                       
			<p />
			</td>
                      
                         <td>
                        
			
			<input id="submit-button2" type="submit" value="Meeting" /></td>
                         </tr>
<INPUT TYPE=hidden NAME=action VALUE="enter"> <br />

</tbody>
</table>
</FORM>
  <FORM NAME="form3" METHOD="GET">
             <table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>        

                      <td width="75%">Join Meeting : <input type="hidden" autofocus required name="display" value="joinmeeting" readonly >
                       
			<p />
			</td>
                        
                         <td>
                        
			
			<input id="submit-button3" type="submit" value="join meeting" /></td>
                         </tr>
<INPUT TYPE=hidden NAME=action VALUE="enter"> <br />

			
	</tbody>
</table>
</FORM>
<FORM NAME="form4" METHOD="GET">
             <table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>        

                      <td width="75%">Tutor : <input type="hidden" autofocus required name="display" value="tutor" readonly >
                       
			<p />
			</td>
                        
                         <td>
                        
			
			<input id="submit-button3" type="submit" value="tutor" /></td>
                         </tr>
<INPUT TYPE=hidden NAME=action VALUE="enter"> <br />

			
	</tbody>
</table>
                        
 </FORM>




<%
}
 
else if (request.getParameter("action").equals("enter")) {
tablename=request.getParameter("display");
try {
            	 Class.forName("com.mysql.jdbc.Driver");
                 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/demo","root","root");
PreparedStatement stmt;

if(tablename.equals("users"))
{

stmt=conn.prepareStatement("select * from users");
rs=stmt.executeQuery();


%>

<table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>
<tr>
<th>PantherID</th>
<th>FullName</th>
<th>LastName</th>
<th>Password</th>
</tr>
<%
while(rs.next()){
%>
<tr>
<td><%=rs.getString(1)%></td>
<td><%=rs.getString(2)%></td>
<td><%=rs.getString(3)%></td>
<td><%=rs.getString(4)%></td>
</tr>
<%
}
%>
</tbody>

</table>


<%

}
else if(tablename.equals("meeting"))
{
stmt=conn.prepareStatement("select * from meeting");
rs=stmt.executeQuery();


%>

<table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>
<tr>
<th>creatorID</th>
<th>coursename</th>
<th>meetingID</th>
<th>createdate</th>
<th>starttime</th>
<th>endtime</th>

</tr>
<%
while(rs.next()){
%>
<tr>
<td><%=rs.getString(1)%></td>
<td><%=rs.getString(2)%></td>
<td><%=rs.getString(3)%></td>
<td><%=rs.getString(4)%></td>
<td><%=rs.getString(5)%></td>
<td><%=rs.getString(6)%></td>

</tr>
<%
}
%>
</tbody>

</table>

<%


}
else if(tablename.equals("joinmeeting"))
{
stmt=conn.prepareStatement("select * from joinmeeting");
rs=stmt.executeQuery();


%>

<table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>
<tr>
<th>meetingID</th>
<th>pantherid</th>
<th>jointime</th>
<th>endtime</th>
<th>coursename</th>


</tr>
<%
while(rs.next()){
%>
<tr>
<td><%=rs.getString(1)%></td>
<td><%=rs.getString(2)%></td>
<td><%=rs.getString(3)%></td>
<td><%=rs.getString(4)%></td>
<td><%=rs.getString(5)%></td>


</tr>
<%
}
%>
</tbody>

</table>

<%


}
else if(tablename.equals("tutor"))
{
stmt=conn.prepareStatement("select * from tutor");
rs=stmt.executeQuery();


%>

<table width=600 cellspacing="20" cellpadding="20"
	style="border-collapse: collapse; border-right-color: rgb(136, 136, 136);"
	>
	<tbody>
<tr>
<th>tutorid</th>
<th>coursename</th>



</tr>
<%
while(rs.next()){
%>
<tr>
<td><%=rs.getString(1)%></td>
<td><%=rs.getString(2)%></td>



</tr>
<%
}
%>
</tbody>

</table>

<%


}
}
 catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

}

%>

</body>
</html>





