<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="anitel.model.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

<%request.setCharacterEncoding("UTF-8");
String check_in = request.getParameter("checkIn");
String check_out = request.getParameter("checkOut");
	
%>	
<jsp:useBean id="dto" class="anitel.model.BookingDTO" />
<jsp:setProperty property="*" name="dto" />

	
<%
	BookingDAO dao = BookingDAO.getInstance();

	dto.setCheck_in(dao.convertStringToTimestamp(check_in));
	dto.setCheck_out(dao.convertStringToTimestamp(check_out));
	
	dao.insertBooking(dto);
	response.sendRedirect("payment.jsp");
%>
<body>

</body>
</html>