<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bill Payment</title>
</head>
<body>
<%! String Name;
String FatherName;
String DOB;
String Sex;
String Ref_ID;
String Address;
String Elec_Bill;
String House_Rent;
String Water_Bill;
String Hospital_Bill;
String Gas_Bill;
String Elec_Status;
String House_Status;
String Water_Status;
String Hospital_Status;
String Gas_Status;
%>
<%
Connection con= null;
PreparedStatement ps = null;
ResultSet rs1 = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
ResultSet rs4 = null;
ResultSet rs5 = null;
ResultSet rs6 = null;

String driverName = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/TEST";
String user = "root";
String dbpsw = "ANANY";


String sql2="select * from pinfo where ref_id="+session.getAttribute("id");
String sql3="select * from electricity_bill where ref_id="+session.getAttribute("id");
String sql4="select * from township_house_bill where ref_id="+session.getAttribute("id");
String sql5= "select * from water_bill where ref_id="+session.getAttribute("id");
String sql6= "select * from hospital_bill where ref_id="+session.getAttribute("id");
String sql7= "select * from gas_bill where ref_id="+session.getAttribute("id");
try
{
Class.forName(driverName);
con = DriverManager.getConnection(url, user, dbpsw);
Statement stmt= con.createStatement();

ps = con.prepareStatement(sql2);
rs1 = ps.executeQuery(sql2);
if(rs1.next())
{
	
	Ref_ID= rs1.getString("ref_id");
	Name= rs1.getString("name");
	FatherName= rs1.getString("fname");
	DOB=rs1.getString("dob");
	Sex=rs1.getString("sex");
	Address=rs1.getString("address");
 
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
<p><h3>Welcome, <%=session.getAttribute("name")%></h3></p>
<br>
<center><h2 style="color:black">Please select your choice to proceed further</h2></center>
<%
try
{
Class.forName(driverName);
con = DriverManager.getConnection(url, user, dbpsw);
Statement stmt= con.createStatement();

ps = con.prepareStatement(sql3);
rs2 = ps.executeQuery(sql3);
if(rs2.next())
{
	
	Elec_Bill= rs2.getString("amount");
	Elec_Status= rs2.getString("status");
 
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
Class.forName(driverName);
con = DriverManager.getConnection(url, user, dbpsw);
Statement stmt= con.createStatement();
ps = con.prepareStatement(sql4);
rs3 = ps.executeQuery(sql4);
if(rs3.next())
{
	
	House_Rent= rs3.getString("amount");
	House_Status= rs3.getString("status");
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
Class.forName(driverName);
con = DriverManager.getConnection(url, user, dbpsw);
Statement stmt= con.createStatement();
ps = con.prepareStatement(sql5);
rs4 = ps.executeQuery(sql5);
if(rs4.next())
{
	
	Water_Bill= rs4.getString("amount");
	Water_Status= rs4.getString("status");
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
Class.forName(driverName);
con = DriverManager.getConnection(url, user, dbpsw);
Statement stmt= con.createStatement();
ps = con.prepareStatement(sql6);
rs5 = ps.executeQuery(sql6);
if(rs5.next())
{
	
	Hospital_Bill= rs5.getString("amount");
	Hospital_Status= rs5.getString("status");
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

<%

try
{
Class.forName(driverName);
con = DriverManager.getConnection(url, user, dbpsw);
Statement stmt= con.createStatement();
ps = con.prepareStatement(sql7);
rs6 = ps.executeQuery(sql7);
if(rs6.next())
{
	
	Gas_Bill= rs6.getString("amount");
	Gas_Status= rs6.getString("status");
}
	else
		response.sendRedirect("error.jsp");
rs6.close();
ps.close();
}
catch(SQLException sqe)
{
	out.println(sqe);
}
%>	

<table border="1" align="center">
<tr>
<td>Services Subportal</td>
</tr>
<tr>
<td><a href ="welcome.jsp"> 3<sup>rd</sup> party</a> </td>
</tr>
<tr>
<td><a href = "hosp.jsp">Hospital</a></td>
</tr>
<tr>
<td><a href = "school.jsp">School</a></td>
</tr>
</table><br>
</form>
<a href="logout.jsp">Logout</a>
</body>
</html>