<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>


<%
String id = request.getParameter("id");
String pass = request.getParameter("password");
String name = request.getParameter("name");
String ssn = request.getParameter("jumin");
String job = request.getParameter("job");
String sex = request.getParameter("btn");
String info = request.getParameter("intro");

Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");

String url = "jdbc:odbc:dbMember";
Connection conn = DriverManager.getConnection(url,"","");

PreparedStatement pstmt = null;




String strSQL = "Insert Into joindb(id, pass, name, ssn, job, sex, info)"; 
strSQL = strSQL +  "Values ('"+id+"','"+pass+"','"+name+"','"+ssn+"','"+job+"','"+sex+"','"+info+"')";	
pstmt = conn.prepareStatement(strSQL);

pstmt.executeUpdate();

pstmt.close();
conn.close();

response.sendRedirect("home.jsp");
%>