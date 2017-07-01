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
  import = "java.sql.SQLException" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%! String[] bill;
%>
<%! String Name;
String FatherName;
String DOB;
String Sex;
String Ref_ID;
String Address;
String hb_visit;
String hb_med;
String hb_surg;
String hb_ben;
String hb_visit_Status;
String hb_med_status;
String hb_surg_Status;
String hb_ben_Status;
%>
<%
Connection con= null;

PreparedStatement ps3 = null;
PreparedStatement ps4 = null;
PreparedStatement ps5 = null;
PreparedStatement ps6 = null;
PreparedStatement ps7 = null;
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
String sql3="select * from hb_visit where ref_id="+session.getAttribute("id");
String sql4="select * from hb_medicine where ref_id="+session.getAttribute("id");
String sql5= "select * from hb_surgery where ref_id="+session.getAttribute("id");
String sql7= "select * from hb_benefit where ref_id="+session.getAttribute("id");
try
{
Class.forName(driverName);
con = DriverManager.getConnection(url, user, dbpsw);
Statement stmt= con.createStatement();

ps3 = con.prepareStatement(sql2);
ps4 = con.prepareStatement(sql3);
ps5 = con.prepareStatement(sql4);
ps6 = con.prepareStatement(sql5);
ps7 = con.prepareStatement(sql7);

rs2=ps4.executeQuery(sql3);
rs3=ps5.executeQuery(sql4);
rs4=ps6.executeQuery(sql5);
rs6=ps7.executeQuery(sql7);
if(rs2.next())
{
	hb_visit=rs2.getString("amount");
	hb_visit_Status=rs2.getString("status");
}
	else
		response.sendRedirect("error.jsp");
if(rs3.next())
{
	hb_med=rs3.getString("amount");
	hb_med_status=rs3.getString("status");
}
	else
		response.sendRedirect("error.jsp");
if(rs4.next())
{
	hb_surg=rs4.getString("amount");
	hb_surg_Status=rs4.getString("status");
}
	else
		response.sendRedirect("error.jsp");

if(rs6.next())
{
	hb_ben=rs6.getString("amount");
	hb_ben_Status=rs6.getString("status");
}
	else
		response.sendRedirect("error.jsp");
	rs2.close();
	rs3.close();
	rs4.close();
	rs6.close();
	ps3.close();
	ps4.close();
	ps5.close();
	ps6.close();
	ps7.close();
}
catch(SQLException sqe)
{
	out.println(sqe);
}	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Payment Portal</title>
</head>
<body>
<h2>You are in Payment Portal</h2>
<center>
You have selected to Pay for:<br><br><b>
<table border="1" width="20%" align="center">
<%
int sum=0;
bill= request.getParameterValues("Payment");
if(bill!=null)
{
	for(int i=0;i<bill.length;i++)
	{
		if(bill[i].equals("Visit"))
		{
			
			%><tr>
			<td><%out.println("Visit Fees:");%></td>
			<td><%out.println(hb_visit);%></td></tr>
			<%int bill=Integer.parseInt(hb_visit);
			sum+=bill;
			%><%
		}
		if(bill[i].equals("Medicine"))
		{
			%><tr>
			<td><%out.println("Medicine Fees:");%></td>
			<td><%out.println(hb_med);%></td></tr>
			<%int bill=Integer.parseInt(hb_med);
			sum+=bill;
			%><%
		}
		if(bill[i].equals("Surgery"))
		{
			%><tr>
			<td><%out.println("Surgery Costs:");%></td>
			<td><%out.println(hb_surg);%></td></tr>
			<%int bill=Integer.parseInt(hb_surg);
			sum+=bill;
			%><%
		}
		if(bill[i].equals("Benefits"))
		{
			%><tr>
			<td><%out.println("Insurance:");%></td>
			<td><%out.println(hb_ben);%></td></tr>
			<%int bill=Integer.parseInt(hb_ben);
			sum+=bill;
		}
	}
}
	else
		out.println("none");
%>
<tr>
<td>Total bill:</td>
<td><%=sum %></td></tr>
</table></b><br>
<form action="SBIPage1.jsp">
<%
if(bill!=null){
for(int i=0;i<bill.length;i++){%>
	<input name="BillName" type="hidden" value=<%=bill[i] %>><%
}
}
%>
<input name="Total_Bill" type="hidden" value=<%=sum %>>
<%if(sum>0){ %>
<input type="submit" value="Pay">
<%} %>
</center>



<a href="logout.jsp">Logout</a>
</body>
</html>