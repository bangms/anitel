
<%@page import="anitel.model.BookingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>결제페이지</title>
	<link rel="stylesheet" href="style/style.css">
	<link rel="stylesheet" href="style/reset.css">
	<%
	 String strReferer = request.getHeader("referer");
	 
	 if(strReferer == null){
	%>
	 <script language="javascript">
	  alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다.\n\n정상적인 경로를 통해 다시 접근해 주십시오.");
	  document.location.href="main.jsp";
	 </script>
	<%
	  return;
	 }
	%>
	<%
	request.setCharacterEncoding("UTF-8");
	String total_fee = request.getParameter("total_fee");
	%>
</head>
	<jsp:useBean id="dto" class="anitel.model.BookingDTO" />
	<jsp:setProperty property="*" name="dto" />
  
<body>
<%
	BookingDAO dao = BookingDAO.getInstance();

%>
 <div id="container">

	<div id="header">
		<div id="logo" onclick="window.location='main.jsp'">
			<img src="imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='board/list.jsp?categ=0'">공지사항</button>
     	<button id="mypage" onclick="window.location='userMypage/userMyPage.jsp'">마이페이지</button>
     	<button id="signout" onclick="window.location='logout.jsp'">로그아웃</button>
   	</div>
	</div>
  
  <!-- 여기서부터 콘텐츠 화면 입니다.  -->
  <div id="section">    
      	
      	<table style="border-collapse:collapse; border-radius:20px; border:1px white; background-color:#EBDDCA" >
      		<tr height = 50 align="center"> 
      			<td width = 500>
      				<br/>
      				<h1>Payment</h1>
      				<h2> <%= total_fee %></h2>
      				<input type="button" value="결제하기" onclick="fin()"/><br/><br/>
      				<input type="button" value="취소하기" onclick="window.location='/anitel/anitel/main.jsp'"/><br/><br/>
      				<br/>
      			</td>
      		</tr>
      	</table><br/>
      		
			
       </div>
        
 
     </div>
      
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
	<div id="footer">
		<img src="imgs/logo2.png" width=100px; height=50px;>
		<p>
			평일 10:00 - 17:00 | anitel@anitel.com <br /> <span	id="info_text_btn">이용약관 </span> | <span id="tos_text_btn">취소정책
			</span> | <span id="info_text_btn"><a href="board/list.jsp?categ=1" style="color:#fff;">1:1문의 </a></span><br> COPYRIGHT 콩콩이 ALLRIGHT Reserved.
		</p>
	</div>
</div>
</body>
<script type="text/javascript">
	function fin() {
		alert("결제 완료 되었습니다!");
		<% dao.insertBooking(dto); %>
		window.location='main.jsp';
	}
</script>
</html>
