<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>디테일페이지</title>
	<link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
	<link rel="stylesheet" href="style/search.css">
	<link rel="stylesheet" href="style/datepicker.min.css">
	<script src="js/jquery-3.1.1.min.js"></script>
	<script src="js/datepicker.min.js"></script>
	<script src="js/datepicker.ko.js"></script>
	<script type="text/javascript" src="js/search.js"></script>
</head>
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
<% request.setCharacterEncoding("UTF-8");
String id = request.getParameter("memId"); // 사업자아이디
String hotel_area = request.getParameter("hotel_area");
String check_in = request.getParameter("check_in");
String check_out = request.getParameter("check_out");
int pet_type = Integer.parseInt(request.getParameter("pet_type"));
System.out.println("지역 : " + hotel_area + " / 체크인 : " + check_in + " / 체크아웃 : " + check_out + " / 동물 종류 : " + pet_type);

String area[] = {"서울", "부산", "대구", "인천", "경기", "광주", "대전", "울산", "경상도", "전라도", "제주도", "충청도", "강원도"};
String petType[] = {"강아지", "고양이", "기타"};
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
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='loginForm.jsp'">로그인</button>
		</div>
	</div>	
  <div id="section" class="detail_wrapper">
	  <p class="hotel_name">
	    <!-- 호텔이름 -->
	    빵야빵야 애견호텔
	  </p>
	  <div class="info_wrapper">
	    <div class="img_wrap">
	      <ul>
	        <li class="main_img"></li>
	        <li></li>
	        <li></li>
	        <li></li>
	        <li></li>
	        <li></li>
	      </ul>
	    </div>
	    <div class="map"></div>
	    <div class="mini_review_wrap">
	      <div>후기</div>
	      <div class="mini_review_txt"></div>
	    </div>
	  </div>
	  <div class="exp_wrap">
	    <div class="util"></div>
	    <div class="paid"></div>
	  </div>
	  
	  <div class="search_wrap">
	    <form id="main_form" class="main_form" action="hotelList.jsp" method="post" name="searchForm" onsubmit="return check();">
			<div class="search_bar">
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
			</div>
		</form>
  </div>
	  
	  <div class="room_wrap">
	    <ul>
	      <li></li>
	      <li></li>
	      <li></li>
	    </ul>
	  </div>
	  <div class="review_wrap board">
	    <p>후기게시판</p>
	    <table class="review">
	      <tr>
	        <td>작성자</td>
	        <td>내용</td>
	      </tr>
	      <tr>
	        <td></td>
	        <td></td>
	      </tr>
	    </table>
	    <button>글쓰기</button>
	  </div>
	  <div class="qna_wrap board">
	    <p>Q&A 게시판</p>
	    <table class="qna">
	      <tr>
	        <td>작성자</td>
	        <td>내용</td>
	      </tr>
	      <tr>
	        <td>삐삐엄마</td>
	        <td>비밀글입니다.</td>
	      </tr>
	    </table>
	    <button>문의하기</button>
	  </div>
  </div>
 	<div id="footer">
	 <img src="imgs/logo2.png" width=100px; height=50px;>
	 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
	 이용약관 | 취소정책 | 1:1문의 <br/>
		COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
 </div>
</body>
</html>