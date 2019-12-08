package com.td.bean;

import java.sql.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.sun.org.apache.xerces.internal.impl.xpath.regex.Match;

public class Student {
	private String uname;//邮箱
	private String unick;//昵称
	private String ugender;
	private String upass;
	private String ucode;
	private String ucheck;//邮箱验证码
	private Date addtime;
	private int deltime;
	private int id;
	private String sign;
	
	
	public Student() {

	}
	
	public Student(String uname, String unick, String ugender, String upass, String ucode, String ucheck, Date addtime,
			int deltime, int id) {
		super();
		this.uname = uname;
		this.unick = unick;
		this.ugender = ugender;
		this.upass = upass;
		this.ucode = ucode;
		this.ucheck = ucheck;
		this.addtime = addtime;
		this.deltime = deltime;
		this.id = id;
	}
	
	
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		//正则匹配 验证邮箱有效性
		if(uname!=null){
			uname = uname.trim(); //消除前后空格
			String check = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+\\.)+[a-z0-9A-Z]{2,}$";
			//写入正则规则
			Pattern regex = Pattern.compile(check);
			//加入数据进行检测
			Matcher matcher = regex.matcher(uname);
			if(matcher.matches()){
				//正常
				uname = uname;
			}else{
				uname = null;
			}
		}
		this.uname = uname;
	}
	public String getUnick() {
		return unick;
	}
	public void setUnick(String unick) {
		//验证
		if(unick!=null){
			unick = unick.trim();
			
		}
		
		this.unick = unick;
	}
	public String getUgender() {
		return ugender;
	}
	public void setUgender(String ugender) {
		//验证
		this.ugender = ugender;
	}
	public String getUpass() {
		return upass;
	}
	public void setUpass(String upass) {
		//验证
	        if (upass!=null){
	            upass=upass.trim();//消除前后空格
	            //定义检验的正则表达式
	            String check="^[A-Za-z0-9|\\.]{6,}$";
	            //写入正则规则
	            Pattern regex=Pattern.compile(check);
	            //加入数据进行检测
	            Matcher matcher=regex.matcher(upass);
	            //获取检验结果
	            if (matcher.matches()){
	            }else {
	                upass=null;
	            }

	        }
		this.upass = upass;
	}
	public String getUcode() {
		return ucode;
	}
	public void setUcode(String ucode) {
		//验证
		 if (ucode!=null){
	            ucode=ucode.trim();//消除前后空格
	            //定义检验的正则表达式
	            String check="^[0-9]{4}$";
	            //写入正则规则
	            Pattern regex=Pattern.compile(check);
	            //加入数据进行检测
	            Matcher matcher=regex.matcher(ucode);
	            //获取检验结果
	            if (matcher.matches()){
	                ucode=ucode;
	            }else {
	                ucode=null;
	            }

	        }

		this.ucode = ucode;
	}
	public String getUcheck() {
		return ucheck;
	}
	public void setUcheck(String ucheck) {
		//验证
		this.ucheck = ucheck;
	}
	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	public int getDeltime() {
		return deltime;
	}
	public void setDeltime(int deltime) {
		this.deltime = deltime;
	}
	@Override
	public String toString() {
		return "Student [uname=" + uname + ", unick=" + unick + ", ugender=" + ugender + ", upass=" + upass + ", ucode="
				+ ucode + ", ucheck=" + ucheck + ", addtime=" + addtime + ", deltime=" + deltime + ", id=" + id
				+ ", sign=" + sign + "]";
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}
	
}
