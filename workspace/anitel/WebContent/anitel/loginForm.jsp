<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
 	<link rel="stylesheet" href="style/reset.css">
  <link rel="stylesheet" href="style/style.css">
  <title>login</title>
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

<script>
function classChange(el) {
	var user = document.getElementById('userLogin'); 
	var mem = document.getElementById('memberLogin'); 
	var btn = document.getElementById('btn_login');
	
	if(user == el) {
		el.classList.add('show');
		mem.classList.remove('show');
		btn.classList.replace('mem','user');
	} else {
		el.classList.add('show');
		user.classList.remove('show');
		btn.classList.replace('user', 'mem');
	}
	
}

 function checkForm(btn) {
		var btn = document.getElementById('btn_login');
		if(btn.classList.contains('user')) {
			submitForm();
		} else if(btn.classList.contains('mem')) {
			submitForm();
		}
	}

function submitForm() {
	var btn = document.getElementById('btn_login');
	if(btn.classList.contains('user')) {
	 	var result = valueCheck();
		if(result == true) {
			document.frm.action = "userLoginPro.jsp";
			document.frm.submit();
		 }
	} else if(btn.classList.contains('mem')) {
		var result = valueCheck();
		if(result == true) {
			document.frm.action = "memberLoginPro.jsp";
			document.frm.submit();
		}
	}
}

function valueCheck() {
	if (!document.frm.id.value) {
        alert("아이디를 입력해 주십시오.");
        document.frm.id.focus();
        return false;
  }
 
  if (!document.frm.pw.value) {
      alert("비밀번호를 입력해 주십시오.");
      document.frm.pw.focus();
      return;
  }
  return true;
}

window.onload = function() {
	var signup = document.getElementById('btn_signIn');
	
  document.getElementById('userLogin').onclick = function() {
    classChange(this);
    signup.innerHTML = '회원가입';
		signup.setAttribute( 'href', 'signInUserForm.jsp' );
  };
  document.getElementById('memberLogin').onclick = function() {
    classChange(this);
    signup.innerHTML = '사업자회원가입';
		signup.setAttribute( 'href', 'signInMemberForm.jsp' );
  };
} 
</script>
<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='main.jsp'">
			<img src="imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='board/list.jsp?categ=0'">공지사항</button>
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='LoginForm.jsp'">로그인</button>
		</div>
	</div>	
  <div id="section">
     <h1 align="center">로그인</h1>
     <br />
     <form class="login_wrap" method="post" id="frm" name="frm">
       <div class="sel_wrap">
         <div id="userLogin" class="login show">
           일반 회원
         </div>
         <div id="memberLogin" class="login">
           사업자 회원
         </div>
       </div>
       <div class="input_wrap">
         <input type="text" placeholder="아이디" name="id" class="idInput input"/>
         <input type="password" placeholder="비밀번호" name="pw" class="pwInput input" />			
       </div>
       <div class="btn_wrap">
         <button id="btn_login" class="btn_login user" onclick="checkForm(this)">로그인</button>
         <div class="signIn_wrap" style="height: 20px; background-color:#eee;"><a id="btn_signIn" href="signInUserForm.jsp">회원가입</a></div>
         <label for="auto">
           <input type="checkbox" name="auto" value="1" id="auto" />자동 로그인
         </label>
       </div>
     </form>
   </div>
 	<div id="footer">
	 <img src="imgs/logo2.png" width=100px; height=50px;>
	 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
	 이용약관 | 취소정책 | 1:1문의 <br/>
		COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
 </div>
</body>
</html>
