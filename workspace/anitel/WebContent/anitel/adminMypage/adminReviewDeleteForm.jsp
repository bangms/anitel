<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title> 
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
String [] check = request.getParameterValues("info");
%>
<script>
	opener.parent.location='/anitel/anitel/adminMypage/adminReviewForm.jsp';
</script>

<body>
	<br/><br/><br/><br/>
		<form action="adminReviewDeletePro.jsp" get="post">
		<%for(int i = 0 ;i < check.length; i++) {%>		
			<input type="hidden" name="check" value="<%=check[i] %>" />
		<%}%>
	<table>
		<tr>
			<td>후기를 삭제하시겠습니까?</td>
		</tr>
		<tr>
			<td align="center"><br/>
			<input type="submit" value="OK"/>&emsp;	 
			<input type="button" value="CANCEL" onClick="window.close()"/> </td>
		</tr>
	</table> 

	</form>
</body>
</html>