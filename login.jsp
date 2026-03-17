<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<body link="skyblue" alink="skyblue" vlink="skyblue">
	<center><font face="궁서" color="skyblue">*맛탕의 방문을 환영합니다*</font><br></center><br>
	<form method="post" action="login_ok.jsp">
	<table border="1" cellspacing="3" cellpadding="5">
		<tr>
			<td bgcolor='cccccc'><center>ID</center></td>
			<td><input type="text" size="15" name="id" ></td>
			<td rowspan="2"><input type="submit" value="로그인"></td>
		</tr>
		<tr>
			<td bgcolor='cccccc'>PW</td>
			<td><input type="password" size="15" name="password" ></td>
		</tr>
	</table>
	
	<p align="right"><a href="Join.jsp" target="new" text-decoration:none;>회원가입</a></p>

	
	</form>

</body>
</html>
