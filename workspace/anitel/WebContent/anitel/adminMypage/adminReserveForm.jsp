<%@page import="java.text.SimpleDateFormat"%>
<%@page import="anitel.model.BKListDTO"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adminReserve</title>
	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
	<link rel="stylesheet" href="../style/search.css">
	<style>
		button {
	      	border: none;
	      	border-radius: 3px;
	      	width: 110px;
	      	height: 30px;	
		}
    </style>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	// 게시글 10개 노출, 페이징 처리
	int pageSize = 10;

	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) { pageNum = "1"; }

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	
	AdminDAO dao = AdminDAO.getInstance();
	
	List bookingList = dao.getBookingList(startRow, endRow);
	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	
	if(sel != null && search != null) {
		count = dao.getBookingSearchCount(sel, search); 
		if(count > 0) {
			bookingList = dao.getBookingSearch(startRow, endRow, sel, search);
		}
	}else {
		count = dao.getBookingCount();
		if(count > 0) {
			bookingList = dao.getBookingList(startRow, endRow);
		}		
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid") == null){ %>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ %>
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
				alert("선택된 예약 정보가 없습니다.");
				return;
			}else{
				var frm = document.frmUserInfo		
				var url ="/anitel/anitel/adminMypage/adminReserveCancelForm.jsp";
				window.open('','userdelete','width=500,height=300,location=no,status=no,scrollbars=yes');
				
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
<% 	
		if(session.getAttribute("sid") == null){ 
%>
			<button id="signin" onclick="window.location='../signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='../loginForm.jsp'">로그인</button>
			
		<%}else{ %>
			<button id="mypage" onclick="window.location='adminUserForm.jsp'">마이페이지</button>
			<button id="signout" onclick="window.location='../logout.jsp'">로그아웃</button>
		<%}%>

		</div>
	</div>	

	<!-- 여기서부터 사이드바 입니다.  -->
	<div id="sidebar">
	  <h1 class="menu_name">관리자 페이지</h1>
	  <!-- <ul class="sidebar_menu_wrap"> -->
	  	
			<div class="sidebar_menu_wrap">
				<div class="nav-wrap">
				  <nav class="main-nav" role="navigation">
				    <ul class="unstyled list-hover-slide">
				      <li class="menu"><a href="adminUserForm.jsp">회원 관리</a></li>
					    <li class="menu"><a href="adminMemberForm.jsp">사업자 관리</a></li>
					    <li class="menu"><a href="adminReserveForm.jsp">예약 관리</a></li>
					    <li class="menu"><a href="adminReviewForm.jsp">후기 관리</a></li>
					    <li class="menu"><a href="../board/list.jsp?categ=0">공지사항</a></li>
					    <li class="menu"><a href="adminMemberQnAForm.jsp">사업자 1:1 문의</a></li>
					    <li class="menu"><a href="adminUserQnAForm.jsp">일반회원 1:1 문의</a></li>
				    </ul>
				  </nav>
				</div>
			</div>
	</div>
	<!-- 여기서부터 콘텐츠 화면 입니다.  -->
	<div id="section" style="padding-left:15%; margin-left:40px;">
		<% if(count == 0) { %>
			<h3 align="center">표시할 내용이 없습니다.</h3>
		<%}else {%>
		<form action="adminReserveForm.jsp" name="frmUserInfo" method="post">
		
			<div class="table_wrap">
			  <h2>호텔 예약 관리 페이지</h2>
			  <ul class="responsive-table">
			    <li class="table-header">
			      <div class="col col-1" style="flex-basis: 3%;"></div>
			      <div class="col col-2" style="flex-basis: 10.77%;">호텔명</div>
			      <div class="col col-3" style="flex-basis: 10.77%;">객실명</div>
			      <div class="col col-4" style="flex-basis: 10.77%;">예약날짜</div>
			      <div class="col col-5" style="flex-basis: 10.77%;">체크인 날짜</div>
			      <div class="col col-6" style="flex-basis: 10.77%;">예약회원명</div>
			      <div class="col col-7" style="flex-basis: 10.77%;">예약회원연락처</div>
			      <div class="col col-8" style="flex-basis: 10.77%;">동물정보</div>
			      <div class="col col-9" style="flex-basis: 10.77%;">추가요청사항</div>
			      <div class="col col-10" style="flex-basis: 10.77%;">예약상태</div>
			      <div class="col col-11" style="flex-basis: 10.77%;">결제상태</div>
			    </li>
			    
				<%
				for(int i = 0; i < bookingList.size(); i++) {
					BKListDTO hotel = (BKListDTO)bookingList.get(i); 
				%>
					<li class="table-row">
			      <div class="col col-1" style="flex-basis: 3%;" data-label="checkbox"><input type="checkbox" name="info" value="<%=hotel.getBooking_num()%>" /></div>
			      <div class="col col-2" style="flex-basis: 10.77%;" data-label="hotelName"><%=hotel.getHotel_name() %></div>
			      <div class="col col-3" style="flex-basis: 10.77%;" data-label="roomName"><%=hotel.getName() %></div>
			      <div class="col col-4" style="flex-basis: 10.77%;" data-label="Booking_time"><%=sdf.format(hotel.getBooking_time()) %></div>
			      <div class="col col-5" style="flex-basis: 10.77%;" data-label="Check_in"><%=sdf.format(hotel.getCheck_in()) %></div>
			      <div class="col col-6" style="flex-basis: 10.77%;" data-label="userName"><%=hotel.getUser_name() %></div>
			      <div class="col col-7" style="flex-basis: 10.77%;" data-label="userPhone"><%=hotel.getUser_phone() %></div>
			      <div class="col col-8" style="flex-basis: 10.77%;" data-label="petName">
			      	<input class="t_btn" style="width: 100px" type="button" value="<%=hotel.getPet_name()%>" onclick="window.open('adminReserveAnimalInfo.jsp?petnum=<%=hotel.getPet_num()%>','','width=500,height=500,location=no,status=no,scrollbars=no,left=800,top=250')"/>		      
			      </div>
			      <div class="col col-9" style="flex-basis: 10.77%;" data-label="Requests">	      
			      	<%if(hotel.getRequests() != null){%>
			      		<input class="t_btn add" type="button" value="추가요청사항" onclick="window.open('adminReserveAddInfo.jsp?petnum=<%=hotel.getPet_num()%>','','width=500,height=500,location=no,status=no,scrollbars=no,left=800,top=250')"/>		      							
					<%}else if(hotel.getRequests() == null) {%>
					<%} %>
			      </div>
			      <div class="col col-10" style="flex-basis: 10.77%;" data-label="">
			      	<%if(hotel.getBooking_status() == 0) {%>
			      				<h4>예약종료</h4>
							<%}else if(hotel.getBooking_status() == 1){ %>
								<h4>예약취소</h4>
							<%}else if(hotel.getBooking_status() == 2){%>
								<h4>예약완료</h4>
							<%} %>			      			      
			      </div>
			      <div class="col col-11"style="flex-basis: 10.77%;"  data-label="payment">
			      	<%if(hotel.getPayment() == 0) {%>
			      				<h4>결제중</h4>
							<%}else if(hotel.getPayment() == 1){ %>
								<h4>결제완료</h4>
							<%}else if(hotel.getPayment() == 2){%>
								<h4>결제취소</h4>
							<%} %>
			      </div>
			    </li>	

				<%} %>				
				</ul>
				<input class="btn" type="button" value="예약취소" onclick="chkUser();"/>
			</div>
			<br />
			<div class="pageNum">
				<%
				int pageBlock = 3;
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				int startPageNum = (int)(currentPage-1)/(pageBlock) * pageBlock + 1;
				int endPageNum = startPageNum + pageBlock -1;
				if(endPageNum > pageCount) endPageNum = pageCount;
				
				if(sel != null && search != null) {
					if(startPageNum > pageBlock) {	%>			
					<a href="adminReserveForm.jsp?pageNum=<%=startPageNum-pageBlock%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &lt; </a>	&nbsp;	
					<%}
				
					for(int i = startPageNum; i <= endPageNum; i++) { %>		
						<a href="adminReserveForm.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &nbsp; <%=i %> &nbsp; </a>
					<%}
			
					if(endPageNum < pageCount) {	%>			
						&nbsp; <a href="adminReserveForm.jsp?pageNum=<%=startPageNum+pageBlock%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &gt; </a>
					<%}		
				}else {
					if(startPageNum > pageBlock) {	%>			
					<a href="adminReserveForm.jsp?pageNum=<%=startPageNum-pageBlock%>" class="pageNums"> &lt; </a>	&nbsp;	
					<%}
				
					for(int i = startPageNum; i <= endPageNum; i++) { %>		
						<a href="adminReserveForm.jsp?pageNum=<%=i%>" class="pageNums"> &nbsp; <%=i %> &nbsp; </a>
					<%}
			
					if(endPageNum < pageCount) {	%>			
						&nbsp; <a href="adminReserveForm.jsp?pageNum=<%=startPageNum+pageBlock%>" class="pageNums"> &gt; </a>
					<%}%>
				<%} %>
			</div>
			
			<div class="search_wrap">
				<div id="sel" class="select-box">
					  <div class="select-box_current" tabindex="1">
					    <div class="select-box_value">
					      <input class="select-box_input" type="radio" id="user_name" value="user_name" name="sel" checked="checked"/>
					      <p class="select-box_input-text">예약회원명</p>
					    </div>
					    <div class="select-box_value">
					      <input class="select-box_input" type="radio" id="user_phone" value="user_phone" name="sel"/>
					      <p class="select-box_input-text">예약회원연락처</p>
					    </div>
					    <img class="select-box_icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
					  </div>
					  <ul class="select-box_list" style="height: 100px; overflow: scroll;">
					    <li>
					      <label class="select-box_option" for="user_name" aria-hidden="aria-hidden">예약회원명</label>
					    </li>
					    <li>
					      <label class="select-box_option" for="user_phone" aria-hidden="aria-hidden">예약회원연락처</label>
					    </li>
					  </ul>
					</div>
					<input class="search" type="text" name="search" />
					<input class="btn" type="submit" value="검색" />
					<input class="btn" type="button" value="전체보기" onclick="window.location='adminReserveForm.jsp'"/>
				</div>
			<%} %>
			<h3 class="currentPage" style="color:black">현재 페이지 : <%=pageNum%></h3>
		</form>
	</div>
	<div id="footer">
      <img src="../imgs/logo2.png" width=100px; height=50px;>
     	<p>
			평일 10:00 - 17:00 | anitel@anitel.com <br /> <span id="info_text_btn">이용약관 </span> | <span id="tos_text_btn">취소정책
			</span> | <span id="info_text_btn"><a href="../board/list.jsp?categ=1" style="color:#fff;">1:1문의 </a></span><br> COPYRIGHT 콩콩이 ALLRIGHT Reserved.
		</p>
    </div>
</div>		
</body>
<%}//로그인 분기처리 else%>
</html>
