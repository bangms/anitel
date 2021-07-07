<%@page import="anitel.model.MemberDAO"%>
<%@page import="anitel.model.UsersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ID 중복확인</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="style/init.css">
</head>
<%
	String id = request.getParameter("id");
	UsersDAO user = UsersDAO.getInstance(); 
	boolean result = user.confirmId(id);
%>
<body>
<% 	if(result) { // 아이디가 존재함 %>
		<table>
			<tr>
				<td><%= id %>, 이미 사용 중인 아이디 입니다.</td>
			</tr>
		</table>
		<form action="confirmId.jsp" method="post">
			<table>
				<tr> 
					<td>다른 아이디를 선택하세요.</td>
					<input type="text" name="id" />
					<input type="submit" value="ID 중복확인" />
				</tr>
			</table>
		</form>
<%	} else { // 아이디가 존재하지 않는 경우 즉, 사용가능한 경우%>
		<table>
			<tr>
				<td>입력하신 <%= id %> 는 사용가능한 아이디 입니다. <br />
					<input type="button" value="닫기" onclick="setId()"/>
				</td>
			</tr>
		</table>
<% 	} %>
</body>
<script type="text/javascript">
	function setId() {
		// signupForm 페이지의 id 태그에 값 변경해주기
		opener.document.inputForm.id.value = "<%= id %>";
		self.close(); // 팝업창 닫기
	}
</script>
</html>