<%@page import="anitel.model.PetDTO"%>
<%@page import="anitel.model.PetDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>반려동물 정보 수정pro</title>
</head>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="anitel.model.PetDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){ 	%>
	 	<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="userLoginForm.jsp";
		</script> 
<%	}else{ 
	String id = (String)session.getAttribute("sid");
	PetDAO dao = PetDAO.getInstance();
	int result = dao.updatePet(id, dto);
	
	System.out.println("petinfoModifyPro.jsp - 반려동물 정보수정 결과 : " + result + "(1 : 수정 성공, -1 : 수정 실패)");
%>
<body>
<%	if(result == 1){%>
		<script>
			alert("회원 정보가 수정되었습니다.");
			window.location.href="userMyPage.jsp";
		</script>
<%	}else{%>
		<script>
			alert("회원정보 수정 실패. 다시 시도해주세요.");
			history.go(-1);
		</script>
<%	}%>
</body>
<% } %>
</html>
