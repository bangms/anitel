<%@page import="anitel.model.AdminDAO"%> 
<%@page import="java.util.List"%>
<%@page import="anitel.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
</head>

<% 
	request.setCharacterEncoding("UTF-8");

		int pageSize = 10; // 한 페이지에 보여줄 정보의 수, 10개 출력할꺼니까 10
	
	
	
		//페이지 재호출하면 현재페이지 번호 요청함
		String pageNum = request.getParameter("pageNum"); 
		
		if(pageNum == null){ //adminMemberForm.jsp라고만 요청하여 pageNum 파라미터가 안넘어왔을때.
			pageNum = "1";
		}
		
		//현재 페이지에 보여줄 게시글 시작과 끝 등등 정보 세팅
				int currentPage = Integer.parseInt(pageNum);
				int startRow = (currentPage -1) * pageSize + 1;
				int endRow = currentPage * pageSize; 
				
				int count = 0; 
					
		String selected = request.getParameter("selected");
		String search = request.getParameter("search");
		AdminDAO dao = AdminDAO.getInstance();
		List memberList = null;
		
		if(selected != null && search != null){ // selected와 search가 null(파라미터 없음)이 아니면
			
			count = dao.getMemberSearchcount(selected, search);//검색조건으로 갯수받아옴
			if(count > 0){
				memberList = dao.getSearchMember(startRow, endRow, selected, search);
			} // 끝번호 시작번호, 검색조건으로 출력
			
		}else{//selected와 search가 null이면
			count = dao.getMembercount(); // 갯수 받아옴
			if(count > 0){
				memberList = dao.getMember(startRow, endRow); // 끝번호 시작번호만으로 출력
			}
		}

		
		
		
%>
<script>
		function chkMember() {
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
				var frm = document.frmMemberInfo		
				var url ="/anitel/anitel/adminMypage/adminMemberDeleteForm.jsp";
				window.open('','memberdelete','width=500,height=300,location=no,status=no,scrollbars=yes');
				
				frmMemberInfo.action = url;
				frmMemberInfo.target = 'memberdelete'
				frmMemberInfo.submit();
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
		<%if(count == 0) {%>
			<h3 align="center"> 표시할 내용이 없습니다. </h3>
		<%}else{%>
				<form action="adminMemberForm.jsp" name="frmMemberInfo" method="post">
					<table>
						<tr>
							<td><%--체크박스용 빈칸--%></td>
							<td>사업자 ID</td>
							<td>사업장명</td>
							<td>사업장 위치</td>
							<td>대표자 이름</td>
							<td>사업자 번호</td>
							<td>상태</td>
							<td>관리자 승인</td>
						</tr>
						<% // 반복문으로 게시판처럼 회원의 정보를 출력함. 
						int i;
							for(i = 0;i < memberList.size(); i++){
								MemberDTO member = (MemberDTO)memberList.get(i); 
						%>
						<tr>
							<td><input type="checkbox" name="info" value="<%=member.getId()%>" /></td>
							<td><%=member.getId()%></td>
							<td><%=member.getHotel_name()%></td>
							<td><%=member.getHotel_add()%></td>
							<td><%=member.getHotel_owner()%></td>
							<td><%=member.getReg_num()%></td>
							<td><%if(member.getMember_approved() == 0){%>승인대기
							<%}else if(member.getMember_approved() == 1){%>승인완료
							<%}else if(member.getMember_approved() == 2){%>승인보류<%}%></td>
							<td>
								<button type="button" onClick="window.open('adminApproveForm.jsp?Id=<%=member.getId()%>','width=500,height=300,location=no,status=no,scrollbars=yes')" <%if(member.getMember_approved() == 1 ){%>disabled="true"<%}%>>승인하기</button>
								<button type="button" onClick="window.open('adminConfirmRegNumForm.jsp?Id=<%=member.getId()%>','width=500,height=300,location=no,status=no,scrollbars=yes')" >보류하기</button>
							</td>
						</tr>
						<%}//사업자정보출력리스트반복문 닫기%>
					
					</table>

				<% if(count > 10){
						
						int pageBlock = 10;
						int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
						int startPage = (int)((currentPage-1)/pageBlock) * pageBlock + 1;
						int endPage = startPage * pageBlock -1;
				
						//전체 페이지수(pageCount)가 위에서 계산한 endPage(10단위씩)보다 작으면
						//전체 페이지수가  endPage가 된다.
						if(endPage > pageCount) endPage = pageCount;
						
						//왼쪽 꺾쇄 : StartPage가 pageBlock(10)보다 크면
						if(startPage > pageBlock){ %>
						<a href="adminMemberForm.jsp?pageNum=<%=startPage-pageBlock %>"> &lt; </a>
						&nbsp; &nbsp;
					<% } 
						
						//페이지 번호 뿌리기
						for(i = startPage; i <= endPage; i++){ %>
							<a href="adminMemberForm.jsp?pageNum=<%=i%>" class="pageNums"><%=i%></a>
							&nbsp; &nbsp;
					<%	}
						
						//오른쪽 꺾쇄 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막번호)보다 크면
						if(endPage < pageCount) { %>
							<a href="adminMemberForm.jsp?pageNum=<%=startPage+pageBlock%>"> &gt; </a>
						&nbsp; &nbsp; 
					<% 	}
					
					}%>
				<br />
				<select size="1" name="search">
					<option value="id" selected>사업자 ID</option>
					<option value="hotel_name">사업장 명</option>
					<option value="hotel_owner">대표자 이름</option>
					<option value="reg_num">사업자 번호</option>
				</select>
				
				<input type="text" name="text">
				<input type="submit" value="검색" >
				<button type="button" onclick="chkMember()" >삭제</button>
				<%}//count이 0이 아닐때 if문 닫기%>
		</form>
	</div>
 	<!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
	<div id="footer" style="margin-top:-120px">
		 <img src="../imgs/logo2.png" width=100px; height=50px;>
		 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
		 이용약관 | 취소정책 | 1:1문의 <br/>
			COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
	</div>
</div>
</body>
</html>