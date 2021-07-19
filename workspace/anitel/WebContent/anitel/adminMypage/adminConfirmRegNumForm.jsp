<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
	<style>
		input[type=text] { 
				border:1px solid black;
				border-radius:5px;
				height:30px;
				text-indent: 1em;
				
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
<%
	request.setCharacterEncoding("UTF-8");
	String Id = request.getParameter("Id");	
%>
<script>
	opener.parent.location='/anitel/anitel/adminMypage/adminMemberForm.jsp';
</script>
<body>
	<br/><br/><br/><br/>
		<form action="adminConfirmRegNumPro.jsp">
		<input type="hidden" name="Id" value="<%=Id%>" />
	<table align="center">
		<tr align="center">
			<td>사업자 번호 보류 사유 입력 </td>
		</tr>
		<tr>
			<td><textarea name="holdReason" cols="50" rows="20"></textarea><br/> </td>
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