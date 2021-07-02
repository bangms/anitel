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
	if(session.getAttribute("sid") == null){ 
%>
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
  <div id="section">
		<div id="main_wrap">
	<form>
		<table align="center">
			<tr>
				<td><select name="hotel_area">
						<option value="서울">서울</option>
						<option value="부산">부산</option>
						<option value="대구">대구</option>
						<option value="인천">인천</option>
						<option value="경기">경기</option>
						<option value="광주">광주</option>
						<option value="대전">대전</option>
						<option value="울산">울산</option>
						<option value="경상도">경상도</option>
						<option value="전라도">전라도</option>
						<option value="제주도">제주도</option>
						<option value="충청도">충청도</option>
						<option value="강원도">강원도</option>
					</select></td>
				<td><input type="date" name="check_in" value="yyyy-mm-dd" /></td>
				<td><input type="date" name="check_out" value="yyyy-mm-dd" /></td>
				<td>
					<select name="pet_type">
						<option value="0">기타</option>
						<option value="1">강아지</option>
						<option value="2">고양이</option>
					</select>
				</td>
				<td>
				<a href="hotelList.jsp"> <img src="imgs/search.png" width="25px" height="25px"></a> 
				</td>
			</tr>
		</table>
	</form>
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
<%}else{  // 세션 속성 있다 == 로그인함 %>
 <body>
<div id="container">
	<div id="header">
		<div id="logo">
			<img src="imgs/logo.jpg" width="200px" height="100px">
		</div>
		<div id="button">
			 <h3> <%= session.getAttribute("sid") %> 님 환영합니다. </h3> 
			<button id="mypage" onclick="window.location='mypage.jsp'">마이페이지</button>
			<button id="signout" onclick="window.location='logout.jsp'">로그아웃</button>
			<button id="qna" onclick="window.location='.jsp'">공지사항</button>
		</div>
	</div>	
  <div id="section">
		<div id="main_wrap">
	<form>
		<table align="center">
			<tr>
				<td><select name="hotel_area">
						<option value="서울">서울</option>
						<option value="부산">부산</option>
						<option value="대구">대구</option>
						<option value="인천">인천</option>
						<option value="경기">경기</option>
						<option value="광주">광주</option>
						<option value="대전">대전</option>
						<option value="울산">울산</option>
						<option value="경상도">경상도</option>
						<option value="전라도">전라도</option>
						<option value="제주도">제주도</option>
						<option value="충청도">충청도</option>
						<option value="강원도">강원도</option>
					</select></td>
				<td><input type="date" name="check_in" value="yyyy-mm-dd" /></td>
				<td><input type="date" name="check_out" value="yyyy-mm-dd" /></td>
				<td><select name="pet_type">
						<option value="0">기타</option>
						<option value="1">강아지</option>
						<option value="2">고양이</option>
					</select>
				</td>
				<td>
				<a href="hotelList.jsp"> <img src="imgs/search.png" width="25px" height="25px"></a> 
				</td>
			</tr>
		</table>
	</form>
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
<%}%>
</html>