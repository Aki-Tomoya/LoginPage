<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!
	boolean checkLogin(HttpSession session){
		return "success".equals(session.getAttribute("loginState"));
}
%>

<%
	if(!checkLogin(session)){
		response.sendRedirect("login.jsp");
	}
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<style type="text/css">
	body{
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background:url(./img/bg_1.2.jpg);
	background-size:cover;
	font-family: consolas;
	position:relative;
}

a{
	position: relative;
	display: inline-block;
	padding: 15px 30px;
	color: #2196f3；
	text-transform:uppercase;
	letter-spacing: 4px;
	text-decoration: none;
	font-size: 24px;
	overflow: hidden;
	transition: 2s;

}

a:hover{
	color: #255784;
	background:#2196f3;
	box-shadow: 0 0 10px #2196f3,0 0 40px #2196f3,0 0 80px #2196f3;
	transition-delay:1s;
}

a span{
	position: absolute;
	display: block;
}

a span:nth-child(1){
	top: 0;
	left: -100%;
	width: 100%;
	height: 2px;
	background:linear-gradient(90deg,transparent,#2196f3);
}

a:hover span:nth-child(1){
	left: 100%;
	transition: 1s;
}

a span:nth-child(3){
	bottom: 0;
	right: -100%;
	width: 100%;
	height: 2px;
	background:linear-gradient(270deg,transparent,#2196f3);
}

a:hover span:nth-child(3){
	right: 100%;
	transition: 1s;
	transition-delay: 0.5s;
}

a span:nth-child(2){
	right: 0;
	top: -100%;
	width: 2px;
	height: 100%;
	background:linear-gradient(180deg,transparent,#2196f3);
}

a:hover span:nth-child(2){
	top: 100%;
	transition: 1s;
	transition-delay: 0.25s;
}

a span:nth-child(4){
	left: 0;
	bottom: -100%;
	width: 2px;
	height: 100%;
	background:linear-gradient(360deg,transparent,#2196f3);
}

a:hover span:nth-child(4){
	bottom: 100%;
	transition: 1s;
	transition-delay: 0.75s; 
}

.first{
	position:absolute;
	background-color:#fff;
	opacity: 0.7;
	width: 1320px;
	height:600px;
	box-shadow:1px 1px 20px #fff;
}
</style>
</head>
<body>
<div class="first"></div>
<a href="#">
	<span></span>
	<span></span>
	<span></span>
	<span></span>
	成功登录
</a>
</body>
</html>