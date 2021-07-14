<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>마이페이지(사업자회원) - 호텔정보 수정</title>
  </head>
<%	request.setCharacterEncoding("UTF-8");
	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")!=null){ %>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ 
	String id = (String)session.getAttribute("sid");
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO member = dao.getMemberHotel(id);
%>
<body>
	<div id="container">
    
 <!-- 여기서부터 헤더  입니다.  -->
 	
      <div id="header">
      	<div id="logo">
       		 <img src="imgs/logo.png" width="200px" height="100px">
        </div>
 		<section>
       		 <div id="button">
        		<button id="notice">공지사항</button>
        		<button id="signin">회원가입</button>
   	     		<button id="login">로그인</button>
       		 </div>
        </section>
      </div>
      
	<div id="main">
	
	<!-- 여기서부터 사이드바 입니다.  -->
      <div id="sidebar">
        <h1>마이페이지</h1>
        <ul>
          <li>내 정보</li>
          <li>호텔 정보</li>
          <li>호텔 예약 관리</li>
          <li>호텔 QnA 관리</li>
          <li>호텔 후기 관리</li>
        </ul>
      </div>
      
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      <div id="content">
        <h1><%= member.getMember_name() %>님의 호텔관리</h1>
      	<hr align="left" width=800 color="black">
      	<br/>
      	<form action="/anitel/memberMypage/memberHModifyPro.jsp" method="post">
      	<table>
      		<tr height = 50>
      			<td width = 200><h3>호텔 이름</h3></td>
      			<td width = 600>
      				<input type="text" name="hotel_name" value="<%= member.getHotel_name() %>" autofocus />
      			</td>
      		</tr>
      		<tr height = 50>
      			<td><h3>대표자 성명</h3></td>
      			<td>
      				<input type="text" name="hotel_owner" value="<%= member.getHotel_owner() %>"/>
      			</td>
      		</tr>
      		<tr height = 50>
      			<td><h3>호텔 주소</h3></td>
      			<td>
      				<select name="hotel_area">
						<option value="서울" <% if(member.getHotel_area().equals("서울")){%>selected<%} %>>서울</option>
						<option value="부산" <% if(member.getHotel_area().equals("부산")){%>selected<%} %>>부산</option>
						<option value="대구" <% if(member.getHotel_area().equals("대구")){%>selected<%} %>>대구</option>
						<option value="인천" <% if(member.getHotel_area().equals("인천")){%>selected<%} %>>인천</option>
						<option value="경기" <% if(member.getHotel_area().equals("경기")){%>selected<%} %>>경기</option>
						<option value="광주" <% if(member.getHotel_area().equals("광주")){%>selected<%} %>>광주</option>
						<option value="대전" <% if(member.getHotel_area().equals("대전")){%>selected<%} %>>대전</option>
						<option value="울산" <% if(member.getHotel_area().equals("울산")){%>selected<%} %>>울산</option>
						<option value="경상도" <% if(member.getHotel_area().equals("경상도")){%>selected<%} %>>경상도</option>
						<option value="전라도" <% if(member.getHotel_area().equals("전라도")){%>selected<%} %>>전라도</option>
						<option value="제주도" <% if(member.getHotel_area().equals("제주도")){%>selected<%} %>>제주도</option>
						<option value="충청도" <% if(member.getHotel_area().equals("충청도")){%>selected<%} %>>충청도</option>
						<option value="강원도" <% if(member.getHotel_area().equals("강원도")){%>selected<%} %>>강원도</option>
					</select>
      				<input type="text" name="hotel_add" value="<%= member.getHotel_add() %>"/>
      			</td>
      		</tr>
      		<tr height = 50>
      			<td><h3>호텔 전화번호</h3></td>
      			<td>
      				<input type="text" name="hotel_phone" value="<%= member.getHotel_phone() %>"/>
      			</td>
      		</tr>
      		<tr height = 50>
      			<td><h3>사업자 등록번호</h3></td>
      			<td>
      				<input type="text" name="reg_num" value="<%= member.getReg_num() %>"/>
      			</td>
      		</tr>
      	</table>
      	<br/>
			<input type="submit" value="수정내용 저장"/>&emsp;
			<input type="button" value="수정 취소" onclick="window.location='/anitel/memberMypage/memberHInfo.jsp'"/>&emsp; 
		<br/><br/>	
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
<%	} %>
</html>
