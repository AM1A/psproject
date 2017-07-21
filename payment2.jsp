<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import = "javax.servlet.RequestDispatcher" %>
    <%@ page import="java.sql.*"
		import = "java.io.*"
		import = "java.util.*"
		import = "javax.sql.*"
		import = "java.sql.ResultSet"
		import = "java.sql.Statement"
		import = "java.sql.Connection"
		import = "java.sql.DriverManager"
		import = "java.sql.SQLException" 
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%! String[] bill;
%>
<%! 
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
PreparedStatement ps3 = null;
PreparedStatement ps4 = null;
PreparedStatement ps5 = null;
PreparedStatement ps6 = null;
PreparedStatement ps7 = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
ResultSet rs4 = null;
ResultSet rs5 = null;
ResultSet rs6 = null;

String driverName = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/project";
String user = "root";
String dbpsw = "robert8472";

String sql3="select * from tuit_fee where ref_id="+session.getAttribute("id");
String sql4="select * from hostel_fee where ref_id="+session.getAttribute("id");
String sql5="select * from trans_fee where ref_id="+session.getAttribute("id");
String sql6="select * from sship where ref_id="+session.getAttribute("id");

try
{
	java.lang.Class.forName(driverName + "");
	con = DriverManager.getConnection(url, user, dbpsw);
	Statement stmt = con.createStatement();
	
	ps3 = con.prepareStatement(sql3);
	ps4 = con.prepareStatement(sql4);
	ps5 = con.prepareStatement(sql5);
	ps6 = con.prepareStatement(sql6);
	rs2 = ps3.executeQuery(sql3);
	rs3 = ps4.executeQuery(sql4);
	rs4 = ps5.executeQuery(sql5);
	rs5 = ps6.executeQuery(sql6);
	
	if(rs2.next())
	{
		Tuit_fee=rs2.getString("amount");
		Tuit_fee_status=rs2.getString("status");
	}
	else
		response.sendRedirect("error.jsp");
	
	if(rs3.next())
	{
		Hostel_fee=rs3.getString("amount");
		Hostel_fee_status=rs3.getString("status");
	}
	else
		response.sendRedirect("error.jsp");
	
	if(rs4.next())
	{
		Trans_fee=rs4.getString("amount");
		Trans_fee_status=rs4.getString("status");
	}
	else
		response.sendRedirect("error.jsp");
	
	if(rs5.next())
	{
		Scholarship=rs5.getString("amount");
		Scholarship_awarded=rs5.getString("awarded");
	}
	else
		response.sendRedirect("error.jsp");
	
	rs2.close();
	rs3.close();
	rs4.close();
	rs5.close();
	ps3.close();
	ps4.close();
	ps5.close();
	ps6.close();
}
catch(SQLException sqe)
{
	out.println(sqe);
}
%>
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
<title>School Payment</title>
<style>
p {
	font-size: 150%;
}
table,th,td {
	border-style: solid;
	border-width: 15px;
	border: 1px solid black;
	border-collapse: collapse;
}
th,td {
	padding: 15px;
}
</style>
</head>
<body>
	<h3>Welcome to the Payment Portal</h3>
	<br>
	<% 
		String[] bill = request.getParameterValues("Payment");
		if(bill.length > 1)
		{
	%>
	<center><p style="color: indigo; font-size: 20px; font-family:tahoma;"> Details of payment can be found below: </p></center>
	<% } %>
	<table align="center">
	<%
	int sum = 0;
	if(bill!=null)
	{
		if(bill.length==1)
		{
		%>
			<center><p style="color: indigo; font-size: 20px; font-family:tahoma;"> You have nothing to pay!</p></center>
		<%
		}
		else if(bill.length > 1)
		{
			for(int i=0;i<bill.length;i++)
			{
				if(bill[i].equals("Tuition"))
				{
					%>
					<tr>
					<td><%out.println("Tuition Fee"); %></td>
					<td><%out.println(Tuit_fee); %></td>
					</tr>
					<%  int num=Integer.parseInt(Tuit_fee);
						sum+=num;
					%> <%
				}
				
				if(bill[i].equals("Hostel"))
				{
					%>
					<tr>
					<td><%out.println("Hostel Fee"); %></td>
					<td><%out.println(Hostel_fee); %></td>
					</tr>
					<%  int num=Integer.parseInt(Hostel_fee);
						sum+=num;
					%> <%
				}
				
				if(bill[i].equals("Transport"))
				{
					%>
					<tr>
					<td><%out.println("Transport Fee"); %></td>
					<td><%out.println(Trans_fee); %></td>
					</tr>
					<%  int num=Integer.parseInt(Trans_fee);
						sum+=num;
					%> <%
				}
				
				if(bill[i].equals("Scholarship"))
				{
					%>
					<tr>
					<td><%out.println("Scholarship"); %></td>
					<td><%out.println(Scholarship); %></td>
					</tr>
					<%	int num=Integer.parseInt(Scholarship);
						sum-=num;
				}	
			}
		}
	}
	
	else {
		%>
		<br>
		<p style="color: indigo;"><center><b><i> No selection </i></b></center></p>
	<% } %>
	<tr>
	<td><b> Total bill </b></td>
	<td><%=sum %></td>
	</tr>
	</table><br>
	<form action="SBIPage2.jsp">
	<%
	if(bill!=null)
	{
		for(int i=0;i<bill.length;i++)
		{
			%>
			<input name="BillName" type="hidden" value=<%=bill[i]%>><%
		}
	}
	%>
	<input name="Total_Bill" type="hidden" value=<%=sum %>>
	<%
	if(sum>0)
	{ 
		%>
		<center><input type="submit" value="Pay"></center><br>
	<% } %>
	<a href="logout.jsp"> Logout </a>
</body>
</html>