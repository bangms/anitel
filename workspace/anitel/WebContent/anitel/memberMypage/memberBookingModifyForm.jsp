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
		<link rel="stylesheet" href="../style/search.css">
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
	MemberDTO member = dao.getMemberHotel(id);
	System.out.println("memberBookingModifyForm - id : " + id);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
	
	// 게시글 10개 노출, 페이징 처리
	int pageSize = 5;

	//현재 페이지 번호
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) { pageNum = "1"; }

	// 현재 페이지에 보여줄 게시글 시작과 끝 등등 정보 세팅 
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
		
	List userList = null; 
		
	String sel = request.getParameter("sel");
	System.out.println(sel);
	String search = request.getParameter("search");
	System.out.println(search);
		
	if(sel != null && search != null) {
		// 검색한 경우
		count = dao.getBookingSearchCount(id, sel, search); 
		if(count > 0) {
			userList = dao.getBookingListSearch(id, startRow, endRow, sel, search);
		}
	}else {
		// 검색하지 않은 경우
		count = dao.getBookingCount(id);
		if(count > 0) {
			userList = dao.getBookingList(id, startRow, endRow); 
		}		
	}
	
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
					    	<li class="menu"><a href="member1_1.jsp">1:1문의</a></li>
					    </ul>
					  </nav>
					</div>
				</div>
      </div>
      
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      <div id="section" style="padding-left:15%; margin-left:40px;">
	      <div class="info_wrap" >
					<h1><%= member.getMember_name() %>님의 <span style="color:#FF822B !important"><%= member.getHotel_name() %></span> 호텔 예약 관리 </h1>
		      <hr/>
				</div>
      <div class="table_wrap" style="width:90%;">
		<%	if(userList==null) { %>
					<p style="padding:100px 0">현재 예정된 예약이 없습니다.</p>
				<div class="btn_wrap">
					<input type="button" value="지난 예약 보기" onclick="window.location='memberBookingAfterForm.jsp'" style="padding: 20px 30px; font-size: 1em; border-radius: 10px;" />
				</div>
		<% 	}else{ %>      	
      	<form action="memberBookingModifyForm.jsp" name="frmUserInfo" method="post">
      	<ul class="responsive-table">
      		<li class="table-header">
      			<div class="col col-1" style="flex-basis: 5%;"></div>
      			<div class="col col-2" style="flex-basis: 10%;">객실명</div>
      			<div class="col col-3" style="flex-basis: 10%;">예약날짜</div>
      			<div class="col col-4" style="flex-basis: 10%;">체크인 날짜</div>
      			<div class="col col-5" style="flex-basis: 10%;">체크아웃 날짜</div>
      			<div class="col col-6" style="flex-basis: 10%;">예약자명</div>
      			<div class="col col-7" style="flex-basis: 15%;">예약자 연락처</div>
      			<div class="col col-8" style="flex-basis: 10%;">반려동물 이름</div>
      			<div class="col col-9" style="flex-basis: 20%;">요청사항</div>
      		</li>
<%			for(int i = 0; i < userList.size(); i++) {
					BKListDTO dto = (BKListDTO)userList.get(i); %>
      		<li class="table-row">
      			<div class="col col-1" style="flex-basis: 5%;"><input type="checkbox" name="info" value="<%= dto.getBooking_num() %>"/></div>
      			<div class="col col-2" style="flex-basis: 10%;"><%= dto.getName() %></div>
      			<div class="col col-3" style="flex-basis: 10%;"><%= sdf.format(dto.getBooking_time()) %></div>
      			<div class="col col-4" style="flex-basis: 10%;"><%= sdf.format(dto.getCheck_in()) %></div>
      			<div class="col col-5" style="flex-basis: 10%;"><%= sdf.format(dto.getCheck_out()) %></div>
      			<div class="col col-6" style="flex-basis: 10%;"><%= dto.getUser_name() %></div>
      			<div class="col col-7" style="flex-basis: 15%;"><%= dto.getUser_phone() %></div>
      			<div class="col col-8" style="flex-basis: 10%;"><%= dto.getPet_name() %></div>
      			<div class="col col-9" style="flex-basis: 20%;">
      				<%if(dto.getRequests()==null){ %>
      					-
      				<%}else{ %>
      					<%= dto.getRequests() %>
      				<%} %>
      			</div>
      		</li>
<%			} %>
      	</ul>
      		<table>
      			<tr>
      				<td align="left" width=400><input style="padding:10px 20px; border-radius:6px;" type="button" value="선택예약 취소" onclick="chkUser();"/></td>
      			</tr>
      		</table>
			</div>

	<br/>
	<div>
<%
				int pageBlock = 3;
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				int startPageNum = (int)(currentPage-1)/(pageBlock) * pageBlock + 1;
				int endPageNum = startPageNum + pageBlock -1;
				if(endPageNum > pageCount) endPageNum = pageCount;
				
				if(sel != null && search != null) {
					if(startPageNum > pageBlock) {	%>			
					<a href="memberBookingModifyForm.jsp?pageNum=<%=startPageNum-pageBlock%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &lt; </a>	&nbsp;	
					<%}
				
					for(int i = startPageNum; i <= endPageNum; i++) { %>		
						<a href="memberBookingModifyForm.jsp?pageNum=<%=i%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &nbsp; <%=i %> &nbsp; </a>
					<%}
			
					if(endPageNum < pageCount) {	%>			
						&nbsp; <a href="memberBookingModifyForm.jsp?pageNum=<%=startPageNum+pageBlock%>&sel=<%=sel%>&search=<%=search%>" class="pageNums"> &gt; </a>
					<%}		
				}else {
					if(startPageNum > pageBlock) {	%>			
					<a href="memberBookingModifyForm.jsp?pageNum=<%=startPageNum-pageBlock%>" class="pageNums"> &lt; </a>	&nbsp;	
					<%}
				
					for(int i = startPageNum; i <= endPageNum; i++) { %>		
						<a href="memberBookingModifyForm.jsp?pageNum=<%=i%>" class="pageNums"> &nbsp; <%=i %> &nbsp; </a>
					<%}
			
					if(endPageNum < pageCount) {	%>			
						&nbsp; <a href="memberBookingModifyForm.jsp?pageNum=<%=startPageNum+pageBlock%>" class="pageNums"> &gt; </a>
					<%}%>
				<%} %>
			</div>
			<br />	
			<div>		
			<div class="search_wrap" style="padding:40px 0">
				<div id="sel" class="select-box">
				  <div class="select-box_current" tabindex="1">
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="b.user_name" value="b.user_name" name="selected" checked="checked"/>
				      <p class="select-box_input-text">예약자명</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="b.user_phone" value="b.user_phone" name="selected"/>
				      <p class="select-box_input-text">예약자 연락처</p>
				    </div>
				    <img class="select-box_icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box_list" style="height: 100px; overflow: scroll;">
				    <li>
				      <label class="select-box_option" for="b.user_name" aria-hidden="aria-hidden">예약자명</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="b.user_phone" aria-hidden="aria-hidden">예약자 연락처</label>
				    </li>
				  </ul>
				</div>
				<input class="search" type="text" name="search"/>
				<input class="btn" type="submit" value="검색" />
				<input type="button" value="원래대로" onclick="window.location='memberBookingModifyForm.jsp'" style="margin-right: 5px;"/>
				<input type="button" value="지난 예약 보기" onclick="window.location='memberBookingAfterForm.jsp'" />
			</div>
			
				<h3 style="color:black; padding-bottom:100px;">현재 페이지 : <%=pageNum%></h3>
			</div>
		</form>
	<%	} %>
	</div>
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
