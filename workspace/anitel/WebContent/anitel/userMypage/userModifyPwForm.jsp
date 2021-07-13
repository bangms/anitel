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
			window.location="/anitel/anitel/loginForm.jsp";
		</script>
<%	}else{ 
	//String id = (String)session.getAttribute("sid");
	String id = (String)request.getParameter("id");
	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO user = dao.getuser(id);
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
          <li><a href="/anitel/anitel/userMyPage/userMyReserve.jsp">나의 예약현황</a></li>
          <li><a href="/anitel/anitel/userMyPage/userMyPage.jsp">나의 정보</a></li>
          <li><a href="/anitel/anitel/userMyPage/userQnA.jsp">나의 Q&A</a></li>
          <li><a href="/anitel/anitel/userMyPage/userReview.jsp">나의 후기</a></li>
        </ul>
      </div>
      
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      <div id="content">
        <h1><%= user.getUser_name() %>님의 회원정보 수정</h1>
      	<hr align="left" width=700 color="black">
      	<br/>
      	<form action="/anitel/anitel/userMyPage/userModifyPwPro.jsp?id=<%=user.getId()%>" method="post">
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
			<input type="button" value="변경 취소" onclick="window.location='/anitel/anitel/userMyPage/userMyPage.jsp'"/>&emsp; 
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
