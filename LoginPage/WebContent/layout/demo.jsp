<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.td.utils.JspUtils" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@include file = "./function.jsp"%>
<%@ page import="com.td.bean.Student" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%


String unick = request.getParameter("unick");
String uname = request.getParameter("uname");
String upass1 = request.getParameter("upass1");
Student student = new Student();
student.setUnick(unick);
student.setUname(uname);
student.setUpass(upass1);
out.print(student);
addStudent(student);


%>
</body>
</html>