<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page
	import="java.sql.*"
    import = "java.io.*"
  	import = "java.util.*"
  	import = "javax.sql.*"
  	import = "java.sql.ResultSet"
  	import = "java.sql.Statement"
  	import = "java.sql.Connection"
  	import = "java.sql.DriverManager"
  	import = "java.sql.SQLException" 
%>
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
	String driverName = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/project";
	String user = "root";
	String password = "robert8472";
	
	try
	{
		java.lang.Class.forName(driverName + "");
		con = DriverManager.getConnection(url, user, password);	
		psu1=con.prepareStatement("update tuit_fee set status = ? where ref_id="+session.getAttribute("id"));
		psu2=con.prepareStatement("update hostel_fee set status = ? where ref_id="+session.getAttribute("id"));
		psu3=con.prepareStatement("update trans_fee set status = ? where ref_id="+session.getAttribute("id"));
		psu4=con.prepareStatement("update sship set status = ? where ref_id="+session.getAttribute("id"));
	}
	catch (SQLException e) 
	{
		out.println(e);
	}
%>

<%
	String[] billname=(String[])session.getAttribute("BillName");
	if(billname!=null){ %>
		<p style="font-family: verdana; color: crimson;"> Congratulations, your payment is complete.
			You have paid for </p>
<%	
	for(int i=0;i<billname.length-1;i++)
	{
	%>  <ul>
			<li><p style="font-family: trebuchet; font-size:20px; color: indigo;"> <%=billname[i]%> </p></li>
		</ul>
	<% 
	}
	for(int j=0;j<billname.length-1;j++)
	{
		if(billname[j].equals("Tuition"))
		{
			try
			{
				psu1.setString(1,"paid");
				psu1.executeUpdate();
			}
			catch (SQLException e) 
			{
				out.println(e);
			}
		}
		
		if(billname[j].equals("Hostel"))
		{
			try
			{
				psu2.setString(1,"paid");
				psu2.executeUpdate();
			}
			catch (SQLException e) 
			{
				out.println(e);	
			}
		}
		
		if(billname[j].equals("Transport"))
		{
			try
			{
				psu3.setString(1,"paid");
				psu3.executeUpdate();
			}
			catch (SQLException e)
			{
				out.println(e);
			}
		}
		
		if(billname[j].equals("Scholarship"))
		{
			try{
				psu4.setString(1,"yes");
				psu4.executeUpdate();
			}
			catch (SQLException e) 
			{
				out.println(e);
			}
		}
	}
	psu1.close();
	psu2.close();
	psu3.close();
	psu4.close();
}
%>

<center>
	<p style="font-family: tahoma; color: saddlebrown;">Thanks for using SBI Payment Portal
	<br> Hope you were satisfied with our service 
	<br> Click <a href="school.jsp">here</a> to see your changes 
	<br> Click <a href="logout.jsp">here</a> to log out
	</p>
</center>
</body>
</html>