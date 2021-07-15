
<%@page import="anitel.model.BookingDTO"%>
<%@page import="anitel.model.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약 취소 pro.</title>
	<%
		
		BookingDAO dao = BookingDAO.getInstance();
		String booking_num = request.getParameter("booking_num");
		int result = dao.cancleReserve(Integer.parseInt(booking_num));		
 
	if(result == 1) {%> 
</head>
<body>
	<script>
		alert("호텔 예약이 취소되었습니다.");
		opener.document.location="userMyReserve.jsp"; 	
		self.close();
	</script>
<%}else{%>
	<script>
		alert("오류가 발생했습니다. 다시 시도해주세요.");
		history.go(-1);
	</script>

</body>
<%}%>
</html>
