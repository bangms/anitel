
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반회원 마이페이지</title>
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
    	position:absolute;
		background-color:black;
		color:white;
		
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
		#withdraw{ 
      	border: none;
      	border-radius: 3px;
		width: 65px;
		height:25px;
		font-size: 12px;
      	margin-top:15px;
      	margin-left:100px;
      	position:relative;
      	}
      	
		input[type=text] { 
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
	
	    input[type=checkbox]{
	      	width:14px;
	      	height:14px;
	      	border-radius: 3px;
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
%>
<body>
    <div id="container">
    
 <!-- 여기서부터 헤더  입니다.  -->
 	
      <div id="header">
      	<div id="logo">
       		 <img src="/anitel/anitel/userMyPage/imgs/logo.png" width="200px" height="100px">
        </div>
 		<section>
       	
        </section>
      </div>
      
	<div id="main">
	
     
      <!-- 여기서부터 콘텐츠 화면 입니다.  -->
      
      <div id="content">
      	<br/>
      	
      	<table style="border-collapse:collapse; border-radius:20px; border:1px white; background-color:#EBDDCA" >
      		<tr height = 50 align="center"> 
      			<td width = 500>
      				<br/>
      				<h1>Payment</h1>
      				<input type="text" placeholder="number on card" style="width:200px"></input><br/><br/>
      				<input type="checkbox"> 모든 이용약관을 읽었습니다.<br/><br/>
      				<h2> 결제할 금액  </h2>
      				<input type="button" value="결제하기" onclick="window.location='/anitel/anitel/userMyPage/userMyReserve.jsp"/><br/><br/>
      				<input type="button" value="취소하기" onclick="window.location='/anitel/anitel/main.jsp'"/><br/><br/>
      				<br/>
      			</td>
      		</tr>
      	</table><br/>
      		
			
       </div>
        
 
     </div>
      
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
      <div id="footer">
      <img src="/anitel/anitel/userMyPage/imgs/logo2.png" width=100px; height=50px;>
      <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
        <span id="info_text_btn">이용약관 </span> |
         <span id="tos_text_btn">취소정책 </span> 
        <span id="info_text_btn">1:1문의 </span> |<br>
      COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
      </div>
    </div>
    
</body>
</html>
