<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 승인하기</title> 
	<style>
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
<%
	String Id = request.getParameter("Id");
%>
<body>
	<br/><br/><br/><br/>
		<form action="adminApprovePro.jsp" method="post">
		<input type="hidden" name="Id" value="<%=Id%>" />
	<table align="center">
		<tr align="center">
			<td>해당 사업자를 승인하시겠습니까?<br /><br /></td>
		</tr>
		<tr>
			<td><br/>
			<input type="submit" value="OK"/>&emsp;	 
			<input type="button" value="CANCEL" onClick="window.close()"/>
			 </td>
		</tr>
	</table> 

	</form>
</body>
</html>