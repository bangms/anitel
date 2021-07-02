<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>디테일페이지</title>
	<link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
</head>
<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='main.jsp'">
			<img src="imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice">공지사항</button>
			<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='LoginForm.jsp'">로그인</button>
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
	    <input type="date" name="check_in" value="yyyy-mm-dd" />
	    <input type="date" name="check_out" value="yyyy-mm-dd" />
	    <select name="pet_type">
	      <option value="0">기타</option>
	      <option value="1">강아지</option>
	      <option value="2">고양이</option>
	    </select>
	    <button>검색</button>
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