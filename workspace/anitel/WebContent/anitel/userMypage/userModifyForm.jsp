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
	if(session.getAttribute("sid")==null){ 	%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="/anitel/anitel/userLoginForm.jsp";
		</script>
<%	}else{ 
	String id = (String)session.getAttribute("sid");
	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO users = dao.getuser(id);
	System.out.println(users);
	System.out.println(users.getUser_name());
%>
<script type="text/javascript">
function popupOpen(){
	var popUrl = "/anitel/anitel/popupForm.jsp?pop=2";	//팝업창에 출력될 페이지 URL
	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);

	}
</script>


<body>

    <div id="container">
    
 <!-- 여기서부터 헤더  입니다.  -->
 	
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
      
	<div id="main">
	
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
      
    <div id="content">
		    <h1><%= users.getUser_name() %>님의 회원정보</h1>
      	<hr align="left" width=800 color="black">
      	<br/>
      	<form action="userModifyPro.jsp" method="post">
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
			<input type="submit" value="수정하기"/>&emsp;
			<input type="button" value="취소" onclick="window.location='userMyPage.jsp'"/>&emsp; 
			<button id="withdraw"onclick="popupOpen()">탈퇴하기 </button>
		<br/><br/>	
	   </form>
     </div>
			
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

<%} %>

</html>
