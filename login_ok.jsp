<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*"%>

<html>
<head>
</head>
<body>
<%
    // Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pass = request.getParameter("password");
	
	try 
	{
	/* 			
		//odbc전용
		String url="jdbc:odbc:dbMember";
		Connection conn = DriverManager.getConnection(url, "","");
		Staement stmt = conn.createStatement();
		String Sql="select id,pwd from tblMember where id='"+sid+"'and"+"pwd='"+spass+"'";
		ResultSet rs=stmt.executeQuery(Sql);
	*/ 			
			
		//mysql전용
 		Class.forName("com.mysql.jdbc.Driver");
		ResultSet rs = null;
		Statement stmt = null;	//Mysql 서버에서 실행시킬 SQL구문 저장
		String jdbcURL = "jdbc:mysql://localhost:3306/jsp";
		String dbID = "root";
		String dbPW = "1234";
		Connection con = DriverManager.getConnection(jdbcURL, dbID, dbPW);
		stmt = con.createStatement();
		String strSQL = "select id,pass from joindb where id='"+id+"' and pass='"+pass+"'";
		rs = stmt.executeQuery(strSQL);
		while(rs.next()) 
		{		
			if(id.equals("") || (id.equals(null)))
			{
				out.println("<P align=\"cetner\">ID가 입력되지 않았습니다.</P>");	
			}
			else if(pass.isEmpty())  /*equals(""))*/
				{
				out.println("<P align=\"cetner\">암호가 입력되지 않았습니다.</P>");
				}
			if ((id.equals(rs.getString("id"))) && (pass.equals(rs.getString("pass"))))
			{
				out.println(id+"님 환영합니다");
			}
			else
			{
				out.println("가입되지 않은 아이디 입니다.");
			} 
		}

		rs.close();
		stmt.close();
		con.close();
	}
	catch(SQLException ex) {out.println(ex);}
	;
%>
</body>
</html>