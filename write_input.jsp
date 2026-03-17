<%@page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*"%>
<%@page
	import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*, java.io.*"%>

<%
String realFolder = "";
String saveFolder = "image";
String encType = "UTF-8";

int sizeLimit = 10 * 1024 * 1024;
ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);


MultipartRequest multi = null;
multi = new MultipartRequest( request,realFolder,sizeLimit,encType,new DefaultFileRenamePolicy());

String userName = multi.getParameter("userName");
String fileName = multi.getFilesystemName("userFile");
String originFileName = multi.getOriginalFileName("userFile");

File file = multi.getFile("userFile");


String name   = multi.getParameter("name");  
String pass   = multi.getParameter("pass"); 
String email  = multi.getParameter("email");
String title  = multi.getParameter("title");
String contents  = multi.getParameter("contents");

/* 
Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");

String url = "jdbc:odbc:dbMember";
Connection conn = DriverManager.getConnection(url,"","");
 
Statement stmt = conn.createStatement();
 */	
 Class.forName("com.mysql.jdbc.Driver");

	Connection con = null; 
	Statement stmt = null;
	ResultSet rs = null;
	try 
	{
		String jdbcURL = "jdbc:mysql://localhost:3306/jsp";
		String dbID = "root";
		String dbPW = "1234";
		con = DriverManager.getConnection(jdbcURL, dbID, dbPW);
		stmt = con.createStatement();
		
Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

String strSQL = "SELECT Max(num) FROM listboarddb";
 rs = stmt.executeQuery(strSQL);
int num = 1;

if (!rs.wasNull())
{
	rs.next();
	num = rs.getInt(1) + 1;	
}
	
strSQL ="INSERT INTO listboarddb (num, name, pass, email, title, contents, writedate, readcount, filename)";
strSQL = strSQL +  "VALUES('" + num + "', '" + name + "', '" + pass + "', '" + email + "',";
strSQL = strSQL +  "'" + title + "', '" + contents + "', '" + indate + "', ' 0 ', '" + fileName + "')";
stmt.executeUpdate(strSQL);

stmt.close();                	
con.close();
	}
	catch(Exception e)
	{}
response.sendRedirect("listboard.jsp"); 
%>
