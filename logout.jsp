<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logout page</title>
</head>
<body>
<% session.invalidate(); %>
<center><p style="font-family: verdana; color: crimson;">You have been successfully logged out</p></center>
<center><a href="home.jsp">Login again</a></center>
</body>
</html>