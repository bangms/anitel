<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입 선택</title>
  <link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
  <link rel="stylesheet" href="style/init.css">	
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
<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='main.jsp'">
			<img src="imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='board/list.jsp?categ=0'">공지사항</button>
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='loginForm.jsp'">로그인</button>
		</div>
	</div>	
  <div id="section">
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