<%@page import="anitel.model.UsersDAO"%>
<%@page import="anitel.model.UsersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정 폼</title>
<<<<<<< HEAD
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
	width: 65px;
	height:25px;
	font-size: 12px;
      	margin-top:15px;
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
	width: 180px;
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
=======

>>>>>>> 0ddd85b4cae75d3fd95c689a596bce48ea8dd4a7
</head>
<%	request.setCharacterEncoding("UTF-8");
	// 비로그인 접근제한(마이페이지) : 일반회원 로그인 폼으로 이동
	if(session.getAttribute("sid")==null){ 									// 테스트용 : 개발 끝나고 == null로 바꿔야합니당%>
		<script>
			alert("로그인이 필요한 서비스입니다.");
			window.location="/anitel/anitel/userLoginForm.jsp";
		</script>
<%	}else{ 
	// 해줘야 하는것
	// 1. 세션아이디 꺼내서 사업자 회원 정보 세팅하기
	// 2. dao에 아이디 집어넣고 아이디, 성명, 연락처, 이메일 집어넣기
	//String id = (String)session.getAttribute("sid");
	String id = "java04";			
	UsersDAO dao = UsersDAO.getInstance();
	UsersDTO users = dao.getuser(id);
	System.out.println(users);
	System.out.println(users.getUser_name());
%>
<script type="text/javascript">
function popupOpen(){
	var popUrl = "popupForm.jsp?pop=2";	//팝업창에 출력될 페이지 URL
	var popOption = "width=370, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);
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
        		<button id="notice" onclick="window.location='list.jsp'">공지사항</button>
        		<button id="signin" onclick="window.location='signInUserForm.jsp'">회원가입</button>
   	     		<button id="login" onclick="window.location='/anitel/userLoginForm.jsp'">로그인</button>
       		 </div>
        </section>
      </div>
      
	<div id="main">
	
	<!-- 여기서부터 사이드바 입니다.  -->
      <div id="sidebar">
        <h1>마이페이지</h1>
       	<ul>
      	 	<li><a href="/anitel/anitel/userMyPage/userMyReserve.jsp">나의 예약현황</a></li>
          	<li><a href="/anitel/anitel/userMyPage/userMyPage.jsp">나의 정보</a></li>
          	<li><a href="/anitel/anitel/userMyPage/userQnA.jsp">나의 Q&A</a></li>
          	<li><a href="/anitel/anitel/userMyPage/userReview.jsp">나의 후기</a></li>
        </ul>
      </div>
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      
    <div id="content">
		    <h1><%= users.getUser_name() %>님의 회원정보</h1>
      	<hr align="left" width=800 color="black">
      	<br/>
      	<form action="/anitel/anitel/userMyPage/userModifyPro.jsp" method="post">
	   		<table>
	      			<tr height = 50>
	      				<td width=150><h3>성명</h3></td>
						<td width=800>
							<input type="text" name="user_name" value="<%=users.getUser_name()%>"/>
						</td>
					</tr>
		      		<tr height = 50>
		      			<td width=150><h3>전화번호</h3></td>
		      			<td width=800>
		      				<input type="text" name="user_phone" value="<%=users.getUser_phone()%>"/>
						</td>
					</tr>
		      		<tr height = 50>
      					<td><h3>E-Mail</h3></td>
      					<td>
      						<input type="text" name="user_email" value="<%= users.getUser_email()%>" />
      					</td>
      				</tr>
      		</table>
      	<br/>
			<input type="submit" value="내정보 수정"/>&emsp;
			<input type="button" value="취소" onclick="window.location='/anitel/anitel/userMyPage/userMyPage.jsp'"/>&emsp; 
			<button id="withdraw"onclick="popupOpen()">탈퇴하기 </button>
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

<%} %>

</html>