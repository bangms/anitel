<%@page import="anitel.model.BoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="anitel.model.DetailDTO"%>
<%@page import="anitel.model.RoomDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>디테일페이지</title>
	<link rel="stylesheet" href="style/style.css">
 	<link rel="stylesheet" href="style/reset.css">
	<link rel="stylesheet" href="style/search.css">
	<link rel="stylesheet" href="style/datepicker.min.css">
	<script src="js/jquery-3.1.1.min.js"></script>
	<script src="js/datepicker.min.js"></script>
	<script src="js/datepicker.ko.js"></script>
	<script type="text/javascript" src="js/search.js"></script>
</head>
<style>

/* 메인페이지 height 100% 옵션주기 위한 div */
.box {
	height: 140px;
}

.main_form {
	width: 80%;
	position: absolute;
	left: 50%;
	transform: translate(-50%, 0);
	margin-top: 30px;
	text-align: center;
}

.search_bar {
	display:inline-flex;
}

</style>

<% 
String sid =(String)session.getAttribute("sid");
System.out.println("hotelDetail sid=" + sid);


request.setCharacterEncoding("UTF-8");
String id = request.getParameter("memId"); // 사업자아이디
System.out.println(id);
String check_in = request.getParameter("check_in");
String check_out = request.getParameter("check_out");
int pet_type = Integer.parseInt(request.getParameter("pet_type"));
 
%>
<jsp:useBean id="detail" class="anitel.model.DetailDTO" />
<jsp:setProperty property="*" name="detail"/>
<% 

 
System.out.println("체크인 : " + check_in + " / 체크아웃 : " + check_out + " / 동물 종류 : " + pet_type);

String petType[] = {"강아지", "고양이", "기타"};

//후기, qna 게시판 
int pageSize = 3;
String pageNum = request.getParameter("pageNum");
if(pageNum == null) {
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum); 
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;


//게시판
int categ = 0;
List reviewList = null;
int number = 0;
int count = 0;
	 
number = count - (currentPage-1)*pageSize;
 

RoomDAO dao = RoomDAO.getInstance();

//상단 호텔 정보 꺼내기 
DetailDTO dto = dao.getHotelDetail(id);  
String reg_num = dto.getReg_num();
System.out.println("reg_num=" + reg_num);

 //방 갯수 구하고 방 리스트 불러오기 
 
List roomList = null;
int roomCount =0;

roomCount = dao.getRoomCount(detail, id); 
System.out.println("count 페이지 => 방 개수 : " +roomCount + "\n\n");
if(roomCount > 0) {
roomList = dao.getRooms(detail, id);
} 
	
%>

<script type="text/javascript">
$(document).ready(function(){
	datePickerSet($("#check_in"), $("#check_out"), true); //다중은 시작하는 달력 먼저, 끝달력 2번째
	
});
</script>
<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='main.jsp'">
			<img src="imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='board/list.jsp?categ=0'">공지사항</button>
			<% 	
				if(session.getAttribute("sid") == null){ 
			%>
						<button id="signin" onclick="window.location='signIn.jsp'">회원가입</button>
						<button id="login" onclick="window.location='loginForm.jsp'">로그인</button>
						
			<%}else{
						BoardDAO board = BoardDAO.getInstance();  
						int checkID = board.idCk(id);
						System.out.println("아이디 체크 - 사업자면 2, 일반회원이면 1 : " + checkID);
						if(checkID == 1) { 
							if(session.getAttribute("sid").equals("admin")) { %><%-- 관리자 일 때 --%>
								<button id="mypage" onclick="window.location='adminMypage/adminMemberForm.jsp'">마이페이지</button>
						<%} else { %>
							<button id="mypage" onclick="window.location='userMypage/userMyPage.jsp'">마이페이지</button>
						<%}
						}
						if(checkID == 2) { %><%-- 사업자 일 때 --%>
							<button id="mypage" onclick="window.location='memberMypage/memberMyPage.jsp'">마이페이지</button>
					<%}%>	
						<button id="signout" onclick="window.location='logout.jsp'">로그아웃</button>
			<%}%>
		</div>
	</div>	
  <div id="section" class="detail_wrapper">
	  <p class="hotel_name">
	    <!-- 호텔이름 -->
	    <%= dto.getHotel_name() %>
	  </p>
	  <div class="info_wrapper">
	    <div class="img_wrap">
	      <ul>
	        <li class="main_img"></li>
	        <%if(dto.getHotel_img()!= null){%>
				<li><img src="/anitel/save/<%=dto.getHotel_img()%>" /></li>	
			<%}else{ %>
				<li><img src="/anitel/save/default.png"/></li>
			<%} %>	  
	      </ul>
	    </div>
	    
	    <div class="map">  
	  		 <p> 호텔 주소 </p> <%= dto.getHotel_area() %> 
	    </div>
	   
	    <div class="mini_review_wrap">
		<%
		categ = 3;
		System.out.println(categ);
		count = dao.reviewCount(id, categ);
		System.out.println("hotelaDetail-count : " + count);
		%>
		<div>후기</div>
	      <div class="mini_review_txt"></div>
	<% if(count == 0){ %>
		<table class="review">
	     		 <tr>
	       	 		<td colspan="2"><p class="empty"> 후기 게시글이 없습니다.</p></td>
	      		</tr>
	    	</table>
 	<%}else{
		reviewList = dao.getReviews(id, categ, startRow, endRow); %>
		  <table class="review">
	     <% for(int i = 0; i < reviewList.size(); i++) {
				DetailDTO article = (DetailDTO)reviewList.get(i);
			%>
	      <tr>
	         <td><%= article.getSubject() %></td>    
	      </tr>
	    </table>
  			<%}  	
	    }%> 
	    </div>
	  </div>
	  <div class="exp_wrap">
	  	  <div class="info"></div>
	  		<table>
	  			<tr> <td>호텔인포: <%= dto.getHotel_intro()%></td> </tr>
	  		</table> 
	  		<br />
	  			<p>편의시설</p>
   	 <div class="util"></div>
	  		<table>
	  			<tr>
	  				<td>무료시설 :</td>
	  				<%if("1".equals(dto.getUtil_pool())){ %>
	  					<td> 수영장 </td>
	  				<%} %>
	  				<%if("1".equals(dto.getUtil_ground())){ %>
	  					<td> 운동장 </td>
	  				<%} %>
	  				<%if("1".equals(dto.getUtil_parking())){ %>
	  					<td> 무료주차 </td>
	  				<%} %>
	  			</tr>
	  		</table>   
	  <div class="paid"></div>
	   		 <table>
	  			<tr>
	  				<td>유료시설 :</td>
	  				<%if("1".equals(dto.getPaid_bath())){ %>
	  					<td> 목 욕 </td>
	  				<%} %>
	  				<%if("1".equals(dto.getPaid_beauty())){ %>
	  					<td> 미 용 </td>
	  				<%} %>
	  				<%if("1".equals(dto.getPaid_medi())){ %>
	  					<td> 병 원 </td>
	  				<%} %>
	  			</tr>
	  		</table>
	  </div>
	  
	  <div class="search_wrap">
	    <form id="main_form" class="main_form" action="hotelDetail.jsp" method="post" name="searchForm" onsubmit="return check();">
	    	<input type="hidden" name="memId" value="<%= id%>" />
	    	<%System.out.println(id); %>
			<div class="search_bar" style="width:50%;">				
				<div class="double">
					<input id="check_in" class="check_date" type="text" name="check_in" value="<%=check_in %>" />
					<input id="check_out" class="check_date" type="text" name="check_out" value="<%=check_out %>" />
					 
				</div>

				<div id="pet" class="select-box" style="width:25%;">
				  <div class="select-box_current" tabindex="1">
				    <% for (int i = 0; i < petType.length; i++) { %>
				  		 <div class="select-box_value">
						      <input class="select-box_input" type="radio" id="pet_<%=i%>" value="<%=i%>" name="pet_type" <% if (i == pet_type) {
			  				%>checked="checked"<%	} %>/>
						      <p class="select-box_input-text"><%=petType[i]%></p>
						    </div>
				  <%	}
				  %>
				   <img class="select-box_icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box_list">
				  <%for (int i = 0; i < petType.length; i++) { %>
				  		<li>
				      <label class="select-box_option" for="pet_<%= i %>" aria-hidden="aria-hidden"><%= petType[i] %></label>
				    </li>
				  <%}%>
				  </ul>
				</div>
				<div class="search_btn_wrap" style="margin-left:10px;">
					<button class="search_btn">검색</button> 
				</div>
			</div>
		</form>
  </div>
	  
	  <div class="room_wrap">	
	    <ul>
	<%if(roomCount == 0){ %>
		<p class="empty">조건에 해당하는 방이 없습니다.</p>	 
	<%}else {
		for(int i = 0; i < roomList.size(); i++) {
			DetailDTO room  = (DetailDTO)roomList.get(i);
		%>
	      <li>
	      	방 번호 : <%=room.getRoom_num() %> 	<br />
	      	방 이름 : <%=room.getName()%>			<br />
	      	방 사진 : <img src="/anitel/save/<%=room.getImg()%>" /><br />
	      	방 가격 : (박)<%=room.getD_fee()%> 원	<br />
	      	대형견 수용여부 :<%=room.getPet_big() %> <br />
	      <button onclick="window.location='.jsp?memId=<%=room.getId()%>&room_num=<%=room.getRoom_num()%>&check_in=<%=room.getCheck_in()%>&check_out=<%=room.getCheck_out()%>'">예약하기</button>
	      </li>
	    <%} 
	} %>
	 </ul>	
	  </div>
<%if(sid == null){ //비 로그인시 %>
 <div class="review_wrap board">
	    <p>후기게시판</p>
	    <table class="review">
	      <tr>
	        <td>작성자</td>
	        <td>내용</td>
	      </tr>
	      <tr>
	        <td colspan="2"> 로그인 해주세요 </td>
	      </tr>
	    </table>
	  </div>
	  <div class="qna_wrap board">
	    <p>Q&A 게시판</p>
	    <table class="qna">
	      <tr>
	        <td>작성자</td>
	        <td>내용</td>
	      </tr>
	      <tr>
	        <td colspan="2"> 로그인 해주세요 </td>   
	      </tr>
	    </table>
	  </div>
  </div>
<%}else{ //로그인 후 %>
	<div class="review_wrap board">
	<%
	boolean check = false;
	categ= 3; 
	System.out.println(categ);
	count= dao.reviewCount(id, categ);   
	System.out.println("hotelaDetail-count : " + count);
	%>
	    <p>후기게시판</p>
	<% if(count == 0){ %>
	    	<table class="review">
	     	 <tr>
	      	  	<td>작성자</td>
	       	 	<td>내용</td>
	      	</tr>
	      	<tr>
	        	<td colspan="2"><p class="empty"> 후기 게시글이 없습니다.</p></td>
	      	</tr>
	    	</table>    	
	<%}else{
		reviewList = dao.getReviews(id, categ, startRow, endRow); %>
		  <table class="review">
	     	<tr>
	        	<td>작성자</td>
	        	<td>제 목</td>
	      	</tr>
	<% for(int i = 0; i < reviewList.size(); i++) {
		DetailDTO article = (DetailDTO)reviewList.get(i);
	%>
		   	 <tr>
	        	 <td>익명</td>
	         	<td><a href="../anitel/board/content.jsp?board_num=<%= article.getBoard_num()%>&categ=3"><%= article.getSubject() %></a></td>    
	      	</tr>
	    	</table>
	 			<%}  	
	    }%>  
	    <!-- TODO : 결제한 고객만 쓸 수 있도록 분기처리  -->
	    <%check = dao.paymentUserCk(sid,reg_num); 
	    if(check) {%>
	    <button onclick="window.location='../anitel/board/writeForm.jsp?reg_num=<%=dto.getReg_num()%>&categ=3'">글쓰기</button> 
	    <%} %>
	    
	  </div>
		  
		  <div class="qna_wrap board">
		 	<%
		 	categ= 2; 
		 	System.out.println(categ);
		 	count= dao.reviewCount(id, categ);   
			System.out.println("hotelaDetail-count : " + count);
			%>
		 	<p>Q&A 게시판</p>
    <% if(count == 0){ %>
		    	<table class="qna">
		      		<tr>
		        		<td>작성자</td>
		        		<td>내용</td>
		      		</tr>
		     		 <tr>
		        		<td colspan="2"><p class="empty"> Q&A 게시글이 없습니다.</p></td>
		      		</tr>
		    	</table>
     <%}else{
    	 	reviewList = dao.getReviews(id, categ, startRow, endRow); %>
		       	<table class="qna">
		     		 <tr>
		        		<td>작성자</td>
		        		<td>제 목</td>
		      		</tr>
		      		
     <% for(int i = 0; i < reviewList.size(); i++) {
			DetailDTO article = (DetailDTO)reviewList.get(i);
		%> 
		
		<script type="text/javascript">
        	 function secret(board_num, pageNum, categ) {
            var url = "../anitel/board/popCheckPw.jsp?pageNum=" + pageNum + "&board_num=" + board_num + "&categ=" + 2;
            window.open(url,"checkPw","toolbar=no, location=no, status=no, menubar=no, scrollbars=no resizeable=no, width=300, height=200");
       		  }
		</script>
		     		 <tr>
		         		<td><%=article.getId() %></td>
		         		<%if(sid == null) { // 팝업 - 로그인이 필요한 페이지 입니다. %> 
		         		<td><a onclick="secret(<%=article.getBoard_num()%>, <%=categ%>)">[비밀글] <%=article.getSubject() %></a></td> 
		         		<!-- 비밀글 // sid 가 사업자거나 어드민인 경우 비번 입력 x  --> 
		         		<%}else if(session.getAttribute("sid").equals("memId") || (session.getAttribute("sid").equals("admin"))){
		         			System.out.println("HD sid, memId =" + sid + "," + id);%> 
		         		<td><a href="../anitel/board/content.jsp?board_num=<%= article.getBoard_num()%>&categ=2">[비밀글]<%= article.getSubject() %></a></td>   
		         		<%}else{ %>
		         		<td><a onclick="secret(<%=article.getBoard_num()%>, <%=categ%>)">[비밀글] <%=article.getSubject() %></a></td>   
		      			<%} System.out.println("memId" + "==" + id); %>
		      		</tr>
		    </table>
 			<%}  	
    }%>
     
		    <button onclick="window.location='../anitel/board/writeForm.jsp?reg_num=<%=dto.getReg_num()%>&categ=2'">문의하기</button> 
		  </div>
	  </div>
	  
<%} %>
 	<div id="footer">
	 <img src="imgs/logo2.png" width=100px; height=50px;>
	 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
	 이용약관 | 취소정책 | 1:1문의 <br/>
		COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
 </div>
</body>
</html>