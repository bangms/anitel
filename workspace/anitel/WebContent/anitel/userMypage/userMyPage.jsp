<%@page import="anitel.model.BoardDAO"%>
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
</head>
  
<%	request.setCharacterEncoding("UTF-8");
String id = (String)session.getAttribute("sid");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(id == null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="/anitel/userLoginForm.jsp";
		</script>
<%	}else{ 
	// 해줘야 하는것
	// 1. 세션아이디 꺼내서 사업자 회원 정보 세팅하기
	// 2. dao에 아이디 집어넣고 아이디, 성명, 연락처, 이메일 집어넣기

	BoardDAO board = BoardDAO.getInstance();
	// 사업자, 일반회원인지 체크
	int checkID = board.idCk(id);
	System.out.println("아이디 체크 - 사업자면 2, 일반회원이면 1 : " + checkID);
	
	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO users = dao.getuser(id);
	System.out.println(users.getUser_name());
%>
<script type="text/javascript">
function popupOpen(){
	var popUrl = "popupForm.jsp?pop=3";	//팝업창에 출력될 페이지 URL
	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);

	}
</script>

<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='../main.jsp'">
			<img src="../imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='../board/list.jsp?categ=0'">공지사항</button>
<% 	
		if(session.getAttribute("sid") == null){ 
%>
			<button id="signin" onclick="window.location='../signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='../loginForm.jsp'">로그인</button>
			
		<%}else{ %>
			<button id="mypage" onclick="window.location='userMyPage.jsp'">마이페이지</button>
			<button id="signout" onclick="window.location='../logout.jsp'">로그아웃</button>
		<%}%>
		</div>
	</div>	
	<!-- 여기서부터 사이드바 입니다.  -->
		<div id="sidebar">
			<h1>마이페이지</h1>
				<ul>
				   <li><a href="/anitel/userMyPage/userMyReserve.jsp">나의 예약현황</a></li>
				   <li><a href="/anitel/userMyPage/userMyPage.jsp">나의 정보</a></li>
				   <li><a href="/anitel/userMyPage/userQnA.jsp">나의 Q&A</a></li>
				   <li><a href="/anitel/userMyPage/userReview.jsp">나의 후기</a></li>
				 </ul>
      </div>
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
    	<div id="content">
         <h1><%= users.getUser_name() %>님의 회원정보</h1>
      	<hr align="left" width=800 color="black">
      	<br/>
      	
      	<table>
      		<tr height = 50>
      			<td width = 150><h3>아이디</h3></td>
      			<td width = 800><%= users.getId() %></td>
      			
      		</tr>
      			<tr height = 50>
      			<td><h3>성명</h3></td>
      			<td><%= users.getUser_name() %></td>
      		</tr>
      		<tr height = 50>
      			<td><h3>전화번호</h3></td>
      			<td><%= users.getUser_phone() %></td>
      		</tr>
      		<tr height = 50>
      			<td><h3>E-Mail</h3></td>
      			<td><%= users.getUser_email() %></td>
      		</tr>
      	</table><br/>
      		<input type="button" value="내정보 수정"  onclick="popupOpen()"/>&emsp;
			<input type="button" value="비밀번호 변경" onclick="window.location='userModifyPwForm.jsp?id=<%=users.getId()%>'"/>&emsp; 
			<input type="button" value="반려동물 정보수정" onclick="window.location='petinfoModifyForm.jsp'"/>&emsp;
			<br/><br/>
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
<% } %>

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
		document.modify.action = "/anitel/memberMypage/memberModifyPro.jsp?id=" + id;
		document.modify.submit();
		}
</script>
</html>