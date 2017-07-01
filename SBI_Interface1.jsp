<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*"
      import = "java.io.*"
  import = "java.util.*"
  import = "javax.sql.*"
  import = "java.sql.ResultSet"
  import = "java.sql.Statement"
  import = "java.sql.Connection"
  import = "java.sql.DriverManager"
  import = "java.sql.SQLException" %>
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
ps2=con.prepareStatement("update sbiinfo set balance = ? where ref_id="+session.getAttribute("id"));
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
<title>Payment Interface</title>
</head>
<body>
<%int total=Integer.parseInt(request.getParameter("Update"));
int SBIbalance=Integer.parseInt(balance);
String[] billname= request.getParameterValues("BillName");%>
<%for(int i=0;i<billname.length;i++){%>
	<form action="Payment_Success1.jsp" method="get">
	<input name="BillName" type="hidden" value=<%=billname[i] %>>
	<input type="submit" value="Submit">
	</form>
<%} %>
<%
session.setAttribute("BillName",billname);
if(SBIbalance>=total)
{
	ps2.setInt(1,SBIbalance-total);
	ps2.executeUpdate();
	response.sendRedirect("Payment_Success1.jsp");
}
else
	 %>

</body>
</html>