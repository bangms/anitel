<%@page import="anitel.model.MemberDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지(사업자회원) - 호텔정보 수정 결과</title>
</head>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="anitel.model.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")!=null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="/anitel/userLoginForm.jsp";
		</script>
<%	}else{ 
	//String id = (String)session.getAttribute("sid");
	String id = (String)request.getParameter("id");
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.memberHModify(id, dto);  
	System.out.println("memberHModifyPro.jsp - 호텔정보 수정 결과 : " + result + "(1 : 수정 성공, -1 : 수정 실패)");
%>
<body>
<%	if(result == 1){%>
		<script>
			alert("호텔 정보가 수정되었습니다.");
			window.location.href="/anitel/memberMypage/memberHInfo.jsp";
		</script>
<%	}else{%>
		<script>
			alert("호텔정보 수정 실패. 다시 시도해주세요.");
			history.go(-1);
		</script>
<%	}%>
</body>
<%	} %>
</html>