<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>객실 삭제</title>
</head>
<% String[] check = request.getParameterValues("info");
	System.out.println(check[0]);
%>
<body>
	<form action="memberRoomDeletePro.jsp" method="post">
		<% System.out.println("DeleteForm - 배열 체크"); %>
		<%for(int i = 0; i < check.length; i++) {%>		
			<input type="hidden" name="check" value="<%=check[i] %>" />
			<% System.out.println("체크 "+ i +"번 : " + check[i]); %> 		
		<%} %>	
		<table>
			<tr align="center">
				<td>선택된 객실을 삭제하시겠습니까? <br /><br /></td>
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
</html>