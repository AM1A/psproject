<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import = "javax.servlet.RequestDispatcher" %>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%! String[] billname;
	String balance;
	String Ref_ID;
%>
<%
Connection con= null;
PreparedStatement ps = null;
PreparedStatement ps2=null;
ResultSet rs1 = null;

String driverName = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/TEST";
String user = "root";
String dbpsw = "ANANY";
String sql="select * from sbiinfo where ref_id="+session.getAttribute("id");
try
{
Class.forName(driverName);
con = DriverManager.getConnection(url, user, dbpsw);
Statement stmt= con.createStatement();
ps = con.prepareStatement(sql);
rs1 = ps.executeQuery(sql);
if(rs1.next())
{
	Ref_ID=rs1.getString("ref_id");
	balance= rs1.getString("balance");
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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>State Bank of India</title>
</head>
<body>
<h3>You opted to pay Rs <%=request.getParameter("Total_Bill") %></h3><br>
Current balance in your account is Rs <%=balance %>.<br>
<%int bill=Integer.parseInt(request.getParameter("Total_Bill"));
billname = request.getParameterValues("BillName");
int SBIbalance=Integer.parseInt(balance);
if(SBIbalance>=bill)
{

%>
	<center><form action="SBI_Interface1.jsp">
	<%
for(int i=0;i<billname.length;i++){%>
	<input name="BillName" type="hidden" value=<%=billname[i] %>><%
}
%>
	<input name="SBIPayment" type="hidden" value="Success">
	<input name="Update" type ="hidden" value=<%=request.getParameter("Total_Bill")%>>
	<input type="submit" value="Confirm Payment"></center>	
<%}
else
	out.println("Balance in account less than bill. Cannot complete payment");
%><br>
<a href="hosp.jsp">Go Back</a>
</body>
</html>