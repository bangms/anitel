<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8">
    <title>마이페이지(사업자회원) - 호텔정보 수정</title>
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
      	position:fixed;
      	display: flex;
 		justify-content: space-between;
 		z-index:1;
 		background-color:white;
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
      	z-index:2;
      	overflow-y:hidden;
		overflow-x:hidden;
      	
      }
      #content {
        width: 75%;
       	height:100%;
        padding: 20px;
        margin-top:120px;
        margin-bottom: 20px;
        margin-left:400px;
        padding-left:100px;
        padding-right:100px;
        float: left;
		padding-bottom:100px;
      }
      #sidebar {
        width: 230px;
        padding: 20px;
        float: left;
        clear:both;
        background-color:#EBDDCA;
        margin-right:50px;
        margin-left:70px;
        margin-top:120px;
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
      #button button:hover{
      	background-color:#FF822B;
      	color:#ffffff;
      }
      
    </style>
  </head>
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
          <li>내 정보</li>
          <li>호텔 정보</li>
          <li>호텔 예약 관리</li>
          <li>호텔 QnA 관리</li>
          <li>호텔 후기 관리</li>
        </ul>
      </div>
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      
      <div id="content">
        <h1>나의 정보</h1>
      컨텐츠는 여기에 만들어 주세요!!

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
</html>