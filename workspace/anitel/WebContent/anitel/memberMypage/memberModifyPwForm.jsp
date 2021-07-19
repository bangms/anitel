<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>마이페이지(사업자회원) - 비밀번호 변경</title>
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
<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){ %>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ 
	String id = (String)session.getAttribute("sid");
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO member = dao.getMember(id);
%>
<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='../main.jsp'">
			<img src="../imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='../board/list.jsp?categ=0'">공지사항</button>
			<button id="mypage" onclick="window.location='memberMyPage.jsp'">마이페이지</button>
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
					      <li class="menu"><a href="memberMyPage.jsp">내 정보</a></li>
						    <li class="menu"><a href="memberHInfo.jsp">호텔 정보</a></li>
						    <li class="menu"><a href="memberBookingModifyForm.jsp">호텔 예약 관리</a></li>
						    <li class="menu"><a href="memberQna.jsp">호텔 QnA 관리</a></li>
						    <li class="menu"><a href="memberReview.jsp">호텔 후기 관리</a></li>
					    <li class="menu"><a href="member1_1.jsp">1:1문의</a></li>
					    </ul>
					  </nav>
					</div>
				</div>
      </div>
      
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      <div id="section" style="padding-left:15%; margin-left:40px;">
     	 <div class="info_wrap">
        <h1><%= member.getMember_name() %>님의 회원정보 수정</h1>
        <hr/>
      	<form action="memberModifyPwPro.jsp" method="post">
      		<div class="table_wrap">
						<div class="sub">현재 사용중인 비밀번호</div>
						<div class="con">
							<input type="text" name="member_pw_now" autofocus />
						</div>
					</div>
      		<div class="table_wrap">
						<div class="sub">변경할 비밀번호</div>
						<div class="con">
							<input type="text" name="member_pw" />
						</div>
					</div>
					<div class="table_wrap">
						<div class="sub">변경할 비밀번호 재입력</div>
						<div class="con">
							<input type="text" name="member_pw2" />
						</div>
					</div>
					
					<div class="btn_wrap">
						<input type="submit" class="btn" value="비밀번호 변경"/>&emsp;
						<input type="button" class="btn" value="변경 취소" onclick="window.location='memberMyPage.jsp'"/>&emsp; 
	  	 		</div>
	  	 </form>
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
<%	} %>
</html>
