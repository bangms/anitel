<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="anitel.model.RoomDTO"%>
<%@page import="anitel.model.RoomDAO"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<head>
	<meta charset="UTF-8">
	<title>객실 수정</title>
	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
  <link rel="stylesheet" href="../style/mypage.css">
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
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO member = dao.getMember(id);
	
	int room_num = Integer.parseInt(request.getParameter("room_num"));
	RoomDAO roomdao = RoomDAO.getInstance();
	RoomDTO room = roomdao.getRoom(room_num); 	
%>
<script>
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
        <h1>호텔 객실 정보 수정</h1>
      	<hr align="left" width=1000 color="black">
      	<div>
      		<form  action="memberRoomAddPro.jsp?room_num=<%= room_num %>" method="post" name="mod" onsubmit=check() enctype="multipart/form-data">
      		<table>
      			<tr>
      				<td>객실 목록</td>
      			</tr>
      			<tr>
      				<td>
      					<table border=1>
      						<tr align="center">
      							<td>
      								객실 이름
      							</td>
      							<td>
      								수용 동물
      							</td>
      							<td>
      								1박 이용 요금
      							</td>
      							<td>
      								대형동물 수용여부
      							</td>
      							<td>
      								객실 이미지
      							</td>
      						</tr>

      						<tr align="center">
      							<td>
      								<input type="text" name="name" placeholder="<%= room.getName() %>" value="<%= room.getName() %>"/>
      							</td>
      							<td>
      								<select name="pet_type">
      									<option value="0" <% if(room.getPet_type()==0) {%>selected<%} %>>강아지</option>
      									<option value="1" <% if(room.getPet_type()==1) {%>selected<%} %>>고양이</option>
      									<option value="2" <% if(room.getPet_type()==2) {%>selected<%} %>>기타</option>
      								</select>
      							</td>
      							<td>
      								<input type="text" name="d_fee" placeholder="<%= room.getD_fee() %>" value="<%= room.getD_fee() %>"/>
      							</td>
      							<td>
      								<input type="checkbox" name="pet_big" value=<%= room.getPet_big() %> <% if(room.getPet_big()==1) {%>checked<%} %> />수용 가능합니다
      							</td>
      							<td>
      								<img src="/anitel/save/<%= room.getImg() %>" width=100/>
      								<input type="file" name="img"/>
      								<input type="hidden" name="eximg" value="<%= room.getImg() %>"/>
      							</td>
      						</tr>
      						<tr align="right">
      							<td colspan=5>
      								<input type="submit" value="수정"/>
      							</td>
      						</tr>
      					</table>
      				</td>
      			</tr>
      		</table>
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
