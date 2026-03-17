<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<HTML>
<HEAD>
<TITLE> 자유 게시판 </TITLE>

<SCRIPT type="text/JavaScript">
<!--
function Check()
{
if (Form.keyword.value.length < 1) {
	alert("검색어를 입력하세요.");
	Form.keyword.focus(); 
         return false;
	}
}
-->
</SCRIPT>

<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type='text/css'>
<!--
	a:link		{font-family:"";color:black;text-decoration:none;}
	a:visited	{font-family:"";color:black;text-decoration:none;}
	a:hover		{font-family:"";color:black;text-decoration:underline;}
-->
</style>

</HEAD>
<BODY>

<%
String key = request.getParameter("key");
String keyword = request.getParameter("keyword");

String pageNum = request.getParameter("pageNum");
if(pageNum == null){
	pageNum = "1";	
}

int listSize = 9;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * listSize + 1;
int endRow = startRow + listSize - 1;
int lastRow = 0;
int i = 0;
String strSQL = "";

/* odbc 전용
Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
tring url = "jdbc:odbc:dbMember";
Connection conn = DriverManager.getConnection(url,"","");
 */
 
//MySQL전용
Class.forName("com.mysql.jdbc.Driver");
String jdbcURL = "jdbc:mysql://localhost:3306/jsp";
String dbID = "root";
String dbPW = "1234";
Connection con = DriverManager.getConnection(jdbcURL, dbID, dbPW);

Statement stmt = con.createStatement();
ResultSet rs = null;

if (key==null || keyword==null){
	strSQL = "SELECT count(*) FROM listboarddb";
}else{
	strSQL = "SELECT count(*) FROM listboarddb WHERE " + key + " like '%" + keyword + "%'";
}
rs = stmt.executeQuery(strSQL);
rs.next();
lastRow = rs.getInt(1);

rs.close();
%>

<center><font size='3'><b> 자유 게시판 </b></font></TD>
                                    
<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>    

<TABLE border='0' cellspacing=1 cellpadding=2 width='600'>             
	
<%
if(lastRow > 0) {
	if(key==null || keyword==null){
		strSQL = "SELECT * FROM listboarddb WHERE num BETWEEN " + startRow + " and " + endRow;
		rs = stmt.executeQuery(strSQL);
	} else {
		strSQL = "SELECT * FROM listboarddb WHERE " + key + " like '%" + keyword + "%'";
		rs = stmt.executeQuery(strSQL);
	}

	for (i = 0; i < listSize; i++){	
		int j = 0;
%>
		<TR>
<%
		for(j = 0; j < 3; j++){		
			if(rs.next()){

			int listnum = rs.getInt("num");
			String title = rs.getString("title");
			String writedate = rs.getString("writedate");
			String filename = rs.getString("filename");
%>
			<TD>
	
			<TABLE border='2' bgcolor='ededed'>
			<TR>
				<TD align=center width='170'>    
				<font size=2 color="black">
                                    <%=title %></a></font> 
				</TD>  
			</TR>
			<TR> 
				<TD align=center>
					<a href="write_output.jsp?num=<%=listnum %>">
					<img src=<%="/image/" + filename %> width="160" height="160">
				</TD>  
			</TR>
			<TR>
				<TD align=center>
                                    	<font size=2><%=writedate %>
                                    	</font>
				</TD> 
			</TR>
			</TABLE> 
	
		</TD>   
<% 
			}else{
			break;	
		}
		}
		i = i + j;  
%>
		</TR>
<%  
	}	
%>

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE> 
                  	                   
<%
rs.close();
stmt.close();
con.close();
}

if(lastRow > 0) {
	int setPage = 1;
	int lastPage = 0;
	if(lastRow % listSize == 0)
		lastPage = lastRow / listSize;
	else
		lastPage = lastRow / listSize + 1;

	if(currentPage > 1) {
%>
		<a href="listboard.jsp?pageNum=<%=currentPage-1%>">[이전]</a>	
<%	
	}
	for(i=setPage; i<=lastPage; i++) {
		if (i == Integer.parseInt(pageNum)){
%>
		[<%=i%>]
<%		
		}else{
%>
		<a href="listboard.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%
		}
	}
	if(lastPage > currentPage) {
%>
		<a href="listboard.jsp?pageNum=<%=currentPage+1%>">[다음]</a>
<%
	}
}
%>  

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<TR>
		<TD><hr size='1' noshade>
		</TD>
 	</TR>
</TABLE>                    

<TABLE border=0 width=600>
	<TR>
		<TD align='center'>	
			<TABLE border='0' cellpadding='0' cellspacing='0'>
			<FORM Name='Form' Method='POST' Action='listboard.jsp' OnSubmit='return Check()'>
			<input type='hidden' name='search' value='1'>
			<TR>
				<TD align='right'>
				<select name='key' style="background-color:cccccc;">
				<option value='title' selected><font size='2'>
                                                        글제목</font></option>
				<option value='contents'><font size='2'>
                                                        글내용</font></option>
				<option value='name'><font size='2'>
                                                        작성자</font></option>
				</select>
				</TD>
				<TD align='left'>
					<input type='text' name='keyword' 
                                                   value='' size='20' maxlength='30'>
					<input type='submit' value='검색'>
				</td>
			  </TR>
			  </FORM>
			  </TABLE> 
		</TD>

		<TD align='right'>		
		<a href='write.jsp'>[등록]</a>				
		</TD>
	</TR>
</TABLE>
                  
</BODY>                     
</HTML>