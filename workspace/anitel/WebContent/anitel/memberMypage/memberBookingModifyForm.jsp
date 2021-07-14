<%@page import="java.text.SimpleDateFormat"%>
<%@page import="anitel.model.BKListDTO"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>마이페이지(사업자회원) - 호텔 예약 관리</title>
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
	MemberDTO member = dao.getMemberHotel(id);
	System.out.println("memberBookingModifyForm - id : " + id);
	List userList = dao.getBookingList(id); 
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
			var url ="memberBookingDeleteForm.jsp";
			window.open('','userdelete','width=500,height=150,location=no,status=no,scrollbars=yes');
			
			frmUserInfo.action = url;
			frmUserInfo.target = 'userdelete'
			frmUserInfo.submit();
		}			
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
        <h1><%= member.getMember_name() %>님의 <%= member.getHotel_name() %> 호텔 예약 관리</h1>
      	<hr align="left" width=800 color="black">
      	<br/>
      	
      	<form action="/anitel/memberMypage/memberBookingModifyForm.jsp" name="frmUserInfo" method="post">
      	예정된 예약 일정
      	<table border=1>
      		<tr align="center">
      			<td>체크</td>
      			<td>객실명</td>
      			<td>예약날짜</td>
      			<td>체크인 날짜</td>
      			<td>체크아웃 날짜</td>
      			<td>예약자명</td>
      			<td>예약자 연락처</td>
      			<td>반려동물 이름</td>
      			<td>요청사항</td>
      		</tr>
<%			for(int i = 0; i < userList.size(); i++) {
					BKListDTO dto = (BKListDTO)userList.get(i); %>
      		<tr align="center">
      			<td><input type="checkbox" name="info" value="<%= dto.getBooking_num() %>"/></td>
      			<td><%= dto.getName() %></td>
      			<td><%= sdf.format(dto.getBooking_time()) %></td>
      			<td><%= sdf.format(dto.getCheck_in()) %></td>
      			<td><%= sdf.format(dto.getCheck_out()) %></td>
      			<td><%= dto.getUser_name() %></td>
      			<td><%= dto.getUser_phone() %></td>
      			<td><%= dto.getPet_name() %></td>
      			<td><%= dto.getRequests() %></td>
      		</tr>
<%			} %>
      	</table>
      	
      	<div>
      		<input type="button" value="삭제" onclick="chkUser();"/>
      		<input type="button" value="지난 예약 보기" onclick="window.location='memberBookingAfterForm.jsp'" />
      	</div>
		</form>
        
 
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
