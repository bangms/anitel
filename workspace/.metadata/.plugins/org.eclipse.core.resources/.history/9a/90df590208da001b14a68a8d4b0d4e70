<%@page import="anitel.model.UsersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입 프로</title>
	<link href="style.css" rel="stylesheet" type="text/css" >
</head>

<%
	request.setCharacterEncoding("UTF-8");

	
%>

<jsp:useBean id="usersDto" class="anitel.model.UsersDTO" />
<jsp:setProperty property="*" name="usersDto"/>

<jsp:useBean id="petDto" class="anitel.model.PetDTO" />
<jsp:setProperty property="*" name="petDto"/>




<%
	// DAO 객체 생성
	UsersDAO dao = UsersDAO.getInstance();
	// 회원정보 DB에 저장시키는 메서드 호출, 이때 데이터는 vo 하나보내기.
	dao.insertUser(usersDto); 
	dao.insertPet(petDto, usersDto.getId()); 
	
	//response.sendRedirect("main.jsp");


%>
	 
 



<body>
안녕하세요


</body>
</html>