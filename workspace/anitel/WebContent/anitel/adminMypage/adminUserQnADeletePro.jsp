<%@page import="anitel.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
<%
	String[] check = request.getParameterValues("check");
	int result = 0;
	
	for(int i = 0 ; i < check.length; i++){
		String id = check[i];
		AdminDAO dao = AdminDAO.getInstance();
		result = dao.deleteUserQna(id);		 
	}

	if(result == 1) {%> 
</head>
<body>
	<script>
		alert("문의글 삭제가 정상 처리 되었습니다.");
		window.close();
	</script>
<%}else{ %>
	<h3>회원 삭제 처리가 되지 않았습니다.</h3>
</body>
<%} %>
</html>