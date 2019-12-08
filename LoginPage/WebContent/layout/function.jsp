<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ page import="com.td.utils.JspUtils" %>
     <%@ page import="com.td.bean.Student" %>
     <%@ page import="javax.mail.*" %>
     <%@ page import="javax.activation.*" %>
     <%@ page import="javax.mail.internet.*" %>
     <%@ page import="java.util.*" %>
     <%@ include file="./database.jsp" %>
     <%!
   
 
     //String to = "741534723@qq.com"; 收件人
     //String subject = "标题";
     //String body = "内容";
     String formartString(String value){
     	return value==null?"":value;
     }
 	
 	void sendMail(String to,String subject,String body)throws Exception{
 		 Properties props = new Properties();//key value:配置参数。真正发送邮件时再配置
         props.setProperty("mail.transport.protocol", "smtp");//指定邮件发送的协议，参数是规范规定的
         props.setProperty("mail.host", "smtp.qq.com");//指定发件服务器的地址，参数是规范规定的
//         props.setProperty("mail.debug", "true");//邮件发送的调试模式，参数是规范规定的
         props.setProperty("mail.smtp.auth", "true");//请求服务器进行身份认证。参数与具体的JavaMail实现有关
         
         Session session = Session.getInstance(props);//发送邮件时使用的环境配置
         session.setDebug(true);
         MimeMessage message = new MimeMessage(session);
         
         //设置邮件的头
         message.setFrom(new InternetAddress("1422439951@qq.com"));
         message.setRecipients(Message.RecipientType.TO, to);
         message.setSubject("来自Aki-Tomoya的验证码");
         //设置正文
         message.setContent(body, "text/html");
//         message.setText("<h1>hello</h1>");//纯文本
         
         message.saveChanges();
         
         //发送邮件
         Transport ts = session.getTransport();
         ts.connect("1422439951@qq.com", "qnfdivllbkblibfi");       // 密码为授权码不是邮箱的登录密码
         ts.sendMessage(message, message.getAllRecipients());//对象，用实例方法}
     }


 		boolean checkUcheck(HttpServletRequest request){
 			
 			HttpSession session = request.getSession();
 			String ucheck = request.getParameter("ucheck");
 			/**System.out.println(ucheck);
 			System.out.println(session.getAttribute("ucheck"));*/
 			if(ucheck == null||ucheck.isEmpty()) return false;
 			return ucheck.equalsIgnoreCase((String)session.getAttribute("ucheck"));
 		}
 		/**
 		注册账号
 		*/
 		Student registerStudent(HttpServletRequest request){
 			HttpSession session = request.getSession();
 			//数据校验
 			//1.邮箱验证码不能错误
 			if(checkUcheck(request)){
 			//注册成功后记录用户名便于跳转到登录界面后，直接显示已经注册的用户名
 				Student student = new Student();
 				//将数据导入student对象可以实现对数据的一次校验
 				student.setUname(request.getParameter("uname"));//邮箱
 				student.setUnick(request.getParameter("unick"));//昵称
 				student.setUpass(request.getParameter("upass1"));//密码
 				student.setUgender(request.getParameter("ugender"));//性别
 				student.setUcheck(request.getParameter("ucheck"));//邮箱验证码
 				
 			
 				
 				//两次输入的m密码码要一致
 				if(request.getParameter("upass2")!=null&&!request.getParameter("upass2").isEmpty()){

 					if(request.getParameter("upass2").equals(request.getParameter("upass1"))){    //student.getUpass()
 						//3.需要验证student内的-uname不能为空
 						//4.写入数据库
 						//5.用户记录到session当中
 						Student stu = addStudent(student);
 						if(stu!=null){
	 						session.setAttribute("uname",student.getUname());
	 						return student;
	 					}
 						session.setAttribute("errorMsg", "注册失败");
 				}else{
 						session.setAttribute("errorMsg", "两次输入密码不一致1");
 					}
 			}else{
 				session.setAttribute("errorMsg", "两次输入密码不一致2");
 			}
 		}else{
 			session.setAttribute("errorMsg", "验证码错误");
 		}
 			
 				return null;
 		
 	}
 		/**
 		验证验证码
 		**/
 			boolean CheckCode(HttpServletRequest request){
 				HttpSession session = request.getSession();
 				//优先获取验证码，存储在session中
 				String code = (String)session.getAttribute("valicode");
 				if(code==null||code.isEmpty())
 				return false;
 				return code.equals(request.getParameter("ucode"));
 			}
 		/**
 		生成验证码
 		*/
 			String createCode(HttpSession session){
 				String code = randomString("0123456789qwertyuipasdfghjkzxcvbnmQWERTYUPASDFGHJKLZXCVBNM",4);
 				session.setAttribute("valicode",code);
 				return code;
 		}

 			/**
 			生成随机字符串
 			@param value  随机字符串的内容从当前的value字符串中生成
 			@param length 随机字符串的长度
 		*/

 		String randomString(String value,int length){
 			if(value==null||length<1)return "";
 			// 新建一个生成随机数的对象
 			Random rand = new Random();
 			// 新建一个字符串拼接对象
 			StringBuffer buffer = new StringBuffer();
 			for(int i=0;i<length;i++){
 				// 获取原字符串长度
 				int len = value.length();
 				// 获取随机数
 				int position = rand.nextInt(len);
 				// 获取指定的字符
 				char ch = value.charAt(position);
 				// 将获取到的字符拼接到字符串拼接对象中
 				buffer.append(ch);
 			}
 			// 返回最终字符串
 			return buffer.toString();
 		}
 			
 		/**
 		验证登录
 		*/
 			Student checkLogin(HttpServletRequest request){
 			String username = request.getParameter("uname");
 			String userpass = request.getParameter("upass");
 			//数据库查询
 			Student student = findStudentByName(username);
 			if(student!=null && userpass!=null){
 				if(userpass.equals(student.getUpass())){
 					return student;
 				}		
 			}
 			return null;
 		}
		%>