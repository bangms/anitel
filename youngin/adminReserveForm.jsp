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
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
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
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
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
      	<div id="logo">
       		 <img src="imgs/logo.png" width="200px" height="100px">
        </div>
 		<section>
       		 <div id="button">
        		<button id="notice" onclick="window.location='list.jsp'">공지사항</button>
        		<button id="admypage" onclick="window.location='adminUserForm.jsp'">마이페이지</button>
        		<button id="adname">관리자</button>
       		 </div>
        </section>
      </div>
      <div id="main">
	      <div id="sidebar">
	        <h1>관리자 페이지</h1>
	        <ul>
	          <a href="adminUserForm.jsp"><li>회원관리</li></a>
	          <a href="adminMemberForm.jsp"><li>사업자 관리</li></a>
	          <a href="adminReserveForm.jsp"><li>예약 관리</li></a>
	          <a href="adminReviewForm.jsp"><li>후기 관리</li></a>
	          <a href=""><li>공지사항</li></a>
	          <a href="adminMemberQnAForm.jsp"><li>사업자 1:1문의</li></a>
	          <a href="adminUserQnAForm.jsp"><li>일반회원 1:1문의</li></a>
	        </ul>
	      </div>
	      <div id="content">
		<% if(count == 0) { %>
			<h3 align="center">표시할 내용이 없습니다.</h3>
		<%}else {%>
		<form action="adminReserveForm.jsp" name="frmUserInfo" method="post">
			<table>		
				<tr align="center">
					<th> </th>
					<th> 호텔이름 </th>
					<th> 객실명 </th>
					<th> 예약날짜 </th>
					<th> 체크인 날짜 </th>
					<th> 예약회원명 </th>
					<th> 예약회원 전화번호 </th>
					<th> 동물정보 </th>
					<th> 세부/추가요청사항 </th>
					<th> 결제완료여부 </th>
				</tr>			
				<%
				for(int i = 0; i < bookingList.size(); i++) {
					BKListDTO hotel = (BKListDTO)bookingList.get(i); 
				%>
				<tr>
					<td align="center">
						<input type="checkbox" name="info" value="<%=hotel.getBooking_num()%>" />
					</td>
					<td> <%=hotel.getHotel_name() %> </td>
					<td> <%=hotel.getName() %> </td>
					<td> <%=sdf.format(hotel.getBooking_time()) %> </td>
					<td> <%=sdf.format(hotel.getCheck_in()) %> </td>
					<td> <%=hotel.getUser_name() %> </td>
					<td> <%=hotel.getUser_phone() %> </td>
					<td> <%=hotel.getPet_name() %> </td>
					<td> <%=hotel.getRequests() %> </td>
					<td align="center"> 
						<%if(hotel.getPayment() == 0) {%>
						<button>결제중</button>
						<%}else if(hotel.getPayment() == 1){ %>
						<button>결제완료</button>
						<%}else if(hotel.getPayment() == 2){%>
						<button>결제취소</button>
						<%} %>
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
			<br />	
			<div>		
				<select name="sel">
					<option value="user_name">예약자이름</option>
					<option value="user_phone">연락처</option>		
				</select>
				<input type="hidden" name="blank" />
				<input type="text" name="search" />
				<input type="submit" value="검색" />
				<input type="button" value="예약취소" onclick="chkUser();"/>
			</div>
		</form>
		</div>
	</div>
	<div id="footer">
      <img src="imgs/logo2.png" width=100px; height=50px;>
      <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
      	이용약관 | 취소정책 | 1:1문의 <br/>
      	COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>  			
    </div>
</div>		
</body>
</html>