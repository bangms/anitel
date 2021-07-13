<%@page import="anitel.model.PetDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>반려동물추가	 프로</title>
	<style>

      img {
    	align:center;
      	padding: 20px;
      	margin-top:50px;
      }
    </style>
</head>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="anitel.model.PetDTO"/>
<jsp:setProperty property="*" name="dto"/>


 <%	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	//if(session.getAttribute("sid")!=null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
	<!-- 	<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="userLoginForm.jsp";
		</script> -->
<%	//}else{ 
	//String id = (String)session.getAttribute("sid");
	String id = "java04";
	PetDAO dao = PetDAO.getInstance();
	int result = dao.insertPet(id,dto);
	
	System.out.println("petAddPro.jsp - 반려동물 추가 결과 : " + result + "(1 : 수정 성공, -1 : 수정 실패)");
%>
<body>
<%	if(result == 1){%>
		<script>
			alert("반려동물 정보가 추가되었습니다.");
			window.location.href="/anitel/anitel/userMyPage/userMyPage.jsp";
		</script>
<%	}else{%>
		<script>
			alert("반려동물 추가 실패. 다시 시도해주세요.");
			history.go(-1);
		</script>
<%	}%>
</body>
<%	//} %>
</html>

