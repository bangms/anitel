<%@page import="anitel.model.AdminDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 
	String [] check = request.getParameterValues("check");
	int result = 0;
	
	AdminDAO dao = AdminDAO.getInstance();
	
	for(int i = 0; i < check.length; i++){
		String num = (String)check[i];
		result = dao.deleteReview(num);
		
	}
	
	
	
	
	if(result == 1){
%>
<script>
	alert("회원이 삭제되었습니다.");
	opener.parent.location='/anitel/anitel/adminMypage/adminReviewForm.jsp';
	window.close();
</script>
	<%}else{ %>
<script>
	alert("오류 발생, 다시 시도 바랍니다.");
	opener.parent.location='/anitel/anitel/adminMypage/adminReviewForm.jsp';
	window.close();
</script>
	<%}%>
	
<body>
	
	
</body>
</html>