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
String url = "jdbc:mysql://localhost:3306/logindb";
String user = "root";
String dbpsw = "SAVEWATEr";
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

ps3 = con.prepareStatement(sql3);
ps4 = con.prepareStatement(sql4);
ps5 = con.prepareStatement(sql5);
ps6 = con.prepareStatement(sql6);
ps7 = con.prepareStatement(sql7);
rs2 = ps3.executeQuery(sql3);
rs3=ps4.executeQuery(sql4);
rs4=ps5.executeQuery(sql5);
rs5=ps6.executeQuery(sql6);
rs6=ps7.executeQuery(sql7);
if(rs2.next())
{
	Elec_Bill=rs2.getString("amount");
	Elec_Status=rs2.getString("status");
}
	else
		response.sendRedirect("error.jsp");
if(rs3.next())
{
	House_Rent=rs3.getString("amount");
	House_Status=rs3.getString("status");
}
	else
		response.sendRedirect("error.jsp");
if(rs4.next())
{
	Water_Bill=rs4.getString("amount");
	Water_Status=rs4.getString("status");
}
	else
		response.sendRedirect("error.jsp");
if(rs5.next())
{
	Hospital_Bill=rs5.getString("amount");
	Hospital_Status=rs5.getString("status");
}
	else
		response.sendRedirect("error.jsp");
if(rs6.next())
{
	Gas_Bill=rs6.getString("amount");
	Gas_Status=rs6.getString("status");
}
	else
		response.sendRedirect("error.jsp");
	rs2.close();
	rs3.close();
	rs4.close();
	rs5.close();
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
		if(bill[i].equals("Electricity"))
		{
			
			%><tr>
			<td><%out.println("Electricity:");%></td>
			<td><%out.println(Elec_Bill);%></td></tr>
			<%int bill=Integer.parseInt(Elec_Bill);
			sum+=bill;
			%><%
		}
		if(bill[i].equals("House"))
		{
			%><tr>
			<td><%out.println("House Rent:");%></td>
			<td><%out.println(House_Rent);%></td></tr>
			<%int bill=Integer.parseInt(House_Rent);
			sum+=bill;
			%><%
		}
		if(bill[i].equals("Water"))
		{
			%><tr>
			<td><%out.println("Water:");%></td>
			<td><%out.println(Water_Bill);%></td></tr>
			<%int bill=Integer.parseInt(Water_Bill);
			sum+=bill;
			%><%
		}
		if(bill[i].equals("Hospital"))
		{
			%><tr>
			<td><%out.println("Hospital:");%></td>
			<td><%out.println(Hospital_Bill);%></td></tr>
			<%int bill=Integer.parseInt(Hospital_Bill);
			sum+=bill;
			%><%
		}
		if(bill[i].equals("Gas"))
		{
			%><tr>
			<td><%out.println("Gas:");%></td>
			<td><%out.println(Gas_Bill);%></td></tr>
			<%int bill=Integer.parseInt(Gas_Bill);
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
<form action="SBIPage.jsp">
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