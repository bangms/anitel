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
	
	AdminDAO dao = AdminDAO.getInstance();
	
	for(int i = 0 ; i < check.length; i++){
		String id = check[i];
		result = dao.deleteUser(id);  
		//dao.deleteUsersPet(id);
		//dao.deleteUserBooking(id);	// 회원 삭제시, 해당 회원 예약상태 변경(예정->취소)
	}

	if(result == 1) {%> 
</head>
<script>
	opener.parent.location='/anitel/anitel/adminMypage/adminUserForm.jsp';
</script>
<body>
	<script>
		alert("회원 삭제가 정상 처리 되었습니다.");
		window.close();
	</script>
<%}else{ %>
	<script>
		alert("오류 발생, 다시 시도 바랍니다.");
		window.close();
	</script>
</body>
<%} %>
</html>
