<%@page import="anitel.model.UsersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 login Pro</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String auto = request.getParameter("auto"); 
	
		UsersDAO dao = UsersDAO.getInstance(); 
		// 쿠키에서 준 id, pw 주고 다시 한번 체크
		boolean res = dao.idPwCheck(id, pw);
		
		if(res) {
			
			// 자동로그인 처리
			session.setAttribute("sid", id);
			response.sendRedirect("main.jsp"); // main 으로 이동 !
		} else { %>
			<script type="text/javascript">
				alert("ID 또는 PASSWORD 가 일치하지 않습니다. 다시 시도해주세요.");
				history.go(-1); // 다시 form 페이지(이전페이지)로 이동시킴
			</script>
	<% } %>
</body>
</html>