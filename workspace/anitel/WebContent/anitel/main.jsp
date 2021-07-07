<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>메인</title>
  	<link rel="stylesheet" href="style/style.css">
	<link rel="stylesheet" href="style/reset.css">
	<link rel="stylesheet" href="style/search.css">
	<link rel="stylesheet" href="style/datepicker.min.css">
   	<script src="js/jquery-3.1.1.min.js"></script>
   	<script src="js/datepicker.min.js"></script>
   	<script src="js/datepicker.ko.js"></script>
 		<script type="text/javascript" src="js/search.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function(){
	//두개짜리 제어 연결된거 만들어주는 함수
	datePickerSet($("#check_in"), $("#check_out"), true); //다중은 시작하는 달력 먼저, 끝달력 2번째
	
});
</script>
<style>
	
/* 메인페이지 height 100% 옵션주기 위한 div */
.box {
	height: 140px;
}

.main_form {
	width: 80%;
	display: inline-flex;	
	position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

/* 배경 이미지 */
.bg_wrap {
	position: fixed;
  left: 0;
  z-index: -1;
  padding-bottom: -140px;
  
}
.bg {
	background-color: rgba(0,0,0,0.4);
	width:100%;
	height:100%;
	position: fixed;
  left: 0;
}

</style>
<body style="overflow: hidden">
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='main.jsp'">
			<img src="imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='board/list.jsp?categ=0'">공지사항</button>
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
			<div class="bg_wrap">
				<div class="bg"></div>
	  		<img src="imgs/bg.jpg" width="100%" />
	  	</div>
			<form id="main_form" class="main_form" action="hotelList.jsp" method="post" name="searchForm" onsubmit="return check()">
				<div id="location" class="select-box">
				  <div class="select-box_current" tabindex="1">
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="0" value="서울" name="hotel_area" checked="checked"/>
				      <p class="select-box_input-text">서울</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="1" value="부산" name="hotel_area" />
				      <p class="select-box_input-text">부산</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="2" value="대구" name="hotel_area" />
				      <p class="select-box_input-text">대구</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="3" value="인천" name="hotel_area"/>
				      <p class="select-box_input-text">인천</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="4" value="경기" name="hotel_area"/>
				      <p class="select-box_input-text">경기</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="5" value="광주" name="hotel_area"/>
				      <p class="select-box_input-text">광주</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="6" value="대전" name="hotel_area" />
				      <p class="select-box_input-text">대전</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="7" value="울산" name="hotel_area" />
				      <p class="select-box_input-text">울산</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="8" value="경상도" name="hotel_area" />
				      <p class="select-box_input-text">경상도</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="9" value="전라도" name="hotel_area" />
				      <p class="select-box_input-text">전라도</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="10" value="제주도" name="hotel_area" />
				      <p class="select-box_input-text">제주도</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="11" value="충청도" name="hotel_area" />
				      <p class="select-box_input-text">충청도</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="12" value="강원도" name="hotel_area" />
				      <p class="select-box_input-text">강원도</p>
				    </div><img class="select-box_icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box_list">
				    <li>
				      <label class="select-box_option" for="0" aria-hidden="aria-hidden">서울</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="1" aria-hidden="aria-hidden">부산</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="2" aria-hidden="aria-hidden">대구</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="3" aria-hidden="aria-hidden">인천</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="4" aria-hidden="aria-hidden">경기</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="5" aria-hidden="aria-hidden">광주</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="6" aria-hidden="aria-hidden">대전</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="7" aria-hidden="aria-hidden">울산</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="8" aria-hidden="aria-hidden">경상도</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="9" aria-hidden="aria-hidden">전라도</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="10" aria-hidden="aria-hidden">제주도</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="11" aria-hidden="aria-hidden">충청도</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="12" aria-hidden="aria-hidden">강원도</label>
				    </li>
				  </ul>
				</div>
				
				<div class="double">
					<input id="check_in" class="check_date" type="text" name="check_in" placeholder="체크인 날짜" />
					<input id="check_out" class="check_date" type="text" name="check_out" placeholder="체크아웃 날짜" />
				</div>

				<div id="pet" class="select-box">
				  <div class="select-box_current" tabindex="1">
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="pet_0" value="0" name="pet_type" checked="checked"/>
				      <p class="select-box_input-text">강아지</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="pet_1" value="1" name="pet_type"/>
				      <p class="select-box_input-text">고양이</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="pet_2" value="2" name="pet_type"/>
				      <p class="select-box_input-text">기타</p>
				    </div><img class="select-box_icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box_list">
				    <li>
				      <label class="select-box_option" for="pet_0" aria-hidden="aria-hidden">강아지</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="pet_1" aria-hidden="aria-hidden">고양이</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="pet_2" aria-hidden="aria-hidden">기타</label>
				    </li>
				  </ul>
				</div>
	
				<input type="submit" width="25px" height="25px" class="search_btn"/>
			</form>
		<div class="push"></div>
	</div>
 </div>
   <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
		<div id="footer" style="margin-top:-120px">
			 <img src="imgs/logo2.png" width=100px; height=50px;>
			 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
			 이용약관 | 취소정책 | 1:1문의 <br/>
				COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
		</div>
	</div>
</body>
</html>