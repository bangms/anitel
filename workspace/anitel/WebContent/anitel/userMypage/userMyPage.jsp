<%@page import="anitel.model.UsersDAO"%>
<%@page import="anitel.model.UsersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일반회원 마이페이지</title>
  <link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
	<link rel="stylesheet" href="../style/mypage.css">
</head>
<%
    String strReferer = request.getHeader("referer");
    
    if(strReferer == null){
   %>
    <script language="javascript">
     alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다.\n\n정상적인 경로를 통해 다시 접근해 주십시오.");
     document.location.href="../main.jsp";
    </script>
   <%
     return;
    }
   %>
<%
request.setCharacterEncoding("UTF-8");

// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
if (session.getAttribute("sid") == null) {
%>
<script>
	alert("로그인이 필요한 서비스입니다.");
	window.location="../loginForm.jsp";
</script>
<%
} else {

String id = (String) session.getAttribute("sid");
UsersDAO dao = UsersDAO.getInstance();
UsersDTO users = dao.getuser(id);
System.out.println(users.getUser_name());
%>
<script type="text/javascript">
	function popupOpen() {
		var popUrl = "../popupForm.jsp?pop=3"; //팝업창에 출력될 페이지 URL
		var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;"; //팝업창 옵션(optoin)
		window.open(popUrl, "", popOption);

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
				<button id="notice"
					onclick="window.location='../board/list.jsp?categ=0'">공지사항</button>
				<%
				if (session.getAttribute("sid") == null) {
				%>
					<button id="signin" onclick="window.location='../signIn.jsp'">회원가입</button>
					<button id="login" onclick="window.location='../loginForm.jsp'">로그인</button>
				<%
				} else {
				%>
					<button id="mypage" onclick="window.location='userMyPage.jsp'">마이페이지</button>
					<button id="signout" onclick="window.location='../logout.jsp'">로그아웃</button>
				<%}%>

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
								<li class="menu"><a href="userQnA.jsp">나의 QnA</a></li>
								<li class="menu"><a href="userReview.jsp">나의 후기</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>

			<!-- 여기서부터 콘텐츠 화면 입니다.  -->
			<div id="section" style="padding-left: 15%; margin-left: 40px;">
				<div class="info_wrap">
					<h1><%=users.getUser_name()%>님의 회원정보</h1>
					<hr/>
					<div class="table_wrap">
						<div class="sub">아이디</div>
						<div class="con"><%=users.getId()%></div>
					</div>
					
					<div class="table_wrap">
						<div class="sub">성명</div>
						<div class="con"><%=users.getUser_name()%></div>
					</div>
					
					<div class="table_wrap">
						<div class="sub">전화번호</div>
						<div class="con"><%=users.getUser_phone()%></div>
					</div>
					
					<div class="table_wrap">
						<div class="sub">E-Mail</div>
						<div class="con"><%=users.getUser_email()%></div>
					</div>
				</div>
				<div class="btn_wrap">
					<input type="button" class="btn" value="내정보 수정" onclick="popupOpen()" />&emsp;
					<input type="button" class="btn" value="비밀번호 변경" onclick="window.location='userModifyPwForm.jsp?id=<%=users.getId()%>'" />&emsp;
					<input type="button" class="btn" value="반려동물 정보수정" onclick="window.location='petSelect.jsp'" />&emsp;
				</div>
			</div>

		<!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->
		<div id="footer">
			<img src="../imgs/logo2.png" width=100px; height=50px;>
			<p>
				평일 10:00 - 17:00 | anitel@anitel.com <br /> <span	id="info_text_btn">이용약관 </span> | <span id="tos_text_btn">취소정책
				</span> | <span id="info_text_btn"><a href="../board/list.jsp?categ=1" style="color:#fff;">1:1문의 </a></span><br> COPYRIGHT 콩콩이 ALLRIGHT Reserved.
			</p>
		</div>
	</div>

</body>
<%
}
%>
</html>
