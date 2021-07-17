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
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" content="no-cache">
	<meta name="viewport" content="width=device-width, initial-scale=1" content="no-cache">	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<link rel="stylesheet" href="style/style.css">
	
	<jsp:useBean id="dto" class="anitel.model.UsersDTO" />
	<jsp:setProperty property="*" name="dto"/>

	<style>
	.reserve_wrapper {
	  width: 85%;
	  padding-top: 140px;
	  margin: 0 auto;
	}	
	.hotelinfo_wrapper {
	  width: 100%;
	  height: 300px;
	  position: relative;
	  background-color: cornflowerblue;
	}
	.reinfo_wrap {
	  width:60%;
	  height:100%;
	  background-color: #eee;
	  float:left;
	  text-align: left;
	}	
	.hotelimg {
	  width:40%;
	  float:right;
	  height:100%;
	}	
	.hotelimg > img {
	  width:100%;
	  height:100%;
	}
	.userinfo_wrapper {
	  width: 100%;
	  padding:20px 0;
	  height: auto;
	  text-align: left;
	  background-color: #f2f2f2;
	}
	.roominfo_wrapper {
	  width: 100%;
	  margin-top: 20px;
	  padding:20px 0;
	  height:auto;
	  overflow:hidden;
	  text-align: left;
	  background-color: green;
	}
	.room_det {
	  width:100%;
	  height:auto;
	  overflow:hidden;
      padding-top: 20px;	
	}
	.room_det li {
	  height: 230px;
	  margin-bottom: 20px;
	}
	.end_wrapper {
	  width: 100%;
	  margin-top: 10px;
	  margin-bottom: 20px;
	  padding:20px 0;
	  height: auto;
	  text-align: left;
	  background-color: cornflowerblue;
	}
	.util {
		display: flex;
		float:left;
		width: 100%;
	}		
	</style>
	
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
	<script type="text/javascript">
	$(document).ready(function() {
		var pet_num = $("#pet").val();
		 
		$("#pet").change(function() {
			pet_num = $(this).val();
			$.ajax({
				url : "petCheckPro.jsp",
				type : "POST",
				data : "pet_num=" + pet_num,
				dataType: "json",
				success : function(data){
					var list = "<table width='100%'>"+
										"<tr>"+			
											"<td>반려동물 이름* "+data.pet_name+"</td>"+
										"</tr>"+
										"<tr>"+
											"<td>반려동물 종 "+data.pet_type+"</td>"+
										"</tr>"+
										"<tr>"+
											"<td>반려동물 성별 "+data.pet_gender+"</td>"+
										"</tr>"+
										"<tr>"+
											"<td>반려동물 나이 "+data.pet_age+" 살</td>"+
										"</tr>"+
										"<tr>"+
											"<td>대형견 여부 "+data.pet_big+"</td>"+
										"</tr>"+
										"<tr>"+
											"<td>중성화 여부 "+data.pet_operation+"</td>"+
										"</tr>"+
									"</table>";
					$("#rs").empty();
					$("#rs").append(list);
					$("#rs").show();	
				},
				error : function(request,status,error){
					        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					      }		   
			});
			
		});
			 
	});
	
	</script>	
</head>
<body>
	<div id="container">
		<div id="header">
			<div id="logo" onclick="window.location='main.jsp'">
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
		<form action="reservePro.jsp" method="post">
		<div class="reserve_wrapper">
			<div class="hotelinfo_wrapper">
				<div class="reinfo_wrap">
					<h1><%=hotel.getHotel_name() %></h1>
					<h3><%=hotel.getHotel_add() %></h3><br /><br />
					<strong>체크인</strong>
					<span><%=check_in %></span><br /><br />
					<strong>체크아웃</strong>
					<span><%=check_out %></span>
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
				<h1> 예약자 정보 </h1>
				<hr />
					<p><strong>예약자 이름 *</strong>
					<input type="text" name="name" value="<%=userInfo.getUser_name()%>" /></p>
					<p><strong>예약자 이메일 *</strong>
					<input type="text" name="email" value="<%=userInfo.getUser_email()%>" /></p>
					<p><strong>예약자 전화번호 *</strong>
					<input type="text" name="phone" value="<%=userInfo.getUser_phone()%>" /></p>
					<p><strong>예약자 반려동물 정보</strong>
						<select name="pet" id="pet">
								<option>정보 등록 된 반려동물 중 선택</option>
								<%for(int i = 0; i < petInfo.size(); i++){ 
									pet = (PetDTO)petInfo.get(i);
								%>
								<option value="<%=pet.getPet_num()%>"><%=pet.getPet_name() %></option>
								<%}%>
						</select>
						<div id = "rs"></div>
					</p>
					<p><strong>유료서비스 : </strong></p>
					<p> <%if(hotel.getPaid_medi() == 1) {%> <input type="checkbox" value="paid" /> 동물병원 <%} %>
						<%if(hotel.getPaid_bath() == 1) {%> <input type="checkbox" value="paid" /> 목욕 <%} %>
						<%if(hotel.getPaid_beauty() == 1) {%> <input type="checkbox" value="paid" /> 미용 <%} %> </p>
					<p> 원하시는 서비스를 선택해주세요. * 유료서비스는 현장 결제 후 이용 가능합니다. * </p>
					<p><strong>요청사항</strong></p>
					<p><textarea name="requests" cols="200" rows="20"></textarea></p>
			</div>
			<div class="roominfo_wrapper">
			 	<h3> 객실 세부 정보 </h3>
				<div class="util">
					<h4>편의시설</h4>					
							<%if(hotel.getUtil_pool() == 1) { %>
							<div class="icon">
								<img src = "imgs/swim.png" />
								<span>수영장</span>
							</div>		
							<%}%>
							<%if(hotel.getUtil_ground() == 1) {%>
							<div class="icon">
								<img src = "imgs/park.png" />
								<span>운동장</span>
							</div>						
						<%} %>		
							<%if(hotel.getUtil_parking() == 1) {%>
							<div class="icon">
									<img src = "imgs/parking.png" />							
									<span>무료주차</span>
							</div>
						<%} %>						
		   		</div>
			</div>
			<div class="room_det">	
		   		<ul class="room_list_wrap">
				    <li class="room_list">
					      	<div class="img_wrap">
					      		<img src="/anitel/save/<%=room.getImg()%>" />
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
					 </ul>
			</div>	
			<div class="end_wrapper">
				<h3>취소정책</h3>
				<p>호텔은 체크인 기준 24시간 전까지만 취소 가능하며, 이후 환불 규정은 공지사항을 참고해주세요</p>
				<p><input type="checkbox" value="동의" /> 동의함 *</p>
				<h3>예약약관</h3>
				<p>이용약관을 모두 숙지 후 예약약관 동의해주세요.</p>
				<p><input type="checkbox" value="동의" /> 동의함 *</p><br /><br />
				<span>결제금액</span>
				<span><%=room.getD_fee() %></span>
				<span>
					<input type="submit" value="결제하기" />
					<input type="button" value="취소" onclick="window.location='hotelDetail.jsp'" />
				</span>
		  </div>
		</div> <!-- reserve_wrapper 끝 -->
	</form>	
 	<div id="footer">
	 <img src="imgs/logo2.png" width=100px; height=50px;>
	 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
	 이용약관 | 취소정책 | 1:1문의 <br/>
		COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
	</div>
	</div> <!-- container 끝 -->
</body>
</html>