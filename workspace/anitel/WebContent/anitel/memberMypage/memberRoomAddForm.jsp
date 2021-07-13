<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="anitel.model.RoomDTO"%>
<%@page import="anitel.model.RoomDAO"%>
<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>객실 수정</title>
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
			width : 140px;
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
	      	width: 180px;
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
			width:100px; 
			height:35px;
			border:1px solid black;
			border-radius:5px;
			text-indent: 1em;
		}
		#my_modal {
			display: none;
			width: 500px;
			padding: 20px 60px 40px 60px;
			background-color: #fefefe;
			border: 1px solid #888;
			border-radius: 3px;
      	}
	  	#my_modal .modal_close_btn {
			position: absolute;
			bottom: 10px;
			left : 50%;    
     	}
     	#popup_open_btn{
     		background-color:#FFA742;
	      	color:white;
	      	border: none;
	      	border-radius: 6px;
	      	width: 180px;
	      	height:40px;
      	}
    </style>
</head>
<%	request.setCharacterEncoding("UTF-8");

	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")!=null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="/anitel/userLoginForm.jsp";
		</script>
<%	}else{ 
	// 해줘야 하는것
	// 1. 세션아이디 꺼내서 사업자 회원 정보 세팅하기
	// 2. dao에 아이디 집어넣고 아이디, 성명, 연락처, 이메일 집어넣기

	//String id = (String)session.getAttribute("sid");
	String id = "global";													// 테스트용 : 개발 끝나고 지워버려야댐
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO member = dao.getMember(id);
	
	int room_num = Integer.parseInt(request.getParameter("room_num"));
	RoomDAO roomdao = RoomDAO.getInstance();
	RoomDTO room = roomdao.getRoom(room_num); 


	
%>
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
   	     		<button id="login">로그인</button>
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
        <h1>호텔 객실 정보 수정</h1>
      	<hr align="left" width=1000 color="black">
      	<div>
      		<form  action="/anitel/memberMypage/memberRoomAddPro.jsp?room_num=<%= room_num %>" method="post" enctype="multipart/form-data">
      		<table>
      			<tr>
      				<td>객실 목록</td>
      			</tr>
      			<tr>
      				<td>
      					<table border=1>
      						<tr align="center">
      							<td>
      								객실 이름
      							</td>
      							<td>
      								수용 동물
      							</td>
      							<td>
      								1박 이용 요금
      							</td>
      							<td>
      								대형동물 수용여부
      							</td>
      							<td>
      								객실 이미지
      							</td>
      						</tr>

      						<tr align="center">
      							<td>
      								<input type="text" name="name" placeholder="<%= room.getName() %>" value="<%= room.getName() %>"/>
      							</td>
      							<td>
      								<select name="pet_type">
      									<option value="0" <% if(room.getPet_type()==0) {%>selected<%} %>>강아지</option>
      									<option value="1" <% if(room.getPet_type()==1) {%>selected<%} %>>고양이</option>
      									<option value="2" <% if(room.getPet_type()==2) {%>selected<%} %>>기타</option>
      								</select>
      							</td>
      							<td>
      								<input type="text" name="d_fee" placeholder="<%= room.getD_fee() %>" value="<%= room.getD_fee() %>"/>
      							</td>
      							<td>
      								<input type="checkbox" name="pet_big" value=<%= room.getPet_big() %> <% if(room.getPet_big()==1) {%>checked<%} %> />수용 가능합니다
      							</td>
      							<td>
      								<img src="/anitel/save/<%= room.getImg() %>" width=100/>
      								<input type="file" name="img"/>
      								<input type="hidden" name="eximg" value="<%= room.getImg() %>"/>
      							</td>
      						</tr>
      						<tr align="right">
      							<td colspan=5>
      								<input type="submit" value="수정"/>
      							</td>
      						</tr>
      					</table>
      				</td>
      			</tr>
      		</table>
      		</form>
      	</div>
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