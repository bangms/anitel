<%@page import="anitel.model.UsersDTO"%>
<%@page import="anitel.model.UsersDAO"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>마이페이지(일반회원) - 비밀번호 변경</title>
 </head>
  
<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="loginForm.jsp";
		</script>
<%	}else{ 
	//String id = (String)session.getAttribute("sid");
	String id = (String)request.getParameter("id");
	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO user = dao.getuser(id);
%>

<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='../main.jsp'">
			<img src="../imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='../board/list.jsp?categ=0'">공지사항</button>
			<button id="mypage" onclick="window.location='userMyPage.jsp'">마이페이지</button>
			<button id="signout" onclick="window.location='../logout.jsp'">로그아웃</button>
		</div>
	</div>	

	<!-- 여기서부터 사이드바 입니다.  -->
		<div id="sidebar">
      	<h1 class="menu_name">마이페이지</h1>
        <div class="sidebar_menu_wrap">
					<div class="nav-wrap">
					  <nav class="main-nav" role="navigation">
					    <ul class="unstyled list-hover-slide">
					      <li class="menu"><a href="userMyReserve.jsp">나의 예약 현황</a></li>
						    <li class="menu"><a href="userMyPage.jsp">나의 정보</a></li>
						    <li class="menu"><a href="userQnA.jsp">나의 Q&A</a></li>
						    <li class="menu"><a href="userReview.jsp">나의 후기</a></li>
					    </ul>
					  </nav>
					</div>
				</div>
      </div>
      
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      <div id="section" style="padding-left:15%; margin-left:40px;">
        <h1><%= user.getUser_name() %>님의 회원정보 수정</h1>
      	<hr align="left" width=700 color="black">
      	<br/>
      	<form action="userModifyPwPro.jsp?id=<%=user.getId()%>" method="post">
      	<table>
      		<tr height = 50>
      			<td width = 250><h3>현재 사용중인 비밀번호</h3></td>
      			<td width = 750>
      				<input type="text" name="user_pw_now" autofocus />
      			</td>
      		</tr>
      		<tr height = 50>
      			<td><h3>변경할 비밀번호</h3></td>
      			<td>
      				<input type="text" name="user_pw" />
      			</td>
      		</tr>
      		<tr height = 50>
      			<td><h3>변경할 비밀번호 재입력</h3></td>
      			<td>
      				<input type="text" name="user_pw2" />
      			</td>
      		</tr>
      	</table>
      	<br/>
			<input type="submit" value="비밀번호 변경"/>&emsp;
			<input type="button" value="변경 취소" onclick="window.location='userMyPage.jsp'"/>&emsp; 
		<br/><br/>
	   </form>
     </div>
      
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
      <div id="footer">
      <img src="../imgs/logo2.png" width=100px; height=50px;>
      <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
      이용약관 | 취소정책 | 1:1문의 <br/>
      COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
      			
      </div>
    </div>
</body>
<%	} %>
</html>
