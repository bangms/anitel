<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
</head>
<body>
<div id="container">
	<div id="header">
		<div id="logo">
			<img src="imgs/logo.jpg" width="200px" height="100px">
		</div>
		<div id="button">
			<button id="notice">공지사항</button>
			<button id="signin">회원가입</button>
			<button id="login">로그인</button>
		</div>
	</div>	
	<div id="signup_wrap">
    <h1 align="center">회원가입</h1>
		<div class="box_wrap">
			<p class="txt1"> ANITEL 에 오신 것을 환영합니다! </p>
			<p class="txt2"> 처음오셨나요?<br />
			아래의 버튼을 눌러 간단히 회원가입 하시고 <br />
			ANITEL의 편리한 서비스를 자유롭게 이용해보세요!
			</p>
			<button class="btn_user_signup" onclick="window.location='signInUserForm.jsp'">ANITEL 회원가입</button>
			<p> 혹시 반려동물을 위한 호텔을 경영하고 계신다면?</p>
			<button class="btn_mem_signup" onclick="window.location='signInMemberForm.jsp'">사업자 회원가입</button>
		</div>
   </div>
      
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
		<div id="footer">
			 <img src="imgs/logo2.png" width=100px; height=50px;>
			 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
			 이용약관 | 취소정책 | 1:1문의 <br/>
				COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
			</div>
  </div>
</body>
</html>