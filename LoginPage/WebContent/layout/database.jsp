<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@page import="java.sql.*" %>
    <%@page import="com.td.bean.Student" %>
    <%@page import="java.util.*" %>
    <%@page import="java.sql.Date" %>
    <%@page import="static java.lang.System.out" %>
    <%!
    Connection getConnection(){
    	try{
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/tdschool";
    String username = "root";
    String password = "root";
    Connection conn = DriverManager.getConnection(url,username,password);
    if(conn != null){
    	return conn;
    	}

    	}catch(Exception e){
    		e.printStackTrace();
    	}
    return null;
    }
    
    
    //查询
  // 常用操作 增 删 改 查
	/**
		List<Map<String,Object>> data
		list 记录了参数的顺序
		Map的String(key)记录了数据的类型
		Map的Object(value)记录了数据的值
		Map<String,Object> 只有一条数据
	*/
	List<Student> query(String sql,List<Map<String,Object>> data){
		List<Student> list = new ArrayList<>();
		// 第一步获取连接对象
		Connection conn = getConnection();
		// 创建 statement
		PreparedStatement statement = null;
		// 非空判断
		if(conn==null)return list;
		try{
			statement = (PreparedStatement)conn.prepareStatement(sql);
			// 写入参数 需要知道当前写入哪个参数-需要知道当前的写入数据类型-写入的顺序
			// 非空判断
			if(data!=null){
				for(int i=0;i<data.size();i++){
					// 获取到即将需要写入的数据
					Map<String,Object> da = data.get(i);
					// 非空判断
					if(da!=null&&da.size()>0){
						// 判断写入的数据类型
						String keyType = da.keySet().iterator().next();
						// 获取写入数据
						Object value = da.get(keyType);
						switch(keyType){
							case "String":
								statement.setString(i+1, (String)value);
								break;
							case "int":
								statement.setInt(i+1, (int)value);
								break;
							default:
								statement.setDate(i+1, (java.sql.Date)value);
								break;
						}
					}
				}
			}
			// 执行查询方法
			ResultSet rs = statement.executeQuery();
			// 转换结果为list对象
			// 遍历 rs结果集
			while(rs.next()){
				// 创建结果集对象
				Student stu = new Student();
				stu.setId(rs.getInt("id"));//stu.setId(rs.getInt(1));
				stu.setUname(rs.getString("uname"));//stu.setUname(rs.getString(2));
				stu.setUnick(rs.getString("unick"));//stu.setUnick(rs.getString(3));
				stu.setUgender(rs.getString("ugender"));//stu.setUgender(rs.getString(4));
				stu.setUpass(rs.getString("upass"));//stu.setUpass(rs.getString(5));
				stu.setAddtime(rs.getDate("addtime"));//stu.setAddtime(rs.getDate(6));
				stu.setDeltime(rs.getInt("deltime"));//stu.setDeltime(rs.getInt(7));
				stu.setSign(rs.getString("sign"));//stu.setDeltime(rs.getInt(8));
				// 将结果对象写入到结果集中
				list.add(stu);
			}
		}catch(Exception ex){
			// 在jsp开发当中要避免代码细节的暴露
			ex.printStackTrace();
		}finally{
			// 关闭资源
			try{conn.close();}catch(Exception e){}
			try{statement.close();}catch(Exception e){}
		}
		// 返回结果集
		return list;
	}
	/**
		@param sql
		@param statement
		@return 记录受影响的行数，或新增后的主键 
	*/
	int excute(String sql,List<Map<String,Object>> data){
		// 第一步获取连接对象
		Connection conn = getConnection();
		// 声明statement
		PreparedStatement statement = null;
		// 定义返回结果
		int row = -1;
		// 非空判断
		if(conn==null)return row;
		try{
			statement = (PreparedStatement)conn.prepareStatement(sql);
			// 写入参数 需要知道当前写入哪个参数-需要知道当前的写入数据类型-写入的顺序
			// 非空判断
			if(data!=null){
				for(int i=0;i<data.size();i++){
					// 获取到即将需要写入的数据
					Map<String,Object> da = data.get(i);
					// 非空判断
					if(da!=null&&da.size()>0){
						// 判断写入的数据类型
						String keyType = da.keySet().iterator().next();
						// 获取写入数据
						Object value = da.get(keyType);
						switch(keyType){
							case "String":
								statement.setString(i+1, (String)value);
								break;
							case "int":
								statement.setInt(i+1, (int)value);
								break;
							default:
								statement.setDate(i+1, (java.sql.Date)value);
								break;
						}
					}
				}
			}
			// 执行修改操作  // 如果是新增的话，返回结果是1
			row = statement.executeUpdate();
		}catch(Exception ex){
			// 在jsp开发当中要避免代码细节的暴露
			ex.printStackTrace();
		}finally{
			// 关闭资源
			try{conn.close();}catch(Exception e){}
			try{statement.close();}catch(Exception e){}
		}
		// 返回结果集
		return row;
	}
	
	//定义有需求的增删改查
	Student addStudent(Student student){
		System.out.println(student);
		if(student == null || student.getUname() == null || student.getUpass() == null){
			return null;
		}
		String sql = "insert into `td_student`(`uname`,`unick`,`ugender`,`upass`) values(?,?,?,?)";
		//构造参数
		List<Map<String,Object>> data = new ArrayList<>();
		
		Map<String,Object> map = new HashMap<>();
		map.put("String", student.getUname());
		data.add(map);
		//选择map重新new
		map = new HashMap<>();
		map.put("String", student.getUnick());
		data.add(map);
		
		map = new HashMap<>();
		map.put("String", student.getUgender());
		data.add(map);
	
		map = new HashMap<>();
		map.put("String", student.getUpass());
		data.add(map);
		
		int res = excute(sql,data);
		if(res==1)return student;
		return null;
	}
	//定义插叙 登录学生-> 通过uname查血，并且 deltime为空
	Student findStudentByName(String uname){
		// 非空判断
				if(uname==null||uname.isEmpty())return null;
				// 构造sql 由于是登陆请求，只查询一条数据就可以
				String sql = "select * from td_student where uname = ? and deltime is null limit 0,1";
				// 构造请求参数
				List<Map<String,Object>> data  = new ArrayList<>();
				Map<String,Object> map = new HashMap<>();
				map.put("String", uname);
				data.add(map);
				// 调用query方法，获取查询结果
				List<Student> res = query(sql,data);
				System.out.println(res);
				// 对返回结果进行非空判断
				if(res==null||res.size()<1)return null;
				return res.get(0);
	}
	//定义学生的修改
	boolean updateStudentById(Student student){
		//非空判断
		if(student==null||student.getId()<1)return false;
		String sql = "update`td_student`set uname=?,unick=?,ugender=?,upass=?,sign=? where id=?";
		//构造修改的sql
		List<Map<String,Object>> data = new ArrayList<>();
		Map<String,Object> map = new HashMap<>();
		map.put("String",student.getUname());
		data.add(map);
		//重新选择新的map对象
	
		map = new HashMap<>();
		map.put("String", student.getUnick());
		data.add(map);
		
		map = new HashMap<>();
		map.put("String", student.getUgender());
		data.add(map);
		
		map = new HashMap<>();
		map.put("String", student.getUpass());
		data.add(map);
		
		map = new HashMap<>();
		map.put("String", student.getSign());
		data.add(map);
		
		map = new HashMap<>();
		map.put("int", student.getId());
		data.add(map);
		
		int row = excute(sql,data);
		return row == 1;
	}
%>