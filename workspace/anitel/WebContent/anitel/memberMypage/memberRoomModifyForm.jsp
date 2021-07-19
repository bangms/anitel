<%@page import="java.text.DecimalFormat"%>
<%@page import="anitel.model.RoomDTO"%>
<%@page import="anitel.model.RoomDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지(사업자회원) - 호텔 객실 관리</title>
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
	RoomDAO room = RoomDAO.getInstance();
	List roomList = room.getRoomList(id);
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
	DecimalFormat df = new DecimalFormat("###,###");
	
%>

<script>
	function chkUser() {
		obj = document.getElementsByName("info");			
		var cnt = 0;
		for(var i = 0; i < obj.length; i++) {
			if (obj[i].checked) {
				cnt++;
			}
		}
		if(cnt == 0){
			alert("선택된 회원 정보가 없습니다.");
			return;
		}else{
			var frm = document.frmUserInfo		
			var url ="memberRoomDeleteForm.jsp";
			window.open('','userdelete','width=500,height=150,location=no,status=no,scrollbars=yes');
			
			frmUserInfo.action = url;
			frmUserInfo.target = 'userdelete'
			frmUserInfo.submit();
		}			
	}
	// 폼 이름 : mod
	function check(){
		if (!checkRoomName(mod.name.value)) {
			return false;
		} else if (!checkFee(mod.d_fee.value)) {
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
	
	function checkRoomName(name) {
		if (!checkExistData(name, "객실 이름을"))
		    return false;
		
		var nameRegExp = /^[가-힣]{2,10}$/;
			if (!nameRegExp.test(user_name)) {
			    alert("이름은 2~10자 사이의 한글만 가능합니다.");
			    return false;
			}
			return true; //확인이 완료되었을 때
	}
	
	function checkFee(d_fee) {
	    if (!checkExistData(d_fee, "이용요금을"))
	        return false;

	    var feeRegExp = /^[0-9]*$/;
	    if (!feeRegExp.test(d_fee)) {
	        alert("이용요금은 숫자만 가능합니다.");
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
					    	<li class="menu"><a href="member1_1.jsp">1:1문의</a></li>
					    </ul>
					  </nav>
					</div>
				</div>
      </div>
      
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      <div id="section" style="padding-left:15%; margin-left:40px;">
		 		<h1 style="padding: 20px 0; font-weight: 700; font-size: 1.4em;"><%= member.getMember_name() %>님의 호텔 객실 및 서비스 관리</h1>
        <hr width="80%" style="margin:30px auto;">
        
       	<div class="table_wrap" style="width:100%; height: auto;">
				  <ul class="responsive-table">
				    <li class="table-header">
				      <div class="col col-1" style="flex-basis: 3%;"></div>
				      <div class="col col-2" style="flex-basis: 16.166%;">객실명</div>
				      <div class="col col-3" style="flex-basis: 16.166%;">수용동물</div>
				      <div class="col col-4" style="flex-basis: 16.166%;">이용요금</div>
				      <div class="col col-5" style="flex-basis: 16.166%;">대형동물</div>
				      <div class="col col-6" style="flex-basis: 16.166%;">객실이미지</div>
				      <div class="col col-7" style="flex-basis: 16.166%;">객실수정</div>
				    </li>                   
        <% if(roomList == null) {%>
        		<h3 style="padding: 100px;">등록된 객실이 없습니다.</h3>
        <% } else { %>
						<form  action="memberRoomAddForm.jsp" name="frmUserInfo" method="post">
	<%					for(int i = 0; i < roomList.size(); i++) {
								RoomDTO dto = (RoomDTO)roomList.get(i); %>
								
								<li class="table-row">
									<div class="col col-1" style="flex-basis: 3%;"><input type="checkbox" name="info" value="<%= dto.getRoom_num() %>"/></div>
				      		<div class="col col-2" style="flex-basis: 16.166%;"><%= dto.getName() %></div>
						      <div class="col col-3" style="flex-basis: 16.166%;">
						      	<% if(dto.getPet_type()==0) { %>강아지
     								<% }else if(dto.getPet_type()==1) { %>고양이
     								<% }else if(dto.getPet_type()==2) { %>기타
     								<% } %></div>
						      <div class="col col-4" style="flex-basis: 16.166%;"><%= dto.getD_fee() %></div>
						      <div class="col col-5" style="flex-basis: 16.166%;"><% if(dto.getPet_big()==1) { %>가능<% }else { %>불가능<%} %></div>
						      <div class="col col-6" style="flex-basis: 16.166%;">
						      	<% if(dto.getImg()==null) { %>
												이미지 없음
									<% 	 }else{ %>
      									<img src="/anitel/save/<%= dto.getImg() %>" width=100 />
      							<% } %>
      						</div>
						      <div class="col col-7" style="flex-basis: 16.166%;">
						      	<input class="t_btn" type="button" value="객실 정보 수정" onclick="window.location='memberRoomAddForm.jsp?room_num=<%= dto.getRoom_num() %>'"/>
						      </div>
					     	</li>
       	<% 		} // for문 안 %>
		     			</form>
		<%			} // 객실 있는지 없는지 %>
							<input class="btn" type="button" value="삭제" onclick="chkUser();"/>
						</ul>
					</div>	
					
				<div class="add_room">
					<h2>객실 추가</h2>
      		<form action="memberRoomModifyPro.jsp" method="post" name="mod" onsubmit=check() enctype="multipart/form-data">
      			
      			<div class="table_wrap">
							<div class="sub">객실명</div>
							<div class="con">
								<input type="text" name="name" placeholder="객실명을 입력해주세요"/>
							</div>
						</div>
						
						<div class="table_wrap">
							<div class="sub">수용동물</div>
							<div class="con">
								<select id="pet_type" name="pet_type">
									<option value="0">강아지</option>
 									<option value="1">고양이</option>
 									<option value="2">기타</option>
								</select>
							</div>
						</div>
						
						<div class="table_wrap">
							<div class="sub">이용요금</div>
							<div class="con">
								<input type="text" name="d_fee" placeholder="숫자만 입력해주세요"/>
							</div>
						</div>
						
						<div class="table_wrap">
							<div class="sub">대형동물 수용여부</div>
							<div class="con">
								<input type="checkbox" name="pet_big" value=1 />
								<span style="font-size:0.7em; font-weight:100;">수용가능합니다.</span>
							</div>
						</div>
						
						<div class="table_wrap">
							<div class="sub">객실 이미지 올리기</div>
							<div class="con">
								<input type="file" name="img"/>
							</div>
						</div>
						
						<input class="btn" type="submit" value="추가하기"/>
						
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
