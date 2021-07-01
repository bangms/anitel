<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
  <link rel="stylesheet" href="style/init.css">	
  <title>login</title>
</head>
<body>
<div id="container">
	<div id="header">
		<div id="logo">
			<img src="imgs/logo.jpg" width="200px" height="100px">
		</div>
		<div id="button">
			<button id="notice">공지사항</button>
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='LoginForm.jsp'">로그인</button>
		</div>
	</div>	
  <div id="section">
     <h1 align="center">로그인</h1>
     <br />
     <div class="login_wrap">
       <div class="sel_wrap">
         <div class="userLogin login">
           일반 회원
         </div>
         <div class="memberLogin login">
           사업자 회원
         </div>
       </div>
       <div class="input_wrap">
         <input type="text" placeholder="아이디" name="id" class="idInput input"/>
         <input type="password" placeholder="비밀번호" name="pw" class="pwInput input" />			
       </div>
       <div class="btn_wrap">
         <button class="btn_login" onclick="window.location='userLoginPro.jsp'">로그인</button>
         <button class="btn_memsignIn" onclick="window.location='signInMemberForm.jsp'">사업자 회원가입</button>
         <label for="auto">
           <input type="checkbox" name="auto" value="1" id="auto" />자동 로그인
         </label>
       </div>
     </div>
   </div>
 	<div id="footer">
	 <img src="imgs/logo2.png" width=100px; height=50px;>
	 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
	 이용약관 | 취소정책 | 1:1문의 <br/>
		COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
 </div>
 <script>
 
 </script>
</body>
</html>
