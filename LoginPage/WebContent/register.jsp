<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.td.utils.JspUtils" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.td.bean.Student" %>
<%@include file = "./layout/function.jsp"%>

<script>
	function checksend(){
		alert("验证邮件已发送\(//*/~/*//)/");
	}

</script>

<%
	request.setCharacterEncoding("utf-8");

	if("post".equalsIgnoreCase(request.getMethod())){
		String codeinfo = request.getParameter("codeinfo");
		String uname = request.getParameter("uname");
		switch(codeinfo){
		case"1":
			Student student = registerStudent(request);
			if(student!=null){
				response.sendRedirect("./login.jsp");
			}else{
				//注册失败
				session.setAttribute("targetUrl","./register.jsp");
				response.sendRedirect("./error.jsp");
			}
			break;
		case"2":
			//1.生成验证码
			String ucheck = createCode(session);
			//2.验证码保存在session中
			session.setAttribute("ucheck",ucheck);
			//3.发送验证码
			sendMail(uname,"发送验证码",ucheck);
			break;
		}
	}
	
	//addStudent(student);
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link rel="stylesheet" href="css/register.css?version=<%=JspUtils.fileUpdateTime(request,"css","register.css") %>"/>
</head>
<body>
<div id="container">
			<a id="wz" href="http://aki-tomoya.coding.me/">www.aki-tomoya.coding.me</a>
			<%--<img id="bg_1" src="img/bg_1.1.jpg" /> --%>
			<div id="bg_2"><img src="img/犬山哥.png"></div>
			<div class="INDEXTEXT"><a href="http://aki-tomoya.coding.me/">Aki-Tomoya</a></div>
			<div class="first">
			<form action="./register.jsp" method="post">
					<div class="input-group">
						<label class="register-font">用户昵称</label>
						<input class="uname"type="text" name="unick" value="<%=request.getParameter("unick") %>">
					</div>
					
					<div class="input-group">
						<label class="register-font">注册密码</label>
						<input class="upass" type="text" name="upass1">
					</div>
					
					<div class="input-group">
						<label class="register-font">确认密码</label>
						<input class="upass" type="text" name="upass2">
					</div>
					
					<input class="codeinfo" type="hidden" name="codeinfo" value="1">
					<div class="input-group">
						<label class="register-font">注册邮箱</label>
						<input class="mail" type="text" name="uname" value="<%=request.getParameter("uname")%>">
						<span class="btn" >点击获取验证🐴</span>
					</div>
					
					<div class="input-group">
						<label class="register-font">验证码　</label>
						<input class="mail" type="text" name="ucheck"> 
					</div>
					
					
					<div class="gender">
						<label class="genderlabel">性别</label>
						<%if("男".equals(request.getParameter("ugender"))){ %>
						<input class="gender2" type="radio"  name="ugender" value="男" checked="checked"><a id="gender2">男</a>
						<input class="gender1" type="radio" name="ugender" value="女" ><a id="gender1">女</a>
						<%}else{ %>
						<input class="gender2" type="radio"  name="ugender" value="男"><a id="gender2">男</a>
						<input class="gender1" type="radio" name="ugender" value="女" checked="checked"><a id="gender1">女</a>
						<% } %>
					</div>
				
				<div class="registert"><button class="input" type="submit">注册</button></div>
				<div class="backt"><a href="login.jsp">返回登录</a></div>
			</form>
			
			<script type="text/javascript">
				var doc_form = document.getElementsByTagName("form")[0];
				//添加监听事件
				doc_form.addEventListener("submit",function(){
					//当前事件的监听成功-修改<input type="hidden" name="codeinfo" value="1">的值
					var doc_input = doc_form.getElementsByClassName("codeinfo")[0];
					doc_input.setAttribute("value",1);
				})
				doc_form.getElementsByClassName("btn")[0].addEventListener("click",function(){
					var doc_input = doc_form.getElementsByClassName("codeinfo")[0];
					doc_input.setAttribute("value",2);
					doc_form.submit();
				})
			</script>
			
			<%-- <div  class="bilibiliimg"><img src="img/bregister1.1.jpg"></div>--%>
			</div>
		</div>
</body>
</html>