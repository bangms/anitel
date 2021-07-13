<%@page import="anitel.model.BKListDTO"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>지난 예약 목록</title>
 	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
</head>
<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ 
	String id = (String)session.getAttribute("sid");
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO member = dao.getMemberHotel(id);
	System.out.println("memberBookingModifyForm - id : " + id);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");

	// 게시글 10개 노출, 페이징 처리
	int pageSize = 10;

	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) { pageNum = "1"; }

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	
	List userList = dao.getAfterBookingList(id, startRow, endRow); 
	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	
	if(sel != null && search != null) {
		// 검색한 경우
		count = dao.getBookingSearchCount(id, sel, search); 
		if(count > 0) {
			userList = dao.getAfterBookingListSearch(id, startRow, endRow, sel, search);
		}
	}else {
		// 검색하지 않은 경우
		count = dao.getBookingCount(id);
		if(count > 0) {
			userList = dao.getAfterBookingList(id, startRow, endRow);
		}		
	}
%>
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
		<% if(count == 0) { %>
			<h3 align="center">표시할 내용이 없습니다.</h3>
		<%}else {%>
		<form action="/anitel/memberMypage/memberBookingAfterForm.jsp" name="frmUserInfo" method="post">
			<table border=1>		
				<tr align="center">
      				<td>객실명</td>
      				<td>예약날짜</td>
      				<td>체크인 날짜</td>
      				<td>체크아웃 날짜</td>
      				<td>예약자명</td>
      				<td>예약자 연락처</td>
      				<td>반려동물 이름</td>
      				<td>요청사항</td>
      				<td>예약상태</td>
				</tr>			
				<%
				for(int i = 0; i < userList.size(); i++) {
					BKListDTO dto = (BKListDTO)userList.get(i);	%>
				<tr align="center">
					<td><%= dto.getName() %></td>
      				<td><%= sdf.format(dto.getBooking_time()) %></td>
      				<td><%= sdf.format(dto.getCheck_in()) %></td>
      				<td><%= sdf.format(dto.getCheck_out()) %></td>
      				<td><%= dto.getUser_name() %></td>
      				<td><%= dto.getUser_phone() %></td>
      				<td><%= dto.getPet_name() %></td>
      				<td><%= dto.getRequests() %></td>
      				<td>
<%					if(dto.getBooking_status()==0){ %>
      					종료됨
<%					}else if(dto.getBooking_status()==1){ %>
						취소됨
<%					} %>
      				</td>
				</tr>
				<%} %>
			</table>
			<%} %>
			<br />
			<div>
				<%
				int pageBlock = 3;
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				int startPageNum = (int)(currentPage-1)/(pageBlock) * pageBlock + 1;
				int endPageNum = startPageNum + pageBlock -1;
				if(endPageNum > pageCount) endPageNum = pageCount;
				
				if(sel != null && search != null) {
					if(startPageNum > pageBlock) {	%>			
					<a href="adminUserForm.jsp?pageNum=<%=startPageNum-pageBlock%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &lt; </a>	&nbsp;	
					<%}
				
					for(int i = startPageNum; i <= endPageNum; i++) { %>		
						<a href="adminUserForm.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &nbsp; <%=i %> &nbsp; </a>
					<%}
			
					if(endPageNum < pageCount) {	%>			
						&nbsp; <a href="adminUserForm.jsp?pageNum=<%=startPageNum+pageBlock%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &gt; </a>
					<%}		
				}else {
					if(startPageNum > pageBlock) {	%>			
					<a href="adminUserForm.jsp?pageNum=<%=startPageNum-pageBlock%>" class="pageNums"> &lt; </a>	&nbsp;	
					<%}
				
					for(int i = startPageNum; i <= endPageNum; i++) { %>		
						<a href="adminUserForm.jsp?pageNum=<%=i%>" class="pageNums"> &nbsp; <%=i %> &nbsp; </a>
					<%}
			
					if(endPageNum < pageCount) {	%>			
						&nbsp; <a href="adminUserForm.jsp?pageNum=<%=startPageNum+pageBlock%>" class="pageNums"> &gt; </a>
					<%}%>
				<%} %>
			</div>
			<br />	
			<div>		
				<select name="sel">
					<option value="p.id">예약자 아이디</option>
					<option value="b.user_phone">예약자 연락처</option>		
				</select>
				<input type="hidden" name="blank" />
				<input type="text" name="search" />
				<input type="submit" value="검색" />
				<input type="button" value="현재 예약 보기" onclick="window.location='memberBookingModifyForm.jsp'" />
			</div>
		</form>
	</div>
	<div id="footer">
      <img src="imgs/logo2.png" width=100px; height=50px;>
      <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
      	이용약관 | 취소정책 | 1:1문의 <br/>
      	COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>  			
    </div>
</div>		
</body>
<%	} %>
</html>