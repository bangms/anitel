<%@page import="anitel.model.AdminDAO"%>
<%@page import="anitel.model.PetDTO"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.UsersDTO"%>
<%@page import="anitel.model.RoomDTO"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="js/reservejs.js"></script>
	<link rel="stylesheet" href="style/style.css">
	<link rel="stylesheet" href="style/reset.css">
</head>
<%
	request.setCharacterEncoding("UTF-8");

	// 디테일에서 넘어오는 정보 수정
	String memId = request.getParameter("memId");
	String roomNum = request.getParameter("room_num");
	String check_in = request.getParameter("check_in");
	String check_out = request.getParameter("check_out");
	
	String id =(String)session.getAttribute("sid");
	

	BookingDAO dao = BookingDAO.getInstance();
	UsersDTO userInfo = new UsersDTO();
	userInfo = dao.getReserveUserInfo(id);
	
	List petInfo = dao.getReservePetInfo(id);
	PetDTO pet = new PetDTO();
%>
<body>
	<select name="pet" id="pet">
		<option>반려동물 선택</option>
		<%for(int i = 0; i < petInfo.size(); i++){ 
			pet = (PetDTO)petInfo.get(i);
		%>
		<option value="<%=pet.getPet_num()%>"><%=pet.getPet_name() %></option>
		<%}%>
	</select>
	<form action="reservePro.jsp" method="post">
		<input type="text" name="user_name" value="<%=userInfo.getUser_name()%>" />
		<lable for="user_name">예약자 이름</lable>
		
		<input type="text" name="user_email" value="<%=userInfo.getUser_email()%>" />
		<lable for="user_email">예약자 이메일</lable>
		
		<input type="text" name="user_tel" value="<%=userInfo.getUser_phone()%>" />
		<lable for="user_tel">예약자 전화번호</lable>
		
		<input type="text" name="pet_name" />
		<lable for="user_name">반려동물 이름</lable>
		
		<input type="submit" value="확인" />
	</form>
</body>
</html>