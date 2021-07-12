<%@page import="anitel.model.UsersDAO"%>
<%@page import="anitel.model.UsersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정 폼</title>

</head>
<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")!=null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="/anitel/anitel/userLoginForm.jsp";
		</script>
<%	}else{ 
	// 해줘야 하는것
	// 1. 세션아이디 꺼내서 사업자 회원 정보 세팅하기
	// 2. dao에 아이디 집어넣고 아이디, 성명, 연락처, 이메일 집어넣기

	//String id = (String)session.getAttribute("sid");
	String id = "java04";			
	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO users = dao.getuser(id);
	System.out.println(users);
	System.out.println(users.getUser_name());
%>
<script type="text/javascript">
function popupOpen(){
	var popUrl = "popupForm.jsp?pop=2";	//팝업창에 출력될 페이지 URL
	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);

	}
</script>


<body>

    <div id="container">
    
 <!-- 여기서부터 헤더  입니다.  -->
 	
      <div id="header">
      	<div id="logo">
       		 <img src="imgs/logo.png" width="200px" height="100px">
        </div>
 		<section>
       		 <div id="button">
        		<button id="notice" onclick="window.location='list.jsp'">공지사항</button>
        		<button id="signin" onclick="window.location='signInUserForm.jsp'">회원가입</button>
   	     		<button id="login" onclick="window.location='/anitel/userLoginForm.jsp'">로그인</button>
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
		    <h1><%= users.getUser_name() %>님의 회원정보</h1>
      	<hr align="left" width=800 color="black">
      	<br/>
      	<form action="/anitel/anitel/userMyPage/userModifyPro.jsp" method="post">
	   		<table>
	      			<tr height = 50>
	      				<td width=150><h3>성명</h3></td>
						<td width=800>
							<input type="text" name="user_name" value="<%=users.getUser_name()%>"/>
						</td>
					</tr>
		      		<tr height = 50>
		      			<td width=150><h3>전화번호</h3></td>
		      			<td width=800>
		      				<input type="text" name="user_phone" value="<%=users.getUser_phone()%>"/>
						</td>
					</tr>
		      		<tr height = 50>
      					<td><h3>E-Mail</h3></td>
      					<td>
      						<input type="text" name="user_email" value="<%= users.getUser_email()%>" />
      					</td>
      				</tr>
      		</table>
      	<br/>
			<input type="submit" value="내정보 수정"/>&emsp;
			<input type="button" value="취소" onclick="window.location='/anitel/anitel/userMyPage/userMyPage.jsp'"/>&emsp; 
			<button id="withdraw"onclick="popupOpen()">탈퇴하기 </button>
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

<%} %>

</html>
