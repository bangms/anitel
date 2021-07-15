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
	<link rel="stylesheet" href="../style/search.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
							</ul>
						</nav>
					</div>
				</div>
			</div>

			<!-- 여기서부터 콘텐츠 화면 입니다.  -->
      <div id="section" style="padding-left:15%; margin-left:40px;">
				<button class="t_btn" style="width: 150px; padding: 10px 0; height: auto;" onclick="location='userMyReserve.jsp?num=2'">투숙예정 예약</button>
				<button class="t_btn" style="width: 150px; padding: 10px 0; height: auto;" onclick="location='userMyReserve.jsp?num=0'">투숙완료 예약</button>
				<button class="t_btn" style="width: 150px; padding: 10px 0; height: auto;" onclick="location='userMyReserve.jsp?num=1'">취소된예약</button>

				<hr align="left" width=1000 color="black">
				<br />
				<%if(count == 0){ %><h3>예약이 없습니다.</h3>
				<%}else{%>

				<%for(int i = 0; i < reserveList.size(); i++){ 
					ReserveDTO reserve = (ReserveDTO)reserveList.get(i);
					%>

					<input type="hidden" class="booking_num" value="<%=reserve.getBooking_num()%>" /> 
					<input type="hidden" class="reg_num" value="<%=reserve.getReg_num()%>" />

				<table>
					<tr>
						<td colspan="3" bgcolor="#ffffff" height="5px"></td>
					</tr>

					<tr>
						<td width="250px" height="250px" rowspan="2">
							<img src="/anitel/anitel/imgs/logo.jpg" width=250px><br />
						</td>
						<td width="500px" height="30px">
							<h3><%=reserve.getHotel_name()%></h3> 
							체크인 <%=sdf.format(reserve.getCheck_in())%>- 체크아웃 <%=sdf.format(reserve.getCheck_out())%><br /> 
							<input type="hidden" id="booking_num" value="<%=reserve.getBooking_num()%>" /> 예약번호 <%=reserve.getBooking_num()%>
							<%=reserve.getReg_num() %>
						</td>
						<td width="130px">
							<%if(reserve.getBooking_status() ==0){ %><h4 style="color: blue">투숙완료</h4> 
							<%}else if(reserve.getBooking_status()==2){ %><h4 style="color: red">투숙 예정</h4> 
							<%}else if(reserve.getBooking_status()==1){ %><h4 style="color: grey">취소됨</h4> <%} %>
						</td>
					</tr>
					<tr>
						<td height="160px">반려동물 이름 : <%=reserve.getPet_name() %><br />
							<br /> 유료서비스 이용 여부 : 
							<input type="checkbox" name="paid_bath" value="1" <%=1==(reserve.getPaid_bath())? "checked":"" %>>목욕 
							<input type="checkbox" name="paid_beauty" value="1" <%=1==(reserve.getPaid_beauty())? "checked":"" %>> 미용 
							<input type="checkbox" name="paid_medi" value="1" <%=1==(reserve.getPaid_medi())? "checked":"" %>> 병원
							<br />
							<br /> 
							추가 요청사항 : <%=reserve.getRequests() == null ? "" : reserve.getRequests() %>
							<br />
						</td>
					</tr>
					<tr>
						<td colspan="3" align="right">
							<%if(reserve.getBooking_status() ==0){ %>
							<button id="withdraw" onclick="location='../board/writeForm.jsp?categ=3&amp;reg_num=<%=reserve.getReg_num()%>'">후기쓰기</button>
							<%}else if(reserve.getBooking_status()==2){ %>
							<button id="withdraw" onclick="check(<%=reserve.getBooking_num()%>)">예약취소</button>&emsp;
							<%}%>
						</td>
					</tr>
					<tr>
						<td colspan="3" bgcolor="#ffffff" height="5px"></td>
					</tr>
					<tr>
						<td colspan="3" bgcolor="#111111" height="1px"></td>
					</tr>
					<%}//리스트가 있는만큼 반복%>
				</table>
				<br />
				<%}//count 0일시 분기처리%>
			</div>

		<!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->
		<div id="footer">
			<img src="../imgs/logo2.png" width=100px; height=50px;>
			<p>
				평일 10:00 - 17:00 | anitel@anitel.com <br /> 이용약관 | 취소정책 | 1:1문의 <br />
				COPYRIGHT 콩콩이 ALL RIGHT Reserved.
			</p>

		</div>
	</div>

</body>
<script type="text/javascript">
function check(booking_num){
	//var booking_num= $("#booking_num").val();
	console.log(booking_num);
	var popUrl = "/anitel/anitel/userMyPage/userCancelForm.jsp?booking_num="+ booking_num;	//팝업창에 출력될 페이지 URL
	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);

	}
	

</script>

<%}%>
</html> 
