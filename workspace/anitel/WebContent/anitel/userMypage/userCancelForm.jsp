<%@page import="anitel.model.BookingDAO"%>
<%@page import="anitel.model.BookingDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>호텔 예약 취소</title>
<style>
input[type=button] {
	border: none;
	border-radius: 6px;
	width: 110px;
	height: 40px;
}

input[type=submit] {
	border: none;
	border-radius: 6px;
	width: 110px;
	height: 40px;
}

#withdraw {
	border: none;
	border-radius: 3px;
	width: 65px;
	height: 25px;
	font-size: 12px;
	margin-top: 15px;
	margin-left: 600px;
	position: relative;
}
</style>

<%	request.setCharacterEncoding("UTF-8");
	String booking_num= null;
	if(request.getParameter("booking_num") != null){
		booking_num = request.getParameter("booking_num");
	}
	

%>

</head>
<body>
	<br />
	<br />
	<br />
	<br />
	<form action="userCancelPro.jsp" method="post">

		<%if(booking_num != null){ %>
		<input type="hidden" name="booking_num" value="<%=booking_num%>" />
		<%} %>

		<table>
			<tr>
				<td align="center">해당 예약을 취소하시겠습니까?<br />
				<br /></td>
			</tr>

			<tr>
				<td align="center"><br /> <input type="submit" value="네" />&emsp;
					<input type="button" value="아니오" onclick='window.close()' /></td>
			</tr>
		</table>
	</form>
</body>
</html>
