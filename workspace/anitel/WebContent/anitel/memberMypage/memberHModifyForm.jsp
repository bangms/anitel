<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>마이페이지(사업자회원) - 호텔정보 수정</title>\
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
	if(session.getAttribute("sid")==null){ 	%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ 
	String id = (String)session.getAttribute("sid");
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO member = dao.getMemberHotel(id);
%>
<script>
function check(){
	if (!checkHotelName(mod.hotel_name.value)) {
		return false;
	} else if (!checkOwner(mod.hotel_owner.value)) {
		return false;
	} else if (!checkPhone(mod.hotel_phone.value)) {
		return false;
	}  else if (!checkReg(mod.reg_num.value)) {
		return false;
	}  
	return true;
}

//공백확인 함수 
function checkExistData(value, dataName) {
    if (value == "") {
        alert(dataName + " 입력해주세요!");
        return false;
    }
    return true;
}

function checkHotelName(hotel_name) {
	if (!checkExistData(name, "호텔 이름을"))
	    return false;
	
	var nameRegExp = /^[가-힣]{2,10}$/;
		if (!nameRegExp.test(hotel_name)) {
		    alert("이름은 2~10자 사이의 한글만 가능합니다.");
		    return false;
		}
		return true; //확인이 완료되었을 때
}

function checkOwner(hotel_owner) {
	if (!checkExistData(name, "대표자 성명을"))
	    return false;
	
	var nameRegExp = /^[가-힣]{2,10}$/;
		if (!nameRegExp.test(hotel_owner)) {
		    alert("이름은 2~10자 사이의 한글만 가능합니다.");
		    return false;
		}
		return true; //확인이 완료되었을 때
}

function checkPhone(hotel_phone) {
    if (!checkExistData(hotel_phone, "호텔 전화번호를"))
        return false;
    return true; //확인이 완료되었을 때
}

function checkReg(reg_num) {
    if (!checkExistData(reg_num, "사업자 등록번호를"))
        return false;

    var numRegExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
    if (!numRegExp.test(reg_num)) {
        alert("사업자 등록번호는 000-000-000000의 형식으로 입력해야 합니다.");
        return false;
    }
    return true; //확인이 완료되었을 때
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
      	<div class="info_wrap" width="85%">
        	<h1><%= member.getMember_name() %>님의 호텔관리</h1>
        	<hr/>
        	
      		<form id="memberH" action="memberHModifyPro.jsp" method="post" name="mod" <%--onsubmit=check()--%> enctype="multipart/form-data">
      			<div class="table_wrap">
							<div class="sub">호텔 이름</div>
							<div class="con"><input type="text" name="hotel_name" value="<%= member.getHotel_name() %>" autofocus /></div>
						</div>
      			
      			<div class="table_wrap">
							<div class="sub">대표자 성명</div>
							<div class="con"><input type="text" name="hotel_owner" value="<%= member.getHotel_owner() %>"/></div>
						</div>
      			
      			<div class="table_wrap">
							<div class="sub">호텔 주소</div>
							<div class="con" style="float:left;">
								<select name="hotel_area" style="font-size:1em; width:40%;">
									<option value="서울" <% if(member.getHotel_area().equals("서울")){%>selected<%} %>>서울</option>
									<option value="부산" <% if(member.getHotel_area().equals("부산")){%>selected<%} %>>부산</option>
									<option value="대구" <% if(member.getHotel_area().equals("대구")){%>selected<%} %>>대구</option>
									<option value="인천" <% if(member.getHotel_area().equals("인천")){%>selected<%} %>>인천</option>
									<option value="경기" <% if(member.getHotel_area().equals("경기")){%>selected<%} %>>경기</option>
									<option value="광주" <% if(member.getHotel_area().equals("광주")){%>selected<%} %>>광주</option>
									<option value="대전" <% if(member.getHotel_area().equals("대전")){%>selected<%} %>>대전</option>
									<option value="울산" <% if(member.getHotel_area().equals("울산")){%>selected<%} %>>울산</option>
									<option value="경상도" <% if(member.getHotel_area().equals("경상도")){%>selected<%} %>>경상도</option>
									<option value="전라도" <% if(member.getHotel_area().equals("전라도")){%>selected<%} %>>전라도</option>
									<option value="제주도" <% if(member.getHotel_area().equals("제주도")){%>selected<%} %>>제주도</option>
									<option value="충청도" <% if(member.getHotel_area().equals("충청도")){%>selected<%} %>>충청도</option>
									<option value="강원도" <% if(member.getHotel_area().equals("강원도")){%>selected<%} %>>강원도</option>
								</select>
								<input style="width: 100%" type="text" name="hotel_add" value="<%= member.getHotel_add() %>"/>
							</div>
						</div>
      	
      			<div class="table_wrap">
							<div class="sub">호텔 전화번호</div>
							<div class="con">
								<input type="text" name="hotel_phone" value="<%= member.getHotel_phone() %>"/>
							</div>
						</div>
      	
      			<div class="table_wrap">
							<div class="sub">사업자 등록번호</div>
							<div class="con">
								<input type="text" name="reg_num" value="<%= member.getReg_num() %>"/>
							</div>
						</div>
      
						<div class="table_wrap">
							<div class="sub">호텔 대표 이미지</div>
							<div class="con">
								<% if(member.getHotel_img()==null) { System.out.println(member.getHotel_img());%>
											이미지 없음
								<% }else{ %>
											<img src="/anitel/save/<%= member.getHotel_img() %>" width=100/>
								<% } %>
							</div>
						</div>
      		
      			<div class="table_wrap">
							<div class="sub" style>대표 이미지 업로드</div>
							<div class="con">
								<input type="file" name="hotel_img"/>
							</div>
						</div>
						
						<div class="btn_wrap" style="margin-bottom:50px;">
							<input type="submit" class="btn" value="수정내용 저장"/>&emsp;
							<input type="button" class="btn" value="수정 취소" onclick="window.location='memberHInfo.jsp'"/>&emsp; 
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
