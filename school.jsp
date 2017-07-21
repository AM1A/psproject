<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
table,th,td {
	border: 1px solid black;
	border-collapse: collapse;
}
th,td {
	padding: 15px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>School</title>
</head>
<body style = "background-color: mintcream;">
<%!
String Name;
String FatherName;
String Dob;
String Sex;
String Ref_ID;
String Address;
String School_name;
String Tuit_fee;
String Tuit_fee_status;
String Hostel_fee;
String Hostel_fee_status;
String Trans_fee;
String Trans_fee_status;
String Scholarship;
String Scholarship_awarded;
%>
<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs1 = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
ResultSet rs4 = null;
ResultSet rs5 = null;
ResultSet rs6 = null;

String driverName = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/project";
String user = "root";
String dbpsw = "robert8472";

String sql2="select * from sinfo where ref_id="+session.getAttribute("id");
String sql3="select * from tuit_fee where ref_id="+session.getAttribute("id");
String sql4="select * from hostel_fee where ref_id="+session.getAttribute("id");
String sql5="select * from trans_fee where ref_id="+session.getAttribute("id");
String sql6="select * from sship where ref_id="+session.getAttribute("id");

try
{
java.lang.Class.forName(driverName + "");
con = DriverManager.getConnection(url, user, dbpsw);
Statement stmt = con.createStatement();

ps = con.prepareStatement(sql2);
rs1 = ps.executeQuery(sql2);

if(rs1.next())
{
	Ref_ID = rs1.getString("ref_id");
	Name = rs1.getString("name");
	FatherName = rs1.getString("fname");
	Dob = rs1.getString("dob");
	Sex = rs1.getString("sex");
	Address = rs1.getString("address");
	School_name = rs1.getString("school");
}

else
	response.sendRedirect("error.jsp");
	rs1.close();
	ps.close();
}

catch(SQLException sqe)
{
	out.println(sqe);
}
%>
<p style="font-family: trebuchet; color:navy; font-size: 25px;"><b><i> Welcome, <%out.println(Name); %> </i></b></p>
<center><h2 style="font-family: georgia; color:crimson; font-size: 20px;"> <b><i> Student Information </i> </b> </h2></center>
<table align="center">
<tr>
<td>Name :</td>
<td><b><%out.println(Name); %></b></td>
<td>Father's Name :</td>
<td><b><%out.println(FatherName); %></b></td>
</tr>
<tr>
<td>Date of Birth :</td>
<td><b><%out.println(Dob); %></b></td>
<td>Sex :</td>
<td><b><%out.println(Sex); %></b></td>
</tr>
<tr>
<td>Reference ID :</td>
<td><b><%out.println(Ref_ID);%></b></td>
<td>Address :</td>
<td><b><%out.println(Address); %></b></td>
</tr>
<tr>
<td>School :</td>
<td><b><%out.println(School_name);%></b></td>
<td>--</td>
<td>--</td>
</tr>
</table><br>
<center><h2 style="font-family: serif; color: green; font-size: 25px;"> <b> <i> Billing Information </i></b></h2></center>

<%
try
{
	java.lang.Class.forName(driverName + "");
	con = DriverManager.getConnection(url, user, dbpsw);
	Statement stmt= con.createStatement();

	ps = con.prepareStatement(sql3);
	rs2 = ps.executeQuery(sql3);
	if(rs2.next())
	{
		Tuit_fee = rs2.getString("amount");
		Tuit_fee_status = rs2.getString("status");
	}
	
	else
		response.sendRedirect("error.jsp");
	rs2.close();
	ps.close();
}

catch(SQLException sqe)
{
	out.println(sqe);
}	
%>

<%
try
{
	java.lang.Class.forName(driverName + "");
	con = DriverManager.getConnection(url, user, dbpsw);
	Statement stmt= con.createStatement();

	ps = con.prepareStatement(sql4);
	rs3 = ps.executeQuery(sql4);
	if(rs3.next())
	{
		Hostel_fee = rs3.getString("amount");
		Hostel_fee_status = rs3.getString("status");
	}
	
	else
		response.sendRedirect("error.jsp");
	rs3.close();
	ps.close();
}

catch(SQLException sqe)
{
	out.println(sqe);
}	
%>

<%
try
{
	java.lang.Class.forName(driverName + "");
	con = DriverManager.getConnection(url, user, dbpsw);
	Statement stmt= con.createStatement();

	ps = con.prepareStatement(sql5);
	rs4 = ps.executeQuery(sql5);
	if(rs4.next())
	{
		Trans_fee = rs4.getString("amount");
		Trans_fee_status = rs4.getString("status");
	}
	
	else
		response.sendRedirect("error.jsp");
	rs4.close();
	ps.close();
}

catch(SQLException sqe)
{
	out.println(sqe);
}	
%>

<%
try
{
	java.lang.Class.forName(driverName + "");
	con = DriverManager.getConnection(url, user, dbpsw);
	Statement stmt= con.createStatement();

	ps = con.prepareStatement(sql6);
	rs5 = ps.executeQuery(sql6);
	if(rs5.next())
	{
		Scholarship = rs5.getString("amount");
		Scholarship_awarded = rs5.getString("awarded");
	}
	
	else
		response.sendRedirect("error.jsp");
	rs5.close();
	ps.close();
}

catch(SQLException sqe)
{
	out.println(sqe);
}	
%>

<form action="payment2.jsp" method="post">
<table align="center">
<tr>
<td><b><i>Types of fees</i></b></td>
<td><b><i>Bill Amount</i></b></td>
<td><b><i>Status</i></b></td>
<td><b><i>Payment Selection</i></b></td>
</tr>
<tr>
<td>Tuition Fee </td>
<td><b><%out.println(Tuit_fee); %></b></td>
<td><%out.println(Tuit_fee_status); %></td>
<td>
<% if(Tuit_fee_status.equals("unpaid")){%>
<input type="checkbox" name="Payment" value="Tuition">Select
<%}
else	
%></td>
</tr>

<tr>
<td>Hostel Fee </td>
<td><b><%out.println(Hostel_fee); %></b></td>
<td><%out.println(Hostel_fee_status); %></td>
<td>
<% if(Hostel_fee_status.equals("unpaid")){%>
<input type="checkbox" name="Payment" value="Hostel">Select
<%}
else	
%></td>
</tr>

<tr>
<td>Transport Fee </td>
<td><b><%out.println(Trans_fee); %></b></td>
<td><%out.println(Trans_fee_status); %></td>
<td>
<% if(Trans_fee_status.equals("unpaid")){%>
<input type="checkbox" name="Payment" value="Transport">Select
<%}
else	
%></td>
</tr>

<tr>
<td> Scholarship </td>
<td><b><%out.println(Scholarship); %></b></td>
<td>
<% if(Scholarship_awarded.equals("no")){%>
<input type="hidden" name="Payment" value="Scholarship">
<% } 
else %>
</td>
<td>--</td>
</tr>
</table><br>

<center><input type="submit" value="Pay"></center></form>
</body>
</html>