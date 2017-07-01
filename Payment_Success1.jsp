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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Payment Successful</title>
</head>
<body>

<%

Connection con= null;
PreparedStatement ps = null;
PreparedStatement psu1=null;
PreparedStatement psu2=null;
PreparedStatement psu3=null;
PreparedStatement psu4=null;
PreparedStatement psu5=null;
String driverName = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/TEST";
String user = "root";
String password = "ANANY";
try {
	Class.forName(driverName);
	con = DriverManager.getConnection(url, user, password);	
	psu1=con.prepareStatement("update hb_visit set status = ? where ref_id="+session.getAttribute("id"));
	psu2=con.prepareStatement("update hb_medicine set status = ? where ref_id="+session.getAttribute("id"));
	psu4=con.prepareStatement("update hb_surgery set status = ? where ref_id="+session.getAttribute("id"));
	psu5=con.prepareStatement("update hb_benefit set status = ? where ref_id="+session.getAttribute("id"));
}
catch (SQLException e) {}

%>
<%
String[] billname=(String[])session.getAttribute("BillName");
if(billname!=null){	
	out.println("You paid for: ");
for(int i=0;i<billname.length;i++){
		out.println(billname[i]);
	}
	
	for(int j=0;j<billname.length;j++)
	{
		if(billname[j].equals("Visit")){
			try{
			psu1.setString(1,"paid");
			psu1.executeUpdate();
			}
			catch (SQLException e) {}
		}
		if(billname[j].equals("Medicine")){
			try{
			psu2.setString(1,"paid");
			psu2.executeUpdate();
			}
			catch (SQLException e) {}
		}
		if(billname[j].equals("Surgery")){
			try{
				psu4.setString(1,"paid");
				psu4.executeUpdate();
			}
			catch (SQLException e) {}
		}
		if(billname[j].equals("Benefits")){
			try{
				psu5.setString(1,"paid");
				psu5.executeUpdate();
			}
			catch (SQLException e) {}
		}
	}

	psu1.close();
	psu2.close();
	psu4.close();
	psu5.close();
}	%>
	<center><h4>Your payment status has been updated</h4>
<a href="hosp.jsp">Home</a></center>
<%

%>
</body>
</html>