<%@page import="anitel.model.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

<jsp:useBean id="dto" class="anitel.model.BookingDTO" />
<jsp:setProperty property="*" name="dto"/>

<%
	request.setCharacterEncoding("UTF-8");
	BookingDAO dao = BookingDAO.getInstance();
	dao.insertBooking(dto);
	
	response.sendRedirect("payment.jsp");
%>
<body>

</body>
</html>