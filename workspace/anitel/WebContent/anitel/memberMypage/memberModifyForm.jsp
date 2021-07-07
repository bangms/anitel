<%@page import="anitel.model.MemberDTO"%>
<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>마이페이지(사업자회원) - 개인정보 수정</title>
    <style>
      #container {
        width: 100%;
        margin: 0px auto;
        padding: 20px;
      }
      #header {
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
     	margin-right:100px;
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
	  input[type=button] { 
		background-color:#FFA742;
      	color:white;
      	border: none;
      	border-radius: 6px;
      	width: 110px;
      	height:40px;	
	  }
	  input:hover{
      	background-color:#FF822B;
      	color:#ffffff;
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
	//String id = (String)session.getAttribute("sid");
	String id = (String)request.getParameter("id");
	MemberDAO dao = MemberDAO.getInstance();
	MemberDTO member = dao.getMember(id);
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
        <h1><%= member.getMember_name() %>님의 회원정보 수정</h1>
      	<hr align="left" width=700 color="black">
      	<br/>
      	<form method="post" name="modify" id="modify">
      	<table>
      		<tr height = 50>
      			<td width = 200><h3>아이디</h3></td>
      			<td width = 800><h3><%= member.getId() %></h3></td>
      		</tr>
      		<tr height = 50>
      			<td><h3>성명</h3></td>
      			<td>
      				<input type="text" name="member_name" value="<%= member.getMember_name() %>" autofocus />
      			</td>
      		</tr>
      		<tr height = 50>
      			<td><h3>전화번호</h3></td>
      			<td>
      				<input type="text" name="member_phone" value="<%= member.getMember_phone() %>" />
      			</td>
      		</tr>
      		<tr height = 50>
      			<td><h3>E-Mail</h3></td>
      			<td>
      				<input type="text" name="member_email" value="<%= member.getMember_email() %>" />
      			</td>
      		</tr>
      	</table>
      	<br/>
			<!-- <input type="submit" value="수정내용 저장"/>&emsp; -->
			<br/><br/>
			<div id="my_modal">
	    		<h5 align="center">비밀번호를 입력해주세요</h5> <br/>
				<input type="password" name="member_pw" autofocus/><br/>
				<button class="modal_close_btn" id="popup_close_btn" onclick="submitForm(<%=member.getId() %>)">확인</button>
	    	</div>	
     </div>
        
      <button id="popup_open_btn">승인보류</button>
			<input type="button" value="변경 취소" onclick="window.location='/anitel/memberMypage/memberMyPage.jsp'"/>&emsp; 
	   </form>
 
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
<script>
	function modal(id) {
		var zIndex = 9999;
		var modal = document.getElementById(id);
		// 모달 div 뒤에 희끄무레한 레이어
		var bg = document.createElement('div');
		bg.setStyle({
			position: 'fixed',
			zIndex: zIndex,
			left: '0px',
			top: '0px',
			width: '100%',
			height: '100%',
			overflow: 'auto',
			// 레이어 색 변경
			backgroundColor: 'rgba(0,0,0,0.4)'
		});
		document.body.append(bg);

		modal.setStyle({
			position: 'fixed',
			display: 'block',
			boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

 			// 시꺼먼 레이어 보다 한칸 위에 보이기
			zIndex: zIndex + 1,

			// div center 정렬
			top: '50%',
			left: '50%',
			transform: 'translate(-50%, -50%)',
			msTransform: 'translate(-50%, -50%)',
			webkitTransform: 'translate(-50%, -50%)'
		});
	}

	// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
	Element.prototype.setStyle = function(styles) {
		for (var k in styles) this.style[k] = styles[k];
		return this;
	};

	document.getElementById('popup_open_btn').addEventListener('click', function() {
		// 모달창 띄우기
		modal('my_modal');
	});
	
	function submitForm(id) {
		var btn = document.getElementById('popup_close_btn');
		document.modify.action = "../main.jsp";
		document.modify.submit();

} 
	
	// 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
	
</script>
</html>