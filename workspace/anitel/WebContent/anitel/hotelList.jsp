<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
  <link rel="stylesheet" href="style/search.css">
  <link rel="stylesheet" href="style/init.css">		
  <link rel="stylesheet" href="style/datepicker.min.css">
  <script src="js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" src="js/main.js"></script>
 	<script src="js/datepicker.min.js"></script>
 	<script src="js/datepicker.ko.js"></script>
	<title>리스트페이지</title>
</head>
<% request.setCharacterEncoding("UTF-8");
String hotel_area = request.getParameter("hotel_area");
String check_in = request.getParameter("check_in");
String check_out = request.getParameter("check_out");
String pet_type = request.getParameter("pet_type");
System.out.println("지역 : " + hotel_area + " / 체크인 : " + check_in + " / 체크아웃 : " + check_out + " / 동물 종류 : " + pet_type);
%>
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
  <div id="section">
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