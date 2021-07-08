<%@page import="anitel.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<% 
	request.setCharacterEncoding("UTF-8"); 
	
	String Id = request.getParameter("Id");

	int result;
	AdminDAO dao = AdminDAO.getInstance();
	result = dao.MemberApprove(Id);
	
	if(result == 1){
%>
<script>
	alert("회원이 승인되었습니다.");
	opener.parent.location='/anitel/anitel/adminMypage/adminMemberForm.jsp';
	window.close();
</script>
	<%}else{ %>
<script>
	alert("오류 발생, 다시 시도 바랍니다.");
	opener.parent.location='/anitel/anitel/adminMypage/adminMemberForm.jsp';
	window.close();
</script>
	<%}%>
	

<body>

</body>
</html>