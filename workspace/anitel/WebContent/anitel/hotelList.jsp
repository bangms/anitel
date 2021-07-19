<%@page import="anitel.model.BoardDAO"%>
<%@page import="anitel.model.HotelDTO"%> 
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
<%
	 String strReferer = request.getHeader("referer");
	 
	 if(strReferer == null){
	%>
	 <script language="javascript">
	  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다.\n\n정상적인 경로를 통해 다시 접근해 주십시오.");
	  document.location.href="main.jsp";
	 </script>
	<%
	  return;
	 }
	%>
<style>
	
/* 메인페이지 height 100% 옵션주기 위한 div */
.box {
	height: 140px;
}

.main_form {
	width: 80%;
	position: absolute;
	left: 50%;
	transform: translate(-50%, 0);
	margin-top: 30px;
	text-align: center;
}

.search_bar {
	display:inline-flex;
}

</style>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="hotel" class="anitel.model.HotelDTO" />
<jsp:setProperty property="*" name="hotel"/>
<%
System.out.println("지역 : " + hotel.getHotel_area() + " / 체크인 : " + hotel.getCheck_in() + " / 체크아웃 : " + hotel.getCheck_out() + " / 동물 종류 : " + hotel.getPet_type());
System.out.println("\n\n*** 편의시설 *** \n 수영장 : " + hotel.getUtil_pool() + " / 운동장 : " + hotel.getUtil_ground() + " / 무료주차 : " + hotel.getUtil_parking() + 
			"\n *** 유료 서비스 ***\n 목욕 : " + hotel.getPaid_bath() + " / 미용 : " + hotel.getPaid_beauty() + " / 병원 : " + hotel.getPaid_medi() + "\n *** 대형동물 *** \n 대형동물 : " + hotel.getPet_big() +"\n\n");


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


List<HotelDTO> hotelList = null;
int count = 0; // 전체 호텔 개수

String sub = request.getParameter("sub");
String subSql = "";

if("1".equals(hotel.getUtil_pool())) {subSql += " and m.util_pool = 1";}
if("1".equals(hotel.getUtil_ground())) {subSql += " and m.util_ground = 1";}
if("1".equals(hotel.getUtil_parking())) {subSql += " and m.util_parking = 1";}
if("1".equals(hotel.getPaid_bath())) {subSql += " and m.paid_bath = 1";}
if("1".equals(hotel.getPaid_beauty())) {subSql += " and m.paid_beauty = 1";}
if("1".equals(hotel.getPaid_medi())) {subSql += " and m.paid_medi = 1";}
if("1".equals(hotel.getPet_big())) {subSql += " and e.pet_big = 1";}


if(sub != null) { // 검색 한 경우 
	count = dao.getSubHotelCount(hotel, subSql); // 검색된 글의 총 개수 가져오기  
	System.out.println("세부 List 페이지 => 호텔 개수 : " + count);
	// 검색한 글이 하나라도 있으면 검색한 글 가져오기 
	if(count > 0) {
		hotelList = dao.getSubHotels(startRow, endRow, hotel, subSql);
	} 
	
} else { // 세부검색 X (메인 -> 리스트 상태)
	
	count = dao.getHotelCount(hotel); 
	System.out.println("List 페이지 => 호텔 개수 : " + count + "\n\n");
	if(count > 0) {
		hotelList = dao.getHotels(startRow, endRow, hotel);  
	}
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
			<button id="notice" onclick="window.location='board/list.jsp?categ=0'">공지사항</button>
<% 	
	String id =(String)session.getAttribute("sid");

	if(id == null){ 
%>
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='loginForm.jsp'">로그인</button>
			
<%}else{ 
		BoardDAO board = BoardDAO.getInstance(); 
		int checkID = board.idCk(id);
		System.out.println("아이디 체크 - 사업자면 2, 일반회원이면 1 : " + checkID);
		
		if(checkID == 1) { 
			if(session.getAttribute("sid").equals("admin")) { %><%--— 관리자 일 때 —--%>
				<button id="mypage" onclick="window.location='adminMypage/adminUserForm.jsp'">마이페이지</button>
		<%} else { %>
			<button id="mypage" onclick="window.location='userMypage/userMyPage.jsp'">마이페이지</button>
		<%}
		}
		if(checkID == 2) { %><%--— 사업자 일 때 —--%>
			<button id="mypage" onclick="window.location='memberMypage/memberMyPage.jsp'">마이페이지</button>
	<%}%>	
		<button id="signout" onclick="window.location='logout.jsp'">로그아웃</button>
<%}%>

		</div>
	</div>
  <div id="section" style="height:100%;padding:0;">
  	<div class="box"></div>
		<div id="main_wrap">
			<form id="main_form" class="main_form" action="hotelList.jsp?sub=1" method="post" name="searchForm" onsubmit="return check();">
				<div class="search_bar">
					<div id="location" class="select-box">
					  <div class="select-box_current" tabindex="1">
				  	<%
				  		for (int i = 0; i < area.length; i++) { 
				  		%>
				  			<div class="select-box_value">
				      		<input class="select-box_input" type="radio" id="<%= i %>" value="<%= area[i] %>" name="hotel_area" <% if (area[i].equals(hotel.getHotel_area())) {
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
					  <%}
					  %>
					  </ul>
					</div>
					
					<div class="double">
						<input id="check_in" class="check_date" type="text" name="check_in" value="<%= hotel.getCheck_in() %>" />
						<input id="check_out" class="check_date" type="text" name="check_out" value="<%= hotel.getCheck_out() %>" />
					</div>
	
					<div id="pet" class="select-box">
					  <div class="select-box_current" tabindex="1">
					    <% for (int i = 0; i < petType.length; i++) { %>
					  		 <div class="select-box_value">
							      <input class="select-box_input" type="radio" id="pet_<%=i%>" value="<%=i%>" name="pet_type" <% if (i == hotel.getPet_type()) {
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
					<div class="search_btn_wrap" style="margin-left:10px;">
						<button class="search_btn"></button>
					</div>
				</div>
				
	
				<div class="inp_wrap">
					<div class="paid sub">
						<p>유료 서비스</p>
						<input class="inp-cbx" id="paid_bath" type="checkbox" name="paid_bath" value="1"/>
						<label class="cbx" for="paid_bath"><span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg></span><span>목욕서비스</span></label>
						<input class="inp-cbx" id="paid_beauty" type="checkbox" name="paid_beauty" value="1"/>
						<label class="cbx" for="paid_beauty"><span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg></span><span>미용서비스</span></label>
						<input class="inp-cbx" id="paid_medi" type="checkbox" name="paid_medi"  value="1"/>
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
						<input class="inp-cbx" id="util_pool" type="checkbox" name="util_pool" value="1"/>
						<label class="cbx" for="util_pool"><span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg></span><span>수영장</span>
						</label>
						<input class="inp-cbx" id="util_ground" type="checkbox" name="util_ground" value="1"/>
						<label class="cbx" for="util_ground"><span>
						    <svg width="12px" height="10px">
						      <use xlink:href="#check"></use>
						    </svg></span><span>운동장</span>
						</label>
						<input class="inp-cbx" id="util_parking" type="checkbox" name="util_parking" value="1"/>
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
						<input class="inp-cbx" id="pet_big" type="checkbox" name="pet_big" value="1"/>
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
				</div>
			</form>
			<div class="push"></div>
			
			
			<div class="list_wrap">
				<ul class="hotel_list">
				<% if(count == 0) { %>
							<p class="empty">조건에 해당하는 호텔이 없습니다.</p>
				<%} else {
					for(int i = 0; i < hotelList.size(); i++) {
						HotelDTO article = (HotelDTO)hotelList.get(i);
						  if (!hotelList.contains(hotelList.get(i))) {
							  hotelList.add(hotelList.get(i));
               }
					%>
					
					<li>
						<div class="card_wrapper">
					    <div class="product-img">
					      <%if(article.getImg() != null){%>
										<img src="../anitel/save/<%=article.getImg()%>" width="50%"/>
								<%}else{ %>
										<img src="../anitel/save/default.png"/>
								<%} %>
					    </div>
					    <div class="hotel_info">
					      <div class="name">
					        <h1><%=article.getHotel_name() %></h1>
					      </div>
					      <div class="intro">
									<h2><%=article.getHotel_intro() %></h2>
								</div>
								<div class="icon_wrap">
<%									if(article.getUtil_pool().equals("1")) { %>
											<div class="icon">
												<img src = "imgs/swim.png" />
												<span>수영장</span>
											</div>
<%									} %>
<%									if(article.getUtil_ground().equals("1")) { %>
											<div class="icon">
												<img src = "imgs/park.png" />
												<span>운동장</span>
											</div>
<%									} %>
<%									if(article.getUtil_parking().equals("1")) { %>
											<div class="icon">
												<img src = "imgs/parking.png" />
												<span>무료주차</span>
											</div>
<%									} %>
<%									if(article.getPaid_bath().equals("1")) { %>
											<div class="icon">
												<img src = "imgs/bath.png" />
												<span>목욕서비스</span>
											</div>
<%									} %>
<%									if(article.getPaid_beauty().equals("1")) { %>
											<div class="icon">
												<img src = "imgs/beauty.png" />
												<span>미용서비스</span>
											</div>
<%									} %>
<%									if(article.getPaid_medi().equals("1")) { %>
											<div class="icon">
												<img src = "imgs/medi.png" />
												<span>동물병원</span>
											</div>
<%									} %>
								</div>
									<%--
									대형견 : <%=article.getPet_big() %><br /> --%>
								
					      <div class="product-price">
					        <p>1 day <span><%=article.getD_fee() %></span>won</p>
					      </div>
				        <div class="btn">
									<button onclick="window.location='hotelDetail.jsp?memId=<%=article.getId()%>&hotel_area=<%=hotel.getHotel_area()%>&check_in=<%=hotel.getCheck_in()%>&check_out=<%=hotel.getCheck_out()%>&pet_type=<%=hotel.getPet_type()%>'">예약하기</button>
								</div>
					    </div>
					  </div>
		
						<%} %>
						</li>
				<%	} %>
				</ul>
			</div>	
		</div>
		

  </div>
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
	<div id="footer">
		<img src="imgs/logo2.png" width=100px; height=50px;>
		<p>
			평일 10:00 - 17:00 | anitel@anitel.com <br /> <span	id="info_text_btn">이용약관 </span> | <span id="tos_text_btn">취소정책
			</span> | <span id="info_text_btn"><a href="board/list.jsp?categ=1" style="color:#fff;">1:1문의 </a></span><br> COPYRIGHT 콩콩이 ALLRIGHT Reserved.
		</p>
	</div>
</div>
</body>
</html>