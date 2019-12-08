<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.td.utils.JspUtils" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forget</title>
<link rel="stylesheet" href="css/forget.css?version=<%=JspUtils.fileUpdateTime(request,"css","forget.css") %>"/>

<script>
	function checksend(){
		alert("验证🐴已发送\(//*/~/*//)/");
	}

</script>

</head>
<body>
<% 
int type = session.getAttribute("repass_type")==null?1:(int)session.getAttribute("repass_type");
// 进行请求判断
if("post".equalsIgnoreCase(request.getMethod())){
	if(type==1){// 表示当前是一个表单的提交行为
		// 当前是点击找回密码->1:通过邮箱和验证码申请邮箱修改密码的链接
		// 获取请求参数
		String uname = request.getParameter("uname");
		String ucode = request.getParameter("ucode");
		// 2:验证验证码的存在
		if(CheckCode(request)){
			// 3： 验证码通过->验证当前的邮箱是否存在
			// 数据库查询
			Student student = findStudentByName(uname);
			if(student!=null){
				// TODO 表示当前学生存在->给当前邮箱发送密码找回链接
				String host = "http://localhost:8889/LoginPage/forget.jsp";
				// 学生的id
				// 用于验证的密码
				String sign = randomString("0123456789qwertyuipasdfghjklzxcvbnmQWERTYUPASDFGHJKLZXCVBNM",32);
				// 将验证密码存入到数据库当中
				student.setSign(sign);
				if(updateStudentById(student)){
					// 构造链接
					host+="?id="+student.getId()+"&sign="+sign;
					// 将链接发送给用户
					
					 sendMail(uname,"重置密码",host);
					// 发送完链接转到repass2
					type = 2;
					session.setAttribute("repass_type",type);
				}else{
					// 写入数据库失败
					session.setAttribute("errorMsg", "重置密码失败-用户账户存在异常");
					// 记录返回链接
					session.setAttribute("targetUrl", "./forget.jsp");
					response.sendRedirect("./error.jsp");
				}
			}else{
				session.setAttribute("errorMsg", "用户账号不存在");
				// 记录返回链接
				session.setAttribute("targetUrl", "./forget.jsp");
				response.sendRedirect("./error.jsp");
			}
		}else{
			session.setAttribute("errorMsg", "验证码错误");
			// 记录返回链接
			session.setAttribute("targetUrl", "./forget.jsp");
			response.sendRedirect("./error.jsp");
		}
	}
}else{
	// 判断当前请求是否是重置表单的链接构造
	String _id = request.getParameter("id");
	String _sign = request.getParameter("sign");
	if(_id!=null && _sign!=null && !_id.isEmpty() && !_sign.isEmpty() ){
		// 查询学生对象
		Student student = findStudentByName("uname");
		if(student == null){
			// 写入数据库失败
			session.setAttribute("errorMsg", "非法链接请求");
			// 记录返回链接
			session.setAttribute("targetUrl", "./forget.jsp");
			response.sendRedirect("./error.jsp");
		}else{
			// 直接进入链接修改 
			type = 3;
			session.setAttribute("repass_type",type);
			// 记录student对象
			session.setAttribute("loginUser",student);
		}
	}
}
		
if(type==1){ %>
	<%@include file="layout/repass1.jsp" %>
<%} else if(type==2){ %>
	<%@include file="layout/repass2.jsp" %>
<%} else if(type==3){ %>
	<%@include file="layout/repass3.jsp" %>
<%} %>
</body>
</html>