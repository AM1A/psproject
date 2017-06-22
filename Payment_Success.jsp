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
String url = "jdbc:mysql://localhost:3306/logindb";
String user = "root";
String password = "SAVEWATEr";
try {
	Class.forName(driverName);
	con = DriverManager.getConnection(url, user, password);	
	psu1=con.prepareStatement("update electricity_bill set status = ? where ref_id="+session.getAttribute("id"));
	psu2=con.prepareStatement("update township_house_bill set status = ? where ref_id="+session.getAttribute("id"));
	psu3=con.prepareStatement("update hospital_bill set status = ? where ref_id="+session.getAttribute("id"));
	psu4=con.prepareStatement("update water_bill set status = ? where ref_id="+session.getAttribute("id"));
	psu5=con.prepareStatement("update gas_bill set status = ? where ref_id="+session.getAttribute("id"));
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
		if(billname[j].equals("Electricity")){
			try{
			psu1.setString(1,"paid");
			psu1.executeUpdate();
			}
			catch (SQLException e) {}
		}
		if(billname[j].equals("House")){
			try{
			psu2.setString(1,"paid");
			psu2.executeUpdate();
			}
			catch (SQLException e) {}
		}
		if(billname[j].equals("Hospital")){
			try{
			psu3.setString(1,"paid");
			psu3.executeUpdate();
			}
			catch (SQLException e) {}
		}
		if(billname[j].equals("Water")){
			try{
				psu4.setString(1,"paid");
				psu4.executeUpdate();
			}
			catch (SQLException e) {}
		}
		if(billname[j].equals("Gas")){
			try{
				psu5.setString(1,"paid");
				psu5.executeUpdate();
			}
			catch (SQLException e) {}
		}
	}

	psu1.close();
	psu2.close();
	psu3.close();
	psu4.close();
	psu5.close();
}	%>
	<center><h4>Your payment status has been updated</h4>
<a href="welcome.jsp">Home</a></center>
<%

%>
</body>
</html>