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
    <style>
      #container {
        width: 100%;
        margin: 0px auto;
        padding: 20px;
      }
      #header {
       height:100px;
     	width:100%;
        padding: 20px;
        margin-bottom: 20px;
        height: 100px;
      	top:0;
      	display: flex;
 		justify-content: space-between;
 		background-color:white;
 		position: sticky;
		top: 0;
      }
      #header logo{
      	width: 300px;
      	height:100px;
      }
      #header section{
     	width:1100px;
     	height:100px;
     	margin-right:300px;
      }
      #main{
      	position:relative;
      	width:100%;
      	overflow: auto;
      	height:500px;
   	

      }
      #content {
        width: 65%;
       	height:100%;
        padding: 20px;
        margin-bottom: 20px;
        margin-left:300px;
        margin-right:200px;
        padding-left:100px;
        padding-right:100px;
        float: left;
		padding-bottom:100px;
		z-index:3
      }
      #sidebar {
        width: 230px;
        padding: 20px;
        float: left;
        clear:both;
        background-color:#EBDDCA;
        margin-right:50px;
        margin-left:70px;
        position:fixed;
      }
      #footer {
      	height:80px;
      	width:100%;
        clear: both;
        padding: 20px;
        margin-left:-50px;
		padding-left:100px;
        left:0;
        bottom:0;
		background-color:black;
		color:white;
		overflow-y:hidden;
		overflow-x:hidden;
      }
      p{
      	margin-top:10px;
      	font-size: 13px;
      	margin-left : 200px;
      }
      img {
      	float:left; 
      	padding: 20px;
      	margin-top:-15px;
      	margin-left:40px;
      }
      ul{
      	font-size:20px
      }
      #button button{ 
      	font-weight:semi-bold;
      	border: none;
      	border-radius: 6px;
      	width: 110px;
      	height:40px;
      	font-size: 16px;
      	margin-top:30px;
      	position:relative;
      }
       #button button:hover{
      	background-color:#FF822B;
      	color:#ffffff;
      }
       #withdraw{ 
      	border: none;
      	border-radius: 3px;
      	width: 55px;
      	height:20px;
      	font-size: 8px;
      	margin-top:15px;
      	margin-left:100px;
      	position:relative;
      }
      	
      #login{
     	 background-color:#FFA742;
      	color:white;
   		float : right;   
   		margin-right: 5px;    	
      }
      #signin{
     	background-color:#FFA742;
      	color:white;
     	float : right;
     	margin-right: 5px;    	
     	
      }
      #notice{
      	float : right;
      	margin-right: 5px;    	
      	background-color:#ffffff;
      	color:black;
      	
      }
		A{
			text-decoration:none;
			color: black;
		}
		li{
			list-style:none;
			margin-bottom:10px;
		}
		input[type=text] { 
			border:1px solid black;
			border-radius:5px;
			height:30px;
			text-indent: 1em;
		 }
		 input[type=password] { 
			border:1px solid black;
			border-radius:5px;
			height:30px;
			text-indent: 1em;
		 }
		input[type=button] { 
			background-color:#FFA742;
	      	color:white;
	      	border: none;
	      	border-radius: 6px;
	      	width: 110px;
	      	height:40px;	
		}
		input[type=button]:hover{
	      	background-color:#FF822B;
	      	color:#ffffff;
	    }
		input[type=submit] { 
			background-color:#FFA742;
	      	color:white;
	      	border: none;
	      	border-radius: 6px;
	      	width: 110px;
	      	height:40px;	
		}
		input[type=submit]:hover{
	      	background-color:#FF822B;
	      	color:#ffffff;
	    }
	    input[type=checkbox]{
	      	width:14px;
	      	height:14px;
	      	border-radius: 3px;
	    } 
	    input[type=radio]{
	      	width:14px;
	      	height:14px;
	    }
		select, option{
			width:150px; 
			height:35px;
			border:1px solid black;
			border-radius:5px;
			text-indent: 1em;
		}
    </style>
  </head>

<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="../loginForm.jsp";
		</script>
<%	}else{ 
	//String id = (String)session.getAttribute("sid");
	String id = "test01";													// 테스트용 : 개발 끝나고 지워버려야댐
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO member = dao.getMemberHotel(id);
	System.out.println("memberBookingModifyForm - id : " + id);
	List userList = dao.getBookingList(id); 
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd");
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
			var url ="/anitel/memberMypage/memberBookingDeleteForm.jsp";
			window.open('','userdelete','width=500,height=150,location=no,status=no,scrollbars=yes');
			
			frmUserInfo.action = url;
			frmUserInfo.target = 'userdelete'
			frmUserInfo.submit();
		}			
	}
</script>
<body>
	<div id="container">
    
 <!-- 여기서부터 헤더  입니다.  -->
 	
      <div id="header">
      	<div id="logo">
       		 <img src="imgs/logo.png" width="200px" height="100px">
        </div>
 		<section>
       		 <div id="button">
        		<button id="notice">공지사항</button>
        		<button id="signin">회원가입</button>
   	     		<button id="login" onclick="window.location='/anitel/userLoginForm.jsp'">로그인</button>
       		 </div>
        </section>
      </div>
      
	<div id="main">
	
	<!-- 여기서부터 사이드바 입니다.  -->
      <div id="sidebar">
        <h1>마이페이지</h1>
        <ul>
          <li><a href="/anitel/memberMypage/memberMyPage.jsp">내 정보</a></li>
          <li><a href="/anitel/memberMypage/memberHInfo.jsp">호텔 정보</a></li>
          <li><a href="/anitel/memberMypage/memberBookingModifyForm.jsp">호텔 예약 관리</a></li>
          <li><a href="/anitel/memberMypage/memberQna.jsp">호텔 QnA 관리</a></li>
          <li><a href="/anitel/memberMypage/memberReview.jsp">호텔 후기 관리</a></li>
        </ul>
      </div>
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      
      <div id="content">
        <h1><%= member.getMember_name() %>님의 <%= member.getHotel_name() %> 호텔 예약 관리</h1>
      	<hr align="left" width=800 color="black">
      	<br/>
      	
      	<form action="/anitel/memberMypage/memberBookingModifyForm.jsp" name="frmUserInfo" method="post">
      	예정된 예약 일정
      	<table border=1>
      		<tr align="center">
      			<td>체크</td>
      			<td>객실명</td>
      			<td>예약날짜</td>
      			<td>체크인 날짜</td>
      			<td>체크아웃 날짜</td>
      			<td>예약자명</td>
      			<td>예약자 연락처</td>
      			<td>반려동물 이름</td>
      			<td>요청사항</td>
      		</tr>
<%			for(int i = 0; i < userList.size(); i++) {
					BKListDTO dto = (BKListDTO)userList.get(i); %>
      		<tr align="center">
      			<td><input type="checkbox" name="info" value="<%= dto.getBooking_num() %>"/></td>
      			<td><%= dto.getName() %></td>
      			<td><%= sdf.format(dto.getBooking_time()) %></td>
      			<td><%= sdf.format(dto.getCheck_in()) %></td>
      			<td><%= sdf.format(dto.getCheck_out()) %></td>
      			<td><%= dto.getUser_name() %></td>
      			<td><%= dto.getUser_phone() %></td>
      			<td><%= dto.getPet_name() %></td>
      			<td><%= dto.getRequests() %></td>
      		</tr>
<%			} %>
      	</table>
      	
      	<div>
      		<input type="button" value="삭제" onclick="chkUser();"/>
      		<input type="button" value="지난 예약 보기" onclick="window.location='/anitel/memberMypage/memberBookingAfterForm.jsp'" />
      	</div>
		</form>
       </div>
        
 
     </div>
      
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
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