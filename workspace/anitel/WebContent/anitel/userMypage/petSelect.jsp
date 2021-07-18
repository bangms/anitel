<%@page import="java.util.List"%>
<%@page import="anitel.model.PetDTO"%>
<%@page import="anitel.model.PetDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>펫 선택</title>
	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%-- jquery 라이브러리 추가 --%>
</head>
<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){ %>
<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ 

		String id = (String)session.getAttribute("sid");
		PetDAO dao = PetDAO.getInstance();
		List Petlist = dao.getPetName(id); 
		PetDTO pet = null;
%>
<body>
	<div id="container">
		<div id="header">
			<div id="logo" onclick="window.location='../main.jsp'">
				<img src="../imgs/logo.jpg" width="200px" height="100px" alt="logo">
			</div>
			<div id="button">
				<button id="notice"
					onclick="window.location='../board/list.jsp?categ=0'">공지사항</button>
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
				<h1>내 반려동물의 정보</h1>
				<hr align="left" width=800 color="black">
				<br />
				<table>
					<tr>
						<td width=150>
							<h3>이름</h3>
						</td>
						<td><select id="pet_num" name="pet_num">
								<%for(int i = 0; i < Petlist.size(); i++){
								PetDTO petname = (PetDTO)Petlist.get(i);
								%>
								<option value="<%=petname.getPet_num()%>"><%=petname.getPet_name()%></option>
								<%}%>
						</select> <input type="button" id="select" value="선택" onclick="popupOpen()" />&emsp;

						</td>
					</tr>
				</table>
				<br /> <input type="button" value="추가하기"
					onclick="window.location='petAddForm.jsp'" />&emsp; <input
					type="button" value="뒤로가기"
					onclick="window.location='userMyPage.jsp'" />&emsp; <br />
				<br />
			</div>

			<!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->
			<div id="footer">
				<img src="../imgs/logo2.png" width=100px; height=50px;>
				<p>
					평일 10:00 - 17:00 | anitel@anitel.com <br /> 이용약관 | 취소정책 | 1:1문의 <br />
					COPYRIGHT 콩콩이 ALL RIGHT Reserved.
				</p>

			</div>
		</div>
</body>
<script type="text/javascript">
function popupOpen(){
	var pet_num_sel = $("#pet_num").val();
	//console.log(pet_num_sel);
	var popUrl = "../popupForm.jsp?pop=9&pet_num=" + pet_num_sel;	//팝업창에 출력될 페이지 URL
	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);

	}
</script>
<%} %>
</html>
