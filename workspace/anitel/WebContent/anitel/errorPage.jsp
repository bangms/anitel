<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style>
		.error_wrapper {
			  width: 100%;
			  padding-top:150px;
		      text-align: center;	
		}
		input[type=button] { 
		      border: none;
		      border-radius: 6px;
		      width: 110px;
		      height:40px;	
		}
		input[type=submit] { 
		      border: none;
		      border-radius: 6px;
		      width: 110px;
		      height:40px;	
		}
		#withdraw{ 
	      	border: none;
	      	border-radius: 3px;
			width: 65px;
			height:25px;
			font-size: 12px;
	      	margin-top:15px;
	      	margin-left:600px;
	      	position:relative;
	     }  	
    </style>		
</head>
<body>
		<div class="error_wrapper">
			<div>
	     		<img src="imgs/error.png" width="350px" height="400px"/>
	     	</div>
			<h2>죄송합니다. 현재 찾을 수 없는 페이지를 요청하셨습니다.</h2>
			<p>존재하지 않는 주소를 입력하셨거나, <br/>요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다. <br/>궁금한 점이 있으시면 언제든 고객센터 통해 문의해 주시기 바랍니다.<br/>감사합니다.</p><br/><br/>
	
			<input type="button" value="메인으로" onclick="window.location='main.jsp'" />&emsp;
			<input type="button" value="이전 페이지" onclick="history.back()"/>
		</div>
</body>
</html>