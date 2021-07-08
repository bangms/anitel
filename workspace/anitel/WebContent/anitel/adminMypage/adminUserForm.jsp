<%@page import="anitel.model.UsersDTO"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adminUser</title>
	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
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
	
	List userList = dao.getUserList(startRow, endRow);
	
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	
	if(sel != null && search != null) {
		count = dao.getUserSearchCount(sel, search); 
		if(count > 0) {
			userList = dao.getUserSearch(startRow, endRow, sel, search);
		}
	}else {
		count = dao.getUserCount();
		if(count > 0) {
			userList = dao.getUserList(startRow, endRow);
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
				var url ="/anitel/anitel/adminMypage/adminUserDeleteForm.jsp";
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
			<button id="mypage" onclick="window.location='adminMemberForm.jsp'">마이페이지</button>
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
		<form action="adminUserForm.jsp" name="frmUserInfo" method="post">
			<table>		
				<tr align="center">
					<th> </th>
					<th> 회원아이디 </th>
					<th> 회원명 </th>
					<th> 연락처 </th>
					<th> 이메일 </th>
				</tr>			
				<%
				for(int i = 0; i < userList.size(); i++) {
					UsersDTO user = (UsersDTO)userList.get(i);	
				%>
				<tr>
					<td align="center">
						<input type="checkbox" name="info" value="<%=user.getId()%>" />
					</td>
					<td> <%=user.getId() %></td>
					<td> <%=user.getUser_name() %></td>
					<td> <%=user.getUser_phone() %></td>
					<td> <%=user.getUser_email() %></td>
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
					<option value="id">회원아이디</option>
					<option value="user_phone">연락처</option>		
				</select>
				<input type="hidden" name="blank" />
				<input type="text" name="search" />
				<input type="submit" value="검색" />
				<input type="button" value="삭제" onclick="chkUser();"/>
			</div>
		</form>
		</div>
	</div>
	<div id="footer">
      <img src="../imgs/logo2.png" width=100px; height=50px;>
      <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
      	이용약관 | 취소정책 | 1:1문의 <br/>
      	COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>  			
    </div>
</div>		
</body>
</html>