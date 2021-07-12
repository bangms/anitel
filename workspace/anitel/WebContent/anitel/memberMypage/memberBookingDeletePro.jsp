<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약 삭제 결과</title>
<%
	String[] check = request.getParameterValues("check");
	int result = 0;
	
	for(int i = 0 ; i < check.length; i++){
		String num = check[i];
		System.out.println("booking_num : " + num);
		MemberDAO dao = MemberDAO.getInstance();
		result = dao.deleteBooking(num);		
	}

	if(result == 1) {%> 
</head>
<body>
	<script>
		alert("해당 예약이 정상적으로 삭제 되었습니다.");
		opener.parent.location='/anitel/memberMypage/memberBookingModifyForm.jsp';
		window.close();
	</script>
<%}else{ %>
	<script>
		alert("오류가 발생하였습니다. 다시 시도해주세요.");
		window.close();
	</script>
</body>
<%} %>
</html>