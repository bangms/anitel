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
	RoomDAO room = RoomDAO.getInstance();
	List roomList = room.getRoomList(id);
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
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
					    </ul>
					  </nav>
					</div>
				</div>
      </div>
      
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      <div id="section" style="padding-left:15%; margin-left:40px;">
        <h1><%= member.getMember_name() %>님의 호텔 객실 관리</h1>
      	<hr align="left" width=1000 color="black">
      	<div>
      		<form  action="memberRoomAddForm.jsp" name="frmUserInfo" method="post">
      		<table>
      			<tr>
      				<td>객실 목록</td>
      			</tr>
      			<tr>
      				<td>
      					<table border=1>
      						<tr align="center">
      							<td>
      								체크
      							</td>
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
      							<td>
      								객실 수정
      							</td>
      						</tr>
<%							for(int i = 0; i < roomList.size(); i++) {
								RoomDTO dto = (RoomDTO)roomList.get(i); %>
      						<tr align="center">
      							<td>
      								<input type="checkbox" name="info" value="<%= dto.getRoom_num() %>"/></td>
      							<td>
      								<%= dto.getName() %>
      							</td>
      							<td>
      								<% if(dto.getPet_type()==0) { %>강아지
      								<% }else if(dto.getPet_type()==1) { %>고양이
      								<% }else if(dto.getPet_type()==2) { %>기타
      								<% } %>
      							</td>
      							<td>
									<%= dto.getD_fee() %>
      							</td>
      							<td>
      								<% if(dto.getPet_big()==1) { %>가능<% }else { %>불가능<%} %>
      							</td>
      							<td>
      								<% if(dto.getImg()==null) { %>
										이미지 없음
									<% }else{ %>
      									<img src="/anitel/save/<%= dto.getImg() %>" width=100/>
      								<% } %>
      							</td>
      							<td>
      								<input type="button" value="객실 정보 수정" onclick="window.location='memberRoomAddForm.jsp?room_num=<%= dto.getRoom_num() %>'"/> 
      							</td>
      						</tr>
<%							} %>
      						<tr align="left">
      							<td colspan=7>
      								<input type="button" value="삭제" onclick="chkUser();"/>
      							</td>
      						</tr>
      					</table>
      				</td>
      			</tr>
      		</table>
      		</form>
      	</div>
      	<br/><br/>
      	<div>
      		<form action="memberRoomModifyPro.jsp" method="post" name="mod" onsubmit=check() enctype="multipart/form-data">
      		<table>
      			<tr>
      				<td>객실 추가</td>
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
      								객실 이미지(1장)
      							</td>
      						</tr>
      						<tr align="center">
      							<td>
      								<input type="text" name="name" placeholder="이름을 입력해주세요"/>
      							</td>
      							<td>
      								<select name="pet_type">
      									<option value="0">강아지</option>
      									<option value="1">고양이</option>
      									<option value="2">기타</option>
      								</select>
      							</td>
      							<td>
      								<input type="text" name="d_fee" placeholder="숫자만 입력해주세요"/>
      							</td>
      							<td>
      								<input type="checkbox" name="pet_big" value=1 />수용 가능합니다
      							</td>
      							<td>
      								<input type="file" name="img"/>
      							</td>
      						</tr>
      					</table>
      				</td>
      			</tr>
      			<tr>
      				<td rowspan=5 align="right">
      					<input type="submit" value="추가하기"/>
      				</td>
      			</tr>
      		</table>     		
      		</form>
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
<%	} %>
</html>
