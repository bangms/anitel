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
	<link rel="stylesheet" href="style.css">

	<style>
	
	.reserve_wrapper {
	  width: 85%;
	  margin: 0 auto;
	}
	
	.hotelinfo_wrapper {
	  width: 100%;
	  height: 300px;
	  position: relative;;
	}
	.reinfo_wrap {
	  width:60%;
	  height: 280px;
	  background-color: #eee;
	  float:left;
	}	
	.hotelimg {
	  width:33%;
	  float:right;
	  height:280px;
	}	
	.userinfo_wrapper {
	  width: 100%;
	  margin-top: 20px;
	  padding:20px 0;
	  height: 400px;
	}
	.roominfo_wrapper {
	  width: 100%;
	  margin-top: 20px;
	  padding:20px 0;
	  height: 150px;
	}
	.end_wrapper {
	  width: 100%;
	  margin-top: 20px;
	  padding:20px 0;
	  height: 150px;
	  background-color: cornflowerblue;
	}		
	</style>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	String memId = request.getParameter("memId");
	String roomNum = request.getParameter("room_num");
	String check_in = request.getParameter("check_in");
	String check_out = request.getParameter("check_out");
	
	String id =(String)session.getAttribute("sid");
		
	BookingDAO dao = BookingDAO.getInstance();

	MemberDTO hotel = new MemberDTO();
	hotel = dao.getHotelInfo(memId);
	
	UsersDTO userInfo = new UsersDTO();
	userInfo = dao.getReserveUserInfo(id);
	
	List petInfo = dao.getReservePetInfo(id);
	PetDTO pet = new PetDTO();
	
	RoomDTO room = new RoomDTO();
	room = dao.getRoomInfo(roomNum);

%>
<body>
	<div id="container">
		<div id="header">
			<div id="logo" onclick="window.location='../main.jsp'">
				<img src="imgs/logo.png" width="200px" height="100px" alt="logo">
			</div>
			<div id="button">
				<button id="notice" onclick="window.location='../board/list.jsp?categ=0'">공지사항</button>
				<% 	
				if(session.getAttribute("sid") == null){ 
				%>
					<button id="signin" onclick="window.location='../signIn.jsp'">회원가입</button>
					<button id="login" onclick="window.location='../loginForm.jsp'">로그인</button>			
				<%}else{%>
					<button id="mypage" onclick="window.location='userMyPage.jsp'">마이페이지</button>
					<button id="signout" onclick="window.location='../logout.jsp'">로그아웃</button>
				<%}%>
			</div>
		</div> <!-- header 끝 -->
		
		<div id="section" class="reserve_wrapper">
			<div class="hotelinfo_wrapper">
				<div class="reinfo_wrap">
					<p><strong><%=hotel.getHotel_name() %></strong></p>
					<p><%=hotel.getHotel_add() %></p> <br /><br />
					<p>체크인 <%=check_in %></p>
					<p>체크아웃 <%=check_out %></p>
				</div>
				<div class="hotelimg">
					<%if(hotel.getHotel_img()!= null){%>
						<img src="save/<%=hotel.getHotel_img()%>" />
					<%}else{ %>
					<img src="save/default.png"/>
					<%} %>
				</div>		
			</div> <!-- hotelinfo_wrapper 끝  -->
			<div class="userinfo_wrapper">
				<h3> 예약자 정보 </h3>
					<p><strong>성함 *</strong>
					<input type="text" name="name" value="<%=userInfo.getUser_name()%>" /></p>
					<p><strong>이메일 *</strong>
					<input type="text" name="email" value="<%=userInfo.getUser_email()%>" /></p>
					<p><strong>전화번호 *</strong>
					<input type="text" name="phone" value="<%=userInfo.getUser_phone()%>" /></p>
					
					<!-- 이부분 수정 중 -->	
				<form action="reserveForm.jsp" method="post" onsubmit="return check();">
					<select name="sel">
							<%for(int i = 0; i < petInfo.size(); i++){ 
								pet = (PetDTO)petInfo.get(i);
							%>
							<option value="<%=pet.getPet_num()%>"><%=pet.getPet_name() %></option>
							<%}%>
					</select>			
				</form>
			</div>
			<div class="roominfo_wrapper">
			 	<h3> 객실 세부 정보 </h3>
				<div class="util">
					<h4>편의시설</h4>
						<div class="icon">
							<%if(hotel.getUtil_pool() == 1) { %>
								<img src = "imgs/swim.png" />
								<span>수영장</span>	
							<%}%>
							<%if(hotel.getUtil_ground() == 1) {%>
								<img src = "imgs/park.png" />
								<span>운동장</span>							
						<%} %>		
						<%if(hotel.getUtil_parking() == 1) {%>
								<img src = "imgs/parking.png" />							
								<span>무료주차</span>
						<%} %>
						</div>
		   		</div>
		   		<li class="room_list">
			      	<div class="img_wrap">
			      		<img src="/anitel/save/<%=room.getImg()%>" class="room_img" alt="room_img"/>
			      	</div>
			      	<div class="txt_wrap">
				      	<div class="room_name"><%=room.getName()%></div>
				      	<div class="pet_big">
				      		<% if(room.getPet_big() == 1) { %>
				      				대형견 전용
				      		<% } %>
				      	</div>
			      	</div>
		      </li>
			</div>
			<div class="end_wrapper">
				<table>
					<tr>
						<td>취소정책</td>
						<td>호텔은 체크인 기준 24시간 전까지만 취소 가능하며, 이후 환불 규정은 공지사항을 참고해주세요.</td>
						<td>
							<input type="checkbox" value="동의" /> 동의함 *
						</td>
					</tr>
					<tr>
						<td>예약약관</td>
						<td>이용약관을 모두 숙지 후 예약약관에 동의</td>
						<td>
							<input type="checkbox" value="동의" /> 동의함 *
						</td>
					</tr>
					<tr>
						<td>결제할금액</td>
						<td><%=room.getD_fee() %></td>
						<td>
							<input type="submit" value="결제하기" />
							<input type="button" value="취소" onclick="window.location='hotelDetail.jsp'" />
						</td>
					</tr>
				</table>	
		  ``</div>
		</div> <!-- reserve_wrapper 끝 -->
	</div> <!-- container 끝 -->
</body>
</html>