<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="style/style.css">
  <link rel="stylesheet" href="style/init.css">	
  <title>Document</title>
</head>
<body>
  <div id="jb-container">
    <div id="jb-header">
			<img src="imgs/logo.jpg" alt="로고" class="logo" align="left"/>
    </div>
    <div id="jb-content">
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
    <div id="jb-footer">
      <p>Copyright</p>
    </div>
  </div>
</body>
</html>
