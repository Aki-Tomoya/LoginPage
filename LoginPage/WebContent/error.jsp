<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String targetUrl = (String)session.getAttribute("targetUrl");
	response.setHeader("refresh","3;"+targetUrl);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3><%=session.getAttribute("errorMsg") %></h3>
</body>
</html>