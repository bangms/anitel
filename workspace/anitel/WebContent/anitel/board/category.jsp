<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table>
	<tr>
		<td> 공지사항 </td>
		<td><button onclick="window.location='writeForm.jsp?categ=0'"> 글쓰기 </button></td>
		<td><button onclick="window.location='list.jsp?categ=0'"> list </button></td>
	</tr>
	<tr>
		<td> 1:1 </td>
		<td><button onclick="window.location='writeForm.jsp?categ=1'"> 글쓰기 </button></td>
		<td><button onclick="window.location='list.jsp?categ=1'"> list </button></td>
	</tr>
	<tr>
		<td> 호텔 qna </td>
		<td><button onclick="window.location='writeForm.jsp?categ=2'"> 글쓰기 </button></td>
		<td><button onclick="window.location='list.jsp?categ=2'"> list </button></td>
	</tr>

	<tr>
		<td> 후기  </td>
		<td><button onclick="window.location='writeForm.jsp?categ=3'"> 글쓰기 </button></td>
		<td><button onclick="window.location='list.jsp?categ=3'"> list </button></td>
	</tr>
	
	
	</table>
	 
</body>
</html>