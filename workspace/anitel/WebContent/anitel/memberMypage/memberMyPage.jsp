<%@page import="anitel.model.MemberDAO"%>
<%@page import="anitel.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>마이페이지(사업자회원)</title>
   	<link rel="stylesheet" href="../style/style.css">
		<link rel="stylesheet" href="../style/reset.css">
    <style>
		#my_modal {
			display: none;
			width: 500px;
			padding: 20px 60px 40px 60px;
			background-color: #fefefe;
			border: 1px solid #888;
			border-radius: 3px;
      	}
	  	#my_modal .modal_close_btn {
			position: absolute;
			bottom: 10px;
			left : 50%;    
     	}
     	#popup_open_btn{
     		background-color:#FFA742;
	      	color:white;
	      	border: none;
	      	border-radius: 6px;
	      	width: 180px;
	      	height:40px;
      	}
      	#popup_open_btn:hover{
      	background-color:#FF822B;
      	color:#ffffff;
      	}
    </style>
  </head>
  
<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid") == null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ 
	// 해줘야 하는것
	// 1. 세션아이디 꺼내서 사업자 회원 정보 세팅하기
	// 2. dao에 아이디 집어넣고 아이디, 성명, 연락처, 이메일 집어넣기

	String id = (String)session.getAttribute("sid");
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO member = dao.getMember(id);
	System.out.println("member id : " + member.getId());
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
					    </ul>
					  </nav>
					</div>
				</div>
      </div>
      
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      <div id="section" style="padding-left:15%; margin-left:40px;">
        <h1><%= member.getMember_name() %>님의 회원정보</h1>
      	<br/>
      	<table>
      		<tr>
      			<td width = 200><h3>아이디</h3></td>
      			<td width = 800><h3><%= member.getId() %></h3></td>
      		</tr>
      		<tr>
      			<td><h3>성명</h3></td>
      			<td><h3><%= member.getMember_name() %></h3></td>
      		</tr>
      		<tr>
      			<td><h3>전화번호</h3></td>
      			<td><h3><%= member.getMember_phone() %></h3></td>
      		</tr>
      		<tr>
      			<td><h3>E-Mail</h3></td>
      			<td><h3><%= member.getMember_email() %></h3></td>
      		</tr>
      	</table>
      	<br/>
      		<%-- <input type="button" id="popup_open_btn" value="회원정보 수정"/>&emsp;--%>
			<input type="button" value="회원정보 수정" onclick="popupOpen()"/>&emsp;
			<input type="button" value="비밀번호 변경" onclick="window.location='memberModifyPwForm.jsp?id=<%=member.getId()%>'"/>&emsp; 
			<br/><br/>
      </div>
      
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
	<div id="footer">
      <img src="../imgs/logo2.png" width=100px; height=50px;>
      <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
      	이용약관 | 취소정책 | 1:1문의 <br/>
      	COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>  			
    </div>
</div>
    <div id="my_modal" align="center">
    	<h5>회원정보 변경을 위하여 비밀번호를 입력해주세요</h5>
			<input type="password" name="member_pw" /><br/>
			<button class="modal_close_btn" onclick="submitForm(<%=member.getId()%>)" id="popup_close_btn">확인</button><br/>
    </div>
</body>
<%	} %>
<script>
	function modal(id) {
		var zIndex = 9999;
		var modal = document.getElementById(id);
		// 모달 div 뒤에 희끄무레한 레이어
		var bg = document.createElement('div');
		bg.setStyle({
			position: 'fixed',
			zIndex: zIndex,
			left: '0px',
			top: '0px',
			width: '100%',
			height: '100%',
			overflow: 'auto',
			// 레이어 색 변경
			backgroundColor: 'rgba(0,0,0,0.4)'
		});
		document.body.append(bg);

  		// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
		modal.querySelector('.modal_close_btn').addEventListener('click', function() {
			bg.remove();
			modal.style.display = 'none';
		});

		modal.setStyle({
			position: 'fixed',
			display: 'block',
			boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

 			// 시꺼먼 레이어 보다 한칸 위에 보이기
			zIndex: zIndex + 1,

			// div center 정렬
			top: '50%',
			left: '50%',
			transform: 'translate(-50%, -50%)',
			msTransform: 'translate(-50%, -50%)',
			webkitTransform: 'translate(-50%, -50%)'
		});
	}

	// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
	Element.prototype.setStyle = function(styles) {
		for (var k in styles) this.style[k] = styles[k];
		return this;
	};

	document.getElementById('popup_open_btn').addEventListener('click', function() {
		// 모달창 띄우기
		modal('my_modal');
	});
	
	function submitForm(id) {
		var btn = document.getElementById('popup_close_btn');
		document.modify.action = "memberModifyPro.jsp?id=" + id;
		document.modify.submit();
	}
	
	function popupOpen(){
		var popUrl = "../popupForm.jsp?pop=7";
		var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}
</script>
</html>