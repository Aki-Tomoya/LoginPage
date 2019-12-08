<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.td.utils.JspUtils" %>
<%@ page import="com.td.bean.Student" %>
<%@ page import="java.util.*" %>
<%@include file = "./layout/function.jsp"%>

<%
if("post".equalsIgnoreCase(request.getMethod())){
	// post请求才是登录请求
	if(CheckCode(request)){
		// 进一步验证登录
		Student student =checkLogin(request);
		if(student==null){
			// 返回错误信息
			session.setAttribute("errorMsg", "用户名或密码错误请重新尝试");
			session.setAttribute("targetUrl", "./login.jsp");
			response.sendRedirect("./error.jsp");
		}else{
			// 记录登录信息，并跳转首页
			session.setAttribute("loginState", "success");
			session.setAttribute("loginUser", student);
			// 跳转首页
			response.sendRedirect("./index.jsp");
		}
	}else{
		// 直接返回错误信息
		session.setAttribute("errorMsg", "验证码错误");
		session.setAttribute("targetUrl", "./login.jsp");
		response.sendRedirect("./error.jsp");
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="css/login.css?version=<%=JspUtils.fileUpdateTime(request,"css","login.css") %>"/>
	
</head>
<body>
<div id="container">
			<a id="wz" href="http://aki-tomoya.coding.me/">www.aki-tomoya.coding.me</a>
			<%--<img id="bg_1" src="img/bg_1.1.jpg" />--%>
			<div id="bg_2"><img src="img/犬山哥.png"></div>
			<div class="INDEXTEXT"><a href="http://aki-tomoya.coding.me/">Aki-Tomoya</a></div>
			<div class="first">
				<form action="./login.jsp" method="post">
					<div class="group">
						<label id="account">用户账号</label>
						<input class="uname"type="text" name="uname">
					</div>
					<div class="group">
						<label id="password">账号密码</label>
						<input class="upass" type="password" name="upass">
					</div>
					<div class="group">
						<label id="valicode">验证码　</label>
						<input class="valicode" type="valiCode" name="ucode">
						<span class="valiCode"><%=createCode(session) %></span>
					</div>
						<button class="input-group" type="submit">登录</button>
					
						<div class="attxt"><a href="register.jsp">注册账号</a></div>
						<div class="pdtxt"><a href="forget.jsp">忘记密码</a></div>
					
					
				</form>
			</div>
			
		</div>

</body>
</html>