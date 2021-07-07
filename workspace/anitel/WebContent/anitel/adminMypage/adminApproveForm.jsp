<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title> 
<style>
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
			width:300px;
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
	String Id = request.getParameter("Id");
%>
<body>
	<br/><br/><br/><br/>
		<form action="adminApprovePro.jsp" get="post">
		<input type="hidden" name="Id" value="<%=Id%>" />
	<table>
		<tr>
			<td>해당 사업자를 인증하시겠습니까?</td>
		</tr>
		<tr>
			<td align="center"><br/>
			<input type="submit" value="OK"/>&emsp;	 
			<input type="button" value="CANCEL" onClick="window.close()"/>
			 </td>
		</tr>
	</table> 

	</form>
</body>
</html>