<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><div id="container">
<%@ page import="com.td.utils.JspUtils" %>
<%@ include file="./function.jsp" %>
			<a id="wz" href="http://aki-tomoya.coding.me/" >www.aki-tomoya.coding.me</a>
			<%--<img id="bg_1" src="img/bg_1.1.jpg" /> --%>
			<div id="bg_2"><img src="img/犬山哥.png"></div>
			<div class="INDEXTEXT"><a href="http://aki-tomoya.coding.me/">Aki-Tomoya</a></div>
			<div class="first">
			<form action="./forget.jsp" method="post">
					<div class="pwdr">
						<a id="pwdr">密🐴重置</a>
					</div>
					<div class="mmail">
						<label id="mail">用户账户</label>
						<input class="mail" type="text" name="uname" placeholder="请输入注册的邮箱">
					</div>
					
					<div class="vvalicode">
						<label id="valicode">验证码　</label>
						<input class="valicode" type="valiCode" name="ucode">
						<span class="valiCode"><%=createCode(session) %></span>
					</div>
					<div class="attxt"><a id="attxt" href="register.jsp">注册账号</a></div>
			<div class="backt"><a id="backt" href="login.jsp">返回</a></div>
			<div id="find">
			<button class="find" type="submit">
			点击找回
			</button>
			
			</form>	
			
			</div>
			
		</div>