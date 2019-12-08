package com.td.utils;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 获取最新修改时间
 * @author 扁呱RICHARD
 *
 */
public class JspUtils {

	public static long fileUpdateTime(HttpServletRequest request,String type,String name){
		String rootPath = request.getRealPath(".");
		type = File.separator + "static" +File.pathSeparator+type+File.separator;
		File file = new File(rootPath + File.separator + type +name);
		HttpSession session = request.getSession();
		return file.lastModified();
	}
}
