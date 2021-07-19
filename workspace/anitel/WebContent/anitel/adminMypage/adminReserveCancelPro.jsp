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
		String num = check[i];
		AdminDAO dao = AdminDAO.getInstance();
		result = dao.deleteReserve(num); 
	}

	if(result == 1) {%> 
</head>
<script>
	opener.parent.location='/anitel/anitel/adminMypage/adminReserveForm.jsp';
</script>
<body>
	<script>
		alert("예약 취소가 정상 처리 되었습니다.");
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