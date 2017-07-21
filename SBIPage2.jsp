<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<%@ page import = "javax.servlet.RequestDispatcher" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%! 
	String[] billname;
	String balance;
	String Ref_ID;
%>
<%
Connection con = null;
PreparedStatement ps1 = null;
PreparedStatement ps2 = null;
ResultSet rs1 = null;

String driverName = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/project";
String user = "root";
String dbpsw = "robert8472";
String sql="select * from sbiinfo where ref_id="+session.getAttribute("id");

try
{
	java.lang.Class.forName(driverName + "");
	con = DriverManager.getConnection(url, user, dbpsw);
	Statement stmt= con.createStatement();
	ps1 = con.prepareStatement(sql);
	rs1 = ps1.executeQuery(sql);
	
	if(rs1.next())
	{
		Ref_ID=rs1.getString("ref_id");
		balance= rs1.getString("balance");
	}
	
	else
		response.sendRedirect("error.jsp");
	rs1.close();
	ps1.close();
}

catch(SQLException sqe)
{
	out.println(sqe);
}	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> SBI Home </title>
</head>
<body>
	<center><h4 style="color: indigo; ">You opted to pay &#8377 <%=request.getParameter("Total_Bill") %></h4><br>
			<p style="color: indigo; ">Current balance in your account is &#8377 <%=balance %></p>
	</center>
	<%
	int bill = Integer.parseInt(request.getParameter("Total_Bill"));
	billname = request.getParameterValues("BillName");
	int SBIbalance = Integer.parseInt(balance);
	if(SBIbalance >= bill)
	{
	%>
	<center><form action="SBI_Interface2.jsp">
	<%
	for(int i=0;i<billname.length;i++)
	{
		%>
		<input name="BillName" type="hidden" value=<%=billname[i] %>><%
	}
		%>
	<input name="SBIPayment" type="hidden" value="Success">
	<input name="Update" type ="hidden" value=<%=request.getParameter("Total_Bill")%>>
	<input type="submit" value="Confirm payment"></form></center>
	<%}
	
	else
	{ %>
		<center><h3 style="color: indigo;"> Your bank account doesn't have sufficient balance.
		Hence, payment couldn't be completed.</h3></center>
	<% } %>
	<br>
	<center><a href="school.jsp"> Back </a></center>
</body>
</html>