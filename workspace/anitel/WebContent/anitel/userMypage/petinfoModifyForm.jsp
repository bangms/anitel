
<%@page import="java.util.List"%>
<%@page import="anitel.model.PetDAO"%>
<%@page import="anitel.model.UsersDTO"%>
<%@page import="anitel.model.PetDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>반려동물 수정폼</title>
  <link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
	<link rel="stylesheet" href="../style/search.css">
</head>

<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){%>
<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ 
	String id = (String)session.getAttribute("sid");
	int pet_num = Integer.parseInt(request.getParameter("pet_num"));
	PetDAO dao = PetDAO.getInstance();
	PetDTO pet = dao.getPet(id, pet_num); 
%>

<script type="text/javascript">
function popupOpen(){
	var popUrl = "../popupForm.jsp?pop=8";	//팝업창에 출력될 페이지 URL
	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);
}
function check(){
	if(!checkPetName(PM.pet_name.value)) {
	    return false;
	}
}
function checkExistData(value, dataName) {
    if (value == "") {
        alert(dataName + " 입력해주세요!");
        return false;
    }
    return true;
}
function checkPetName(pet_name) {
    if (!checkExistData(pet_name, "반려동물 이름을"))
        return false;

	var petnameRegExp = /^[가-힣]{2,10}$/;
    if (!petnameRegExp.test(pet_name)) {
        alert("반려동물 이름은 한글만 가능합니다!");
        return false;
    }
    return true; //확인이 완료되었을 때
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
				<h1>
					<%=pet.getPet_name()%>의 정보
				</h1>
				<hr align="left" width=800 color="black">
				<br />
				<form name="PM" action="petinfoModifyPro.jsp" method="post"  onsubmit="return check()">
					<input type="hidden" name="pet_num" value="<%=pet_num%>" />
					<table>
						<tr>
							<td width=150><h3>이름</h3></td>
							<td><input type="text" name="pet_name" style="width: 150px;"
								value="<%= pet.getPet_name()%>" /></td>
						</tr>
						<tr>
							<td width=150><h3>종</h3></td>
							<td><select id="pet_type" name="pet_type">
									<option value="" disabled selected>선택</option>
									<option value="0" <%=0==(pet.getPet_type())? "selected":"" %>>강아지</option>
									<option value="1" <%=1==(pet.getPet_type())? "selected":"" %>>고양이</option>
									<option value="2" <%=2==(pet.getPet_type())? "selected":"" %>>기타동물</option>
							</select> <input type="text" id="pet_etctype" name="pet_etctype"
								value="<%= pet.getPet_etctype() == null ? "" : pet.getPet_etctype() %>"
								style="height: 30px;" placeholder="기타동물 입력란" /></td>
						</tr>
						<tr>
							<td><h3>반려동물 성별</h3></td>
							<td><input type="radio" name="pet_gender" value="1"
								<%=1==(pet.getPet_gender())? "checked":"" %>> 수컷 <input
								type="radio" name="pet_gender" value="0"
								<%=0==(pet.getPet_gender())? "checked":"" %>> 암컷</td>
						</tr>
						<tr>
							<td width=150><h3>중성화 여부</h3></td>
							<td><input type="radio" name="pet_operation" value="1"
								<%=1==(pet.getPet_operation())? "checked":"" %>>예 <input
								type="radio" name="pet_operation" value="0"
								<%=0==(pet.getPet_operation())? "checked":"" %>>아니오</td>
						</tr>
						<tr>
							<td width=150><h3>나이</h3></td>
							<td><input type="text" name="pet_age" style="width: 300px;"
								value="<%= pet.getPet_age() == null ? "" : pet.getPet_age() %>" />
							</td>
						</tr>
						<tr>
							<td width=150><h3>대형동물</h3></td>
							<td><input type="checkbox" name="pet_big" value="1"
								<%=1==(pet.getPet_big())? "checked":"" %>> 20kg 이상일 경우
								체크해주세요.</td>
						</tr>
					</table>

					<br /> <input type="submit" value="수정하기" />&emsp; <input
						type="button" value="삭제하기" onclick="popupOpen()" />&emsp; <input
						type="button" value="뒤로가기"
						onclick="window.location='petSelect.jsp'" />&emsp; <br /> <br />
				</form>


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


<%} %>


</html>
