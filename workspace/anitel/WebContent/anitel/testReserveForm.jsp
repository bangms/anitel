<%@page import="anitel.model.PetDTO"%>
<%@page import="anitel.model.UsersDTO"%>
<%@page import="anitel.model.RoomDTO"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="sun.security.jca.GetInstance"%>
<%@page import="anitel.model.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Reserve</title>
	<link rel="stylesheet" href="style.css">
</head>
<%
	request.setCharacterEncoding("UTF-8");
	
	System.out.println("ReserveForm.jsp");
	
	String memId = request.getParameter("memId");
	String check_in = request.getParameter("check_in");
	String check_out = request.getParameter("check_out");
	String roomNum = request.getParameter("room_num");
	String id =(String)session.getAttribute("sid");
	
	int num = 0;
	if(request.getParameter("num")!=null){
		num = Integer.parseInt(request.getParameter("num"));
	}
	
	BookingDAO dao = BookingDAO.getInstance();

	MemberDTO hotel = new MemberDTO();
	hotel = dao.getHotelInfo(memId);
	
	RoomDTO room = new RoomDTO();
	room = dao.getRoomInfo(roomNum);
	
	UsersDTO userInfo = new UsersDTO();
	userInfo = dao.getReserveUserInfo(id);
	
	List petInfo = dao.getReservePetInfo(id);
	PetDTO pet = new PetDTO();
	
	String sel = request.getParameter("sel");
	if(sel != null) {
	//	petInfo = dao.getSearchReservePetInfo(id,sel);
	}
	String petNum = request.getParameter("pet_num");
	System.out.println(petNum);
	
%>
	<script>
		function chch(){
			if($("#check").is(":checked")){
				document.getElementById('name').readonly = true;
				document.getElementById('email').readonly = true;
				document.getElementById('phone').readonly = true;
				document.getElementById('name').value = <%=userInfo.getUser_name()%>;
				document.getElementById('email').value = <%=userInfo.getUser_email()%>;
				document.getElementById('phone').value = <%=userInfo.getUser_phone()%>;
				
			}else if(($("#chk1").is(":checked"))== false){
				document.getElementById('name').readonly = false;
				document.getElementById('email').readonly = false;
				document.getElementById('phone').readonly = false;
			}
		}	
	</script>

<body>
	<form action="ReservePro.jsp" method="post">		
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
			<%}else{ %>
				<button id="mypage" onclick="window.location='userMyPage.jsp'">마이페이지</button>
				<button id="signout" onclick="window.location='../logout.jsp'">로그아웃</button>
			<%}%>
			</div>
		</div>	
	<div id="section" class="reserve_wrapper">
		<div class="hotel_info">
			<ul>
				<li><%=hotel.getHotel_name() %></li>
				<li><%=hotel.getHotel_add() %></li>
		        <%if(hotel.getHotel_img()!= null){%>
					<li><img src="/anitel/save/<%=hotel.getHotel_img()%>" /></li>	
				<%}else{ %>
					<li><img src="/anitel/save/default.png"/></li>
				<%} %>	
				<li>체크인 <%=check_in %></li>
				<li>체크아웃 <%=check_out %></li>				
			</ul>		
		</div>
		<div class="user_info">
			<table>
				<tr>
					<td>예약자 정보</td>
					
				</tr>
				<tr>
					<td>성함 *</td>
					<td>
						<input type="text" name="name" value="<%=userInfo.getUser_name()%>" />
					</td>
				</tr>
				<tr>
					<td>이메일 *</td>
					<td>
						<input type="text" name="email" value="<%=userInfo.getUser_email()%>" />
					</td>
				</tr>
				<tr>
					<td>휴대폰 *</td>
					<td>
						<input type="text" name="phone" value="<%=userInfo.getUser_phone()%>" />
					</td>
				</tr>
				<tr>
					<td>반려동물 이름 *</td>
					<td>
						
						<select name="sel">
							<%for(int i = 0; i < petInfo.size(); i++){ 
								pet = (PetDTO)petInfo.get(i);
							%>
							<option value="<%=pet.getPet_num()%>"><%=pet.getPet_name() %></option>
							<%}%>
						</select>
						<input type="button" value="선택" onclick="window.location='testReserveForm.jsp'"/>
					</td>
				</tr>
				<tr>
					<td>반려동물 종류</td>
					<td>
						<input type="text" name="pettype" value="<%=pet.getPet_type()%>"/>
					</td>
				</tr>
				<tr>
					<td>반려동물 성별</td>
					<td>
	
						<input type="text" name="petgender" value="<%=pet.getPet_gender()%>"/>

					</td>
				</tr>
				<tr>
					<td>반려동물 나이</td>
					<td>
						<input type="text" name="petage" value="<%=pet.getPet_age()%>"/>
					</td>
				</tr>
				<tr>
					<td>대형견 여부</td>
					<td>
						<input type="text" name="petbig" value="<%if(pet.getPet_big() == 0){%>소형<%}else{%>대형<%}%>"/>
					</td>
				</tr>
				<tr>
					<td>중성화 여부</td>
					<td>
						<input type="radio" name="petopr" value="0" <%if(pet.getPet_operation() == 0){%>checked="checked"<%}%>/>
						<input type="radio" name="petopr" value="1" <%if(pet.getPet_operation() == 1){%>checked="checked"<%}%>/>
					</td>
				</tr>
			</table>
			<table>
				<tr> 
					<td>유료서비스 :</td>
					<td>
						<%if(hotel.getPaid_medi() == 1) {%> <input type="checkbox" value="paid" /> 동물병원 <%} %>
					</td>
					<td>
						<%if(hotel.getPaid_bath() == 1) {%> <input type="checkbox" value="paid" /> 목욕 <%} %>
					</td>
					<td>
						<%if(hotel.getPaid_beauty() == 1) {%> <input type="checkbox" value="paid" /> 미용 <%} %>
					</td>
					<td>유료서비스는 현장 결제 후 이용 가능합니다.</td>	
				</tr>
				<tr>
					<td>요청사항</td>
					<td>
						<input type="text" name="requests" />
					</td>
				</tr>
			</table>
			<div class="room_info">
				<table>
					<tr>
						<td>객실세부정보</td>
						<td>편의시설</td>
						<td><%if(hotel.getUtil_pool() == 1) {%>수영장 <%}%></td>
						<td><%if(hotel.getUtil_parking() == 1) {%>무료주차 <%}%></td>
						<td><%if(hotel.getUtil_ground() == 1) {%>대형운동장 <%}%></td>
						<td><%=room.getImg() %></td>
						<td><%=room.getName() %></td>
					</tr>
				</table>			
			</div>
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
		</div>
	</div>
			<div id="footer" style="margin-top:-120px">
			 <img src="imgs/logo2.png" width=100px; height=50px;>
			 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
			 이용약관 | 취소정책 | 1:1문의 <br/>
				COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
			</div>	
	</div>
	</form>
</body>
</html>