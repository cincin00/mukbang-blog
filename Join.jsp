<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>회원 가입 페이지</title>
<Script type="text/javascript">
<!--
	function isID(frm) 
	{
		var check = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.-_";
		myflag = new Boolean(true);

		if (frm.value == "") 
		{
			alert(frm.name + "가 입력되지 않았습니다.");
			frm.value = " ";
			frm.focus();
			return;
			
			for (var i = 0; i < frm.value.length; i++)
				if (-1 == check.indexOf(frm.value.charAt(i)))
					myflag = false;
				if (!myflag) 
				{
					alert("한글과 특수문자는 유효하지 않습니다.")
					frm.value = " ";
					frm.focus();
				}
		}
	}

	//주민등록번호 검사
	function isJumin() {
		var ju = join_membership.jumin.value;
		if (isNaN(ju)) {
			alert("숫자만 입력가능합니다.");
			join_membership.jumin.value = " ";
			join_membership.jumin.foucus();
		}

	}
	//입력정보 확인
	function check_form() 
	{
		var NULL = "";
		 
		if (document.join_membership.id.value == NULL) 
		{
			alert("아이디를 입력해 주세요.");
			document.join_membership.id.focus();
			return false;
		} 
		else if (document.join_membership.password.value == NULL) 
		{
			alert("비밀번호를 입력해 주세요.")
			document.join_membership.password.focus();
			return false;
		} 
		else if (document.join_membership.name.value == NULL) 
		{
			alert("이름을 입력해 주세요");
			document.join_membership.name.focus();
			return false;
		} 
		else if (document.join_membership.jumin.value == NULL) 
		{
			alert("주민등록번호를 입력해 주세요");
			document.join_membership.jumin.focus();
			return false;
		} 
		else 
		{
			alert("회원 가입을 환영 합니다.");
			return true;
		}
	}

	function select_all(string_text) {
		string_text.select();
	}
-->
</Script>
</head>
<body>
	<P Align="center">
		<Font size="4" color='blue'><b>회원정보 입력</b></Font>
	</P>
	<HR>
	<Form method="post"  action="join_input.jsp"  name="join_membership">
		<Table width="600" Height="350" Border="1" Cellpadding="5"
			Align="center">
			<TR>
				<TD>*아이디</TD>
				<TD>
					<!-- onBlur:포커스를 잃었을때 이벤트가 발생 -->
					<Input Type="text" Name="id" Size="30" onBlur="isID(this)">	
				</TD>
			</TR>
			<TR>
				<TD>*비밀번호</TD>
				<TD><Input Type="password" Name="password" Size="30"></TD>
			</TR>
			<TR>
				<TD>*이름</TD>
				<TD><Input Type="text" Name="name" Size="10"></TD>
			</TR>
			<TR>
				<TD>*주민등록번호(-제외)</TD>
				<TD><Input Type="text" Name="jumin" maxLength=14 Size=14
					onBlur="isJumin()"></TD>
			</TR>
			<TR>
				<TD>직업</TD>
				<TD><Select size="1" Name="job">
						<Option Selected>선택</Option>
						<Option>학생</Option>
						<Option>회사원</Option>
						<Option>자영업</Option>
						<Option>무직</Option>
				</Select></TD>
			</TR>
			<TR>
				<TD>성별</TD>
				<TD><Input Type="Radio" Name="btn" Value="male" Checked>남자&nbsp;&nbsp;
					<Input Type="Radio" Name="btn" Value="female">여자</TD>
			</TR>
			<TR>
				<TD>자기 소개</TD>
				<TD>
					<TextArea Row="7" Cols="60" Name="intro" onFocus="Select_all(this.form.text)">자기 소개하는 글을 쓰세요(200자 이내)
					</TextArea>
				</TD>
			<TR>
				<TD Colspan="2" Align="center">
					 <Input Type="submit" Value="회원가입" onClick="check_form()"> &nbsp;&nbsp;
					 <Input Type="reset" Value="가입취소">
				</TD>
			</TR>
		</Table>
	</Form>
	<center>
		<font color="red">(*는 필수 사항 입니다.)</font>
	</center>
</body>
</html>
​
