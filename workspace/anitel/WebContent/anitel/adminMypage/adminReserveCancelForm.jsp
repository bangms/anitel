<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adminReserveCancle</title>
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
<%
	 String [] check = request.getParameterValues("info");
%>		
</head>
<body>
	<br/><br/><br/><br/>
	<form action="adminReserveCancelPro.jsp" method="post">
		<%for(int i = 0 ;i < check.length;i++) {%>		
			<input type="hidden" name="check" value="<%=check[i] %>" />
			<h3><%=check[i] %></h3> 		
		<%} %>	
		<table align="center">
			<tr align="center">
				<td>해당 예약을 취소하시겠습니까? <br /><br /></td>
			</tr> 	
			<script>
				//opener.parent.location='/anitel/anitel/adminMypage/adminReserveForm.jsp';
			</script>
			<tr>
				<td><br/>
					<input type="submit" value="OK" />&emsp;
					<input type="button" value="CANCLE" onclick="window.close()"/>
				</td>
			</tr>	
		</table>	
	</form>
</body>
</html>