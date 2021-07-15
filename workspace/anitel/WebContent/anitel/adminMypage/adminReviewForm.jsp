<%@page import="anitel.model.ReviewDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="anitel.model.BoardDTO"%>
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
	<link rel="stylesheet" href="../style/search.css">
</head>

<% 
	request.setCharacterEncoding("UTF-8");

	int pageSize = 10; // 한 페이지에 보여줄 정보의 수, 10개 출력할꺼니까 10

	//페이지 재호출하면 현재페이지 번호 요청함
	String pageNum = request.getParameter("pageNum"); 
	
	if(pageNum == null){ //adminReviewForm.jsp라고만 요청하여 pageNum 파라미터가 안넘어왔을때.
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
	
	List reviewList = null;
	
	if(selected != null && search != null){ // selected와 search가 null(파라미터 없음)이 아니면
		
		count = dao.getReviewSearchCount(selected, search);//검색조건으로 갯수받아옴
		if(count > 0){
			reviewList = dao.getSearchReview(startRow, endRow, selected, search);
		} // 끝번호 시작번호, 검색조건으로 출력
		
	}else{//selected와 search가 null이면
		count = dao.getReviewCount(); // 갯수 받아옴
		if(count > 0){
			reviewList = dao.getReview(startRow, endRow); // 끝번호 시작번호만으로 출력
		}
	}

	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		
	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid") == null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="/anitel/userLoginForm.jsp";
		</script>
<%	}else{ %>
<script>
		function chkReview() {
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
				var frm = document.frmReviewInfo		
				var url ="/anitel/anitel/adminMypage/adminReviewDeleteForm.jsp";
				window.open('','reviewdelete','width=500,height=300,location=no,status=no,scrollbars=yes');
				
				frmReviewInfo.action = url;
				frmReviewInfo.target = 'reviewdelete'
				frmReviewInfo.submit();
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
		<%if(count == 0) {%>
			<h3 align="center"> 표시할 내용이 없습니다. </h3>
		<%}else{%>
			<form action="adminReviewForm.jsp" name="frmReviewInfo" method="post">
			
				<div class="table_wrap">
			  <h2>호텔 후기 페이지</h2>
			  <ul class="responsive-table">
			    <li class="table-header">
			      <div class="col col-1" style="flex-basis: 5%;"></div>
			      <div class="col col-2" style="flex-basis: 15.833%;">작성일</div>
			      <div class="col col-3" style="flex-basis: 15.833%;">아이디</div>
			      <div class="col col-4" style="flex-basis: 15.833%;">호텔명</div>
			      <div class="col col-5" style="flex-basis: 15.833%;">제목</div>
			      <div class="col col-6" style="flex-basis: 15.833%;">상태</div>
			      <div class="col col-7" style="flex-basis: 15.833%;">답변여부</div>
			    </li>
			    
				<% // 반복문으로 게시판처럼 회원의 정보를 출력함. 
				int i;
					for(i = 0;i < reviewList.size(); i++){
						ReviewDTO review = (ReviewDTO)reviewList.get(i);
				%>
				
					<li class="table-row">
			      <div class="col col-1" style="flex-basis: 5%;" data-label="checkbox"><input type="checkbox" name="info" value="<%=review.getBoard_num()%>" /></div>
			      <div class="col col-2" style="flex-basis: 15.833%;" data-label="userID"><%=sdf.format(review.getReg_date())%></div>
			      <div class="col col-3" style="flex-basis: 15.833%;" data-label="userName"><%=review.getId()%></div>
			      <div class="col col-4" style="flex-basis: 15.833%;" data-label="userPhone"><%=review.getHotel_name()%></div>
			      <div class="col col-5" style="flex-basis: 15.833%;" data-label="userEmail"><a class="list_subject" href="../board/content.jsp?board_num=<%=review.getBoard_num()%>&categ=3"><%=review.getSubject()%></a></div>
			      <div class="col col-6" style="flex-basis: 15.833%;" data-label="userEmail">
			      	<%if(review.getComm() == 0){%>답변중
							<%}else if(review.getComm() == 1){%>답변완료<%}%>
			      </div>
			      <div class="col col-7" style="flex-basis: 15.833%;" data-label="userEmail">
			      	<%if(review.getComm() == 0){%>답변완료
						<%}else if(review.getComm() == 1){%>답변중<%}%>
						</div>
			    </li>				    
				<%}//후기 정보 출력리스트반복문 닫기%>
			  </ul>
			</div>
			<br />
			<div class="pageNum">
			
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
					<a href="adminReviewForm.jsp?pageNum=<%=startPage-pageBlock %>"> &lt; </a>
					&nbsp; &nbsp;
				<% } 
					
					//페이지 번호 뿌리기
					for(i = startPage; i <= endPage; i++){ %>
						<a href="adminReviewForm.jsp?pageNum=<%=i%>" class="pageNums"><%=i%></a>
						&nbsp; &nbsp;
				<%	}
					
					//오른쪽 꺾쇄 : 전체 페이지 개수(pageCount)가 endPage(현재 보는 페이지에서의 마지막번호)보다 크면
					if(endPage < pageCount) { %>
						<a href="adminReviewForm.jsp?pageNum=<%=startPage+pageBlock%>"> &gt; </a>
					&nbsp; &nbsp; 
				<% 	}
				
				}%>
			</div>
			<div class="search_wrap">
				<div id="sel" class="select-box">
				  <div class="select-box_current" tabindex="1">
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="id" value="id" name="selected" checked="checked"/>
				      <p class="select-box_input-text">아이디</p>
				    </div>
				    <div class="select-box_value">
				      <input class="select-box_input" type="radio" id="hotel_name" value="hotel_name" name="selected"/>
				      <p class="select-box_input-text">호텔명</p>
				    </div>
				    <img class="select-box_icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box_list" style="height: 100px; overflow: scroll;">
				    <li>
				      <label class="select-box_option" for="id" aria-hidden="aria-hidden">아이디</label>
				    </li>
				    <li>
				      <label class="select-box_option" for="hotel_name" aria-hidden="aria-hidden">호텔명</label>
				    </li>
				  </ul>
				</div>
				<input class="search" type="text" name="search"/>
				<input class="btn" type="submit" value="검색" />
				<input class="btn" type="button" value="삭제" onclick="chkReview();"/>
				<input class="btn" type="button" value="전체보기" onclick="window.location='adminReviewForm.jsp'"/>
			</div>
			 
			
			<%}//count이 0이 아닐때 if문 닫기%>
		</form>
	</div>
	<div id="footer">
      <img src="../imgs/logo2.png" width=100px; height=50px;>
      <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
      	이용약관 | 취소정책 | 1:1문의 <br/>
      	COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>  			
    </div>
</div>

</body>
<%}//로그인 분기처리%>
</html>