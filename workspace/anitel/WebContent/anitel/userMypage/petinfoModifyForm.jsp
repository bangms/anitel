
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

	var petnameRegExp = /^[가-힣]{1,10}$/;
    if (!petnameRegExp.test(pet_name)) {
        alert("반려동물 이름은 한글만 가능합니다!");
        return false;
    }
    return true; //확인이 완료되었을 때
}
</script>
<body>
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
							<li class="menu"><a href="user1_1.jsp">1:1문의</a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	<!-- 여기서부터 콘텐츠 화면 입니다.  -->
	<div id="section" style="padding-left: 15%; margin-left: 40px;">
		<div class="info_wrap">
			<h1><%=pet.getPet_name()%>의 정보</h1>
			<hr/>
			<form name="PM" action="petinfoModifyPro.jsp" method="post"  onsubmit="return check()">
				<input type="hidden" name="pet_num" value="<%=pet_num%>" />
				
				<div class="table_wrap">
					<div class="sub">이름</div>
					<div class="con">
						<input type="text" name="pet_name" value="<%= pet.getPet_name()%>" />
					</div>
				</div>
				
				<div class="table_wrap">
					<div class="sub">종</div>
					<div class="con">
						<select id="pet_type" name="pet_type" onChange="view(this.value)">
							<option value="" disabled selected>선택</option>
							<option value="0" <%=0==(pet.getPet_type())? "selected":"" %>>강아지</option>
							<option value="1" <%=1==(pet.getPet_type())? "selected":"" %>>고양이</option>
							<option value="2" <%=2==(pet.getPet_type())? "selected":"" %>>기타동물</option>
						</select>
					</div>
				</div>
				
		
					<div id="etc" class="table_wrap <%if(pet.getPet_type()==2) {%>show<%}else{ %>hidden<%} %>">
						<div class="sub">기타동물</div>
						<div class="con">
							<input type="text" id="pet_etctype" name="pet_etctype" value="<%= pet.getPet_etctype() == null ? "" : pet.getPet_etctype() %>" placeholder="기타동물 입력란" />
						</div>
					</div>
						

				
				<div class="table_wrap">
					<div class="sub">반려동물 성별</div>
					<div class="con">
						<input type="radio" name="pet_gender" value="1" <%=1==(pet.getPet_gender())? "checked":"" %>> 수컷
						<input type="radio" name="pet_gender" value="0" <%=0==(pet.getPet_gender())? "checked":"" %>> 암컷
					</div>
				</div>
					
				<div class="table_wrap">
					<div class="sub">중성화 여부</div>
					<div class="con">
						<input type="radio" name="pet_operation" value="1" <%=1==(pet.getPet_operation())? "checked":"" %>>예
						<input
							type="radio" name="pet_operation" value="0" <%=0==(pet.getPet_operation())? "checked":"" %>>아니오
					</div>
				</div>	
				
				<div class="table_wrap">
					<div class="sub">나이</div>
					<div class="con">
						<input type="text" name="pet_age" value="<%= pet.getPet_age() == null ? "" : pet.getPet_age() %>" />
					</div>
				</div>
					
				<div class="table_wrap">
					<div class="sub">대형동물</div>
					<div class="con">
						<input type="checkbox" name="pet_big" value="1" <%=1==(pet.getPet_big())? "checked":"" %>>
						 <span style="font-size:0.7em; font-weight:100;">20kg 이상일 경우 체크해주세요.</span>
					</div>
				</div>
					
				<div class="btn_wrap">
					<input type="submit" class="btn" value="수정하기" style="margin:0"/>&emsp;
					<input type="button" class="btn" value="삭제하기" onclick="popupOpen()" style="margin:0" />&emsp;
					<input type="button" class="btn" value="뒤로가기" onclick="window.location='petSelect.jsp'" />&emsp;
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
 <%-- 반려동물 종 선택 기타 입력란 나타내는 스크립트 --%>
 <script type="text/javascript">
function view(value){
	var pet_type_sel = document.getElementById('pet_type');
	var pet_type = pet_type_sel.options[pet_type_sel.selectedIndex].value;
	var input = document.getElementById('etc');
	if(pet_type == 2) {
		input.classList.replace('hidden', 'show');
	} else {
		input.classList.replace('show', 'hidden');
	}
}
</script>

<%} %>


</html>
