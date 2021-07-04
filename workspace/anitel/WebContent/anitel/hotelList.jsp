<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="anitel.model.RoomDAO"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
  <link rel="stylesheet" href="style/search.css">
  <link rel="stylesheet" href="style/datepicker.min.css">
  <script src="js/jquery-3.1.1.min.js"></script>
 	<script src="js/datepicker.min.js"></script>
 	<script src="js/datepicker.ko.js"></script>
	<script type="text/javascript" src="js/search.js"></script>
	<title>리스트페이지</title>
</head>
<style>
	
/* 메인페이지 height 100% 옵션주기 위한 div */
.box {
	height: 140px;
}

.main_form {
	width: 80%;
	display: inline-flex;	
	position: absolute;
  left: 50%;
  transform: translate(-50%, 0);
  margin-top: 30px;
}


</style>
<% request.setCharacterEncoding("UTF-8");
String hotel_area = request.getParameter("hotel_area");
String check_in = request.getParameter("check_in");
String check_out = request.getParameter("check_out");
int pet_type = Integer.parseInt(request.getParameter("pet_type"));
System.out.println("지역 : " + hotel_area + " / 체크인 : " + check_in + " / 체크아웃 : " + check_out + " / 동물 종류 : " + pet_type);

String area[] = {"서울", "부산", "대구", "인천", "경기", "광주", "대전", "울산", "경상도", "전라도", "제주도", "충청도", "강원도"};
String petType[] = {"강아지", "고양이", "기타"};

int pageSize = 5;
String pageNum = request.getParameter("pageNum");
if(pageNum == null) {
	pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum); 
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
 
RoomDAO dao = RoomDAO.getInstance();

// 재검색 했을 때

Map hotelList = null;
int count = 0; // 전체 호텔 개수

count = dao.getHotelCount(hotel_area, check_in, check_out, pet_type); 
System.out.println("List 페이지 => 호텔 개수 : " + count);
if(count > 0) {
	hotelList = dao.getHotels(startRow, endRow, hotel_area, check_in, check_out, pet_type);  
}
%>
<script type="text/javascript">
$(document).ready(function(){
	datePickerSet($("#check_in"), $("#check_out"), true); //다중은 시작하는 달력 먼저, 끝달력 2번째
	
});
</script>
<body>
	<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='main.jsp'">
			<img src="imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice">공지사항</button>
<% 	
	if(session.getAttribute("sid") == null){ 
%>
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='loginForm.jsp'">로그인</button>
			
<%}else{ %>
			<button id="mypage" onclick="window.location='mypage.jsp'">마이페이지</button>
			<button id="signout" onclick="window.location='logout.jsp'">로그아웃</button>
<%}%>
		</div>
	</div>	
  <div id="section" style="height:100%;padding:0;">
  	<div class="box"></div>
		<div id="main_wrap">
			<form id="main_form" class="main_form" action="hotelList.jsp" method="post" name="searchForm" onsubmit="return check();">
				<div id="location" class="select-box">
				  <div class="select-box_current" tabindex="1">
			  	<%
			  		for (int i = 0; i < area.length; i++) { 
			  		%>
			  			<div class="select-box_value">
			      		<input class="select-box_input" type="radio" id="<%= i %>" value="<%= area[i] %>" name="hotel_area" <% if (area[i].equals(hotel_area)) {
			  				%>checked="checked"<%	} %> />
			      		<p class="select-box_input-text"><%= area[i] %></p>
			    		</div>	
			  	<%	}
			  	%>
			    	<img class="select-box_icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box_list">
				  <%
				  	for (int i = 0; i < area.length; i++) { %>
				  		<li>
					      <label class="select-box_option" for="<%= i %>" aria-hidden="aria-hidden"><%= area[i] %></label>
					    </li>
				  <%	}
				  %>
				  </ul>
				</div>
				
				<div class="double">
					<input id="check_in" class="check_date" type="text" name="check_in" value="<%=check_in %>" />
					<input id="check_out" class="check_date" type="text" name="check_out" value=<%=check_out %> />
				</div>

				<div id="pet" class="select-box">
				  <div class="select-box_current" tabindex="1">
				    <% for (int i = 0; i < petType.length; i++) { %>
				  		 <div class="select-box_value">
						      <input class="select-box_input" type="radio" id="pet_<%=i%>" value="<%=i%>" name="pet_type" <% if (i == pet_type) {
			  				%>checked="checked"<%	} %>/>
						      <p class="select-box_input-text"><%=petType[i]%></p>
						    </div>
				  <%	}
				  %>
				   <img class="select-box_icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box_list">
				  <%for (int i = 0; i < petType.length; i++) { %>
				  		<li>
				      <label class="select-box_option" for="pet_<%= i %>" aria-hidden="aria-hidden"><%= petType[i] %></label>
				    </li>
				  <%}%>
				  </ul>
				</div>
	
				<input type="submit" width="25px" height="25px" class="search_btn"/>
			</form>
			<div class="push"></div>
			
				<div class="inp_wrap">
					<div class="paid sub">
						<p>유료 서비스</p>
						<input class="inp-cbx" id="paid_bath" type="checkbox" name="paid_bath"/>
						<label class="cbx" for="paid_bath"><span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg></span><span>목욕서비스</span></label>
						<input class="inp-cbx" id="paid_beauty" type="checkbox" name="paid_beauty"/>
						<label class="cbx" for="paid_beauty"><span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg></span><span>미용서비스</span></label>
						<input class="inp-cbx" id="paid_medi" type="checkbox" name="paid_medi"/>
						<label class="cbx" for="paid_medi"><span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg></span><span>동물병원</span></label>
						<!--SVG Sprites-->
						<svg class="inline-svg">
						  <symbol id="check" viewbox="0 0 12 10">
						    <polyline points="1.5 6 4.5 9 10.5 1"></polyline>
						  </symbol>
						</svg>
					</div>
					
					<div class="util sub">
						<p>편의시설</p>
						<input class="inp-cbx" id="util_pool" type="checkbox" name="util_pool"/>
						<label class="cbx" for="util_pool"><span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg></span><span>수영장</span>
						</label>
						<input class="inp-cbx" id="util_ground" type="checkbox" name="util_ground"/>
						<label class="cbx" for="util_ground"><span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg></span><span>운동장</span>
						</label>
						<input class="inp-cbx" id="util_parking" type="checkbox" name="util_parking"/>
						<label class="cbx" for="util_parking">
							<span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg>
						  </span>
						  <span>무료주차</span>
						</label>
						<!--SVG Sprites-->
						<svg class="inline-svg">
						  <symbol id="check" viewbox="0 0 12 10">
						    <polyline points="1.5 6 4.5 9 10.5 1"></polyline>
						  </symbol>
						</svg>
					</div>
				
					<div class="pet_big sub">
						<p>대형견</p>
						<input class="inp-cbx" id="pet_big" type="checkbox" name="pet_big"/>
						<label class="cbx" for="pet_big"><span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg></span><span>대형견</span></label>
						<!--SVG Sprites-->
						<svg class="inline-svg">
						  <symbol id="check" viewbox="0 0 12 10">
						    <polyline points="1.5 6 4.5 9 10.5 1"></polyline>
						  </symbol>
						</svg>
					</div>
					<input type="button" value="결과 내 재검색" />
				</div>
			
			<div class="list_wrap">
				<ul class="hotel_list">
				<% if(count == 0) { %>
							<p class="empty">조건에 해당하는 호텔이 없습니다.</p>
				<%} else {%>
					<li>
							<% Iterator keys = hotelList.keySet().iterator();
							while (keys.hasNext()) {
							    String key = (String)keys.next(); %>
									<%= hotelList.get(key)%>
					<%		}    %>
							
					</li>
				<%}%>
				</ul>
			</div>	
		</div>
		

  </div>
	<!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
	<div id="footer" >
		 <img src="imgs/logo2.png" width=100px; height=50px;>
		 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
		 이용약관 | 취소정책 | 1:1문의 <br/>
			COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
	</div>
</div>
</body>
</html>