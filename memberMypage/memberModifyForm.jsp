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
        <h1><%= member.getMember_name() %>님의 호텔정보 수정</h1>
      	<hr align="left" width=800 color="black">
      	<br/>
      	<form action="/anitel/memberMypage/memberModifyPro.jsp?id=<%=member.getId()%>" method="post">
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
			<input type="submit" value="수정내용 저장"/>&emsp;
			<input type="button" value="수정 취소" onclick="window.location='/anitel/memberMypage/memberMyPage.jsp'"/>&emsp; 
		<br/><br/>	
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