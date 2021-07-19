<%@page import="anitel.model.UsersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입 프로</title>
</head>
<%
	 String strReferer = request.getHeader("referer");
	 
	 if(strReferer == null){
	%>
	 <script language="javascript">
	  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다.\n\n정상적인 경로를 통해 다시 접근해 주십시오.");
	  document.location.href="main.jsp";
	 </script>
	<%
	  return;
	 }
	%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="user" class="anitel.model.UsersDTO" />
<jsp:useBean id="pet" class="anitel.model.PetDTO" />



<%

String user_tel1 = request.getParameter("user_tel1");
String user_tel2 = request.getParameter("user_tel2");
String user_tel3 = request.getParameter("user_tel3");

String user_phone = user_tel1 + "-" + user_tel2 + "-" + user_tel3; 
user.setUser_phone(user_phone);

%>
	 
<jsp:setProperty property="*" name="user"/>
<jsp:setProperty property="*" name="pet"/>

<%
	// DAO 객체 생성
	UsersDAO dao = UsersDAO.getInstance();
	// 회원정보 DB에 저장시키는 메서드 호출, 이때 데이터는 vo 하나보내기.
	dao.insertUser(user); 
	dao.insertPet(pet, user.getId());    
%>

	 
	 <script type="text/javascript">
		alert("회원 가입이 정상적으로 처리 되었습니다.");
		window.location.href="main.jsp";
	</script>
 



<body>
</body>
</html>
