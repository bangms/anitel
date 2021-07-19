<%@page import="java.util.ArrayList"%>
<%@page import="anitel.model.ReserveDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="anitel.model.BookingDAO"%>
<%@page import="anitel.model.BookingDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>내 예약 현황</title>
  <link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
	<link rel="stylesheet" href="../style/mypage.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	
	// 게시글 5개 노출, 페이징 처리
	int pageSize = 5;
	String pageNum = request.getParameter("pageNum");
	String num = request.getParameter("num");
	if(pageNum == null) { pageNum = "1"; }
	if(num == null){ num = "2"; }
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	
	BookingDAO dao = BookingDAO.getInstance();	
	List reserveList = null;
	
	count = dao.getReserveCount(id, num); // 갯수 받아옴
	if(count > 0){
		reserveList = dao.getReserve(id, num, startRow, endRow); // 끝번호 시작번호만으로 출력
	}
	//날짜 출력 형태 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");	
%>
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
						<li class="menu"><a href="user1_1.jsp">1:1문의</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>

	<!-- 여기서부터 콘텐츠 화면 입니다.  -->
	<div id="section" style="padding-left:15%; margin-left:40px;">
	 	<div class="info_wrap">
			<h1>나의 예약 현황</h1>
			<hr style="margin-bottom: 10px;">
			<div class="menu_wrap">
				<ul class="menu">
					<li><a href="userMyReserve.jsp?num=2">투숙예정 예약</a></li>
					<li><a href="userMyReserve.jsp?num=0">투숙완료 예약</a></li>
					<li><a href="userMyReserve.jsp?num=1">취소된예약</a></li>
				</ul>
			</div>
			<div class="list_wrap">
				<ul class="hotel_list">
			<%if(count == 0){ %>
				<h3>예약이 없습니다.</h3>
			<%}else{%>
	
				<%for(int i = 0; i < reserveList.size(); i++){ 
					ReserveDTO reserve = (ReserveDTO)reserveList.get(i);	%>
					
					<input type="hidden" class="booking_num" value="<%=reserve.getBooking_num()%>" /> 
					<input type="hidden" class="reg_num" value="<%=reserve.getReg_num()%>" />

					<li>
						<div class="card_wrapper">
							<div class="hotel_img">
								<%if(reserve.getHotel_img() != null){%>
										<img src="../..//anitel/save/<%=reserve.getHotel_img()%>" width="50%"/>
								<%}else{ %>
										<img src="../../anitel/save/default.png"/>
								<%} %>
							</div>
							
							<div class="booking_info">
								
								<%if(reserve.getBooking_status() ==0){ %><div class="status_txt">투숙완료</div> 
								<%}else if(reserve.getBooking_status()==2){ %><div class="status_txt">투숙 예정</div> 
								<%}else if(reserve.getBooking_status()==1){ %><div class="status_txt">취소됨</div> <%} %>
							
							   <div class="hotel_name">
							     <p><%=reserve.getHotel_name() %></p>
							   </div>
							   <div class="date">
							   		<div class="start">
											<div class="sub">체크인</div> 
											<div class="con"><%= sdf.format(reserve.getCheck_in()) %></div>
							   		</div>
										<div class="end">
											<div class="sub">체크아웃</div> 
											<div class="con"><%= sdf.format(reserve.getCheck_out()) %></div>
										</div>
							   </div>
							   <div class="booking_num">
							     <div class="sub">예약번호</div>
							     <div class="con"><%= reserve.getBooking_num() %></div>
							   </div>
							   <div class="pet_name">
							     <div class="sub">반려동물 이름</div>
							     <div class="con"><%= reserve.getPet_name() %></div>
							   </div>
							   <div class="paid">
					     		<div class="sub">선택한 유료 서비스
						     	</div>
						     	<div class="con">
							     	<%if(reserve.getPaid_bath()==1){%> V 목욕 <%}%>
										<%if(reserve.getPaid_beauty()==1){%> V 미용 <%}%>
										<%if(reserve.getPaid_medi()==1){%> V 병원 <%}%>
							     </div>
					     		<span style="font-size:0.7em;font-weight:100;width:100%;text-align:left;">
					     			(현장에서 추가 결제가 필요한 항목입니다.)
					     		</span>
							   </div>
							   <div class="request">
								   	<div class="sub">요청 사항</div>
								   	<div class="con">
								   		<%=reserve.getRequests() == null ? "" : reserve.getRequests() %>
								   	</div>
							   </div>
							</div>
							<div class="btn">
								<%if(reserve.getBooking_status() ==0){ %>
									<button id="withdraw" onclick="location='../board/writeForm.jsp?categ=3&amp;reg_num=<%=reserve.getReg_num()%>'">후기쓰기</button>
								<%}else if(reserve.getBooking_status()==2){ %>
									<button id="withdraw" onclick="check(<%=reserve.getBooking_num()%>)">예약취소</button>&emsp;
								<%}%>
							</div>
						</div>						
					</li>
					<%}//리스트가 있는만큼 반복%>
				<%}//count 0일시 분기처리%>
				</ul>
			</div>
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
<script type="text/javascript">
function check(booking_num){
	//var booking_num= $("#booking_num").val();
	console.log(booking_num);
	var popUrl = "/anitel/anitel/userMypage/userCancelForm.jsp?booking_num="+ booking_num;	//팝업창에 출력될 페이지 URL
	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);

	}
	

</script>

<%}%>
</html> 
