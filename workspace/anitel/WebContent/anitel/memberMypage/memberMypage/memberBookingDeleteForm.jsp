<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>예약 삭제</title>
	
</head>
<% 
if(session.getAttribute("sid")==null){ %>
	<script>
		alert("로그인이 필요한 서비스입니다.");
		window.location="../loginForm.jsp";
	</script>
<%
}else{ 
String [] check = request.getParameterValues("info"); %>
<body>
	<form action="memberBookingDeletePro.jsp" method="post">
		<%for(int i = 0; i < check.length; i++) {%>		
			<input type="hidden" name="check" value="<%=check[i] %>" /> 		
		<%} %>	
		<table>
			<tr align="center">
				<td>선택된 예약을 취소하시겠습니까? <br /><br /></td>
			</tr> 	
			<tr align="center">
				<td>
					&nbsp;
					<input type="submit" value="OK"/>
					&emsp;&emsp;&emsp;&emsp;
					<input type="button" value="CANCLE" onclick="window.close()"/>
				</td>
			</tr>	
		</table>	
	</form>
</body>
<% } %>
</html>
