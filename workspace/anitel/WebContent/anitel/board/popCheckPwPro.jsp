<%@page import="anitel.model.BoardDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	System.out.println("pro접근");
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String pageNum = request.getParameter("pageNum");
	int categ = Integer.parseInt(request.getParameter("categ"));
	
	if (session.getAttribute("sid") == null) {
%>
	<script type="text/javascript">
		alert("잘못된 접근입니다!");
		window.location = "list.jsp?board_num="+ <%=board_num%>+ "&pageNum=" + <%=pageNum%> +"&categ=" + <%=categ%>;
	</script>
<%
	} else {
	String pw = request.getParameter("pw"); 
	BoardDAO dao = BoardDAO.getInstance();

	boolean result = dao.checkpw(board_num, pw); 

	if (result) { // 비밀번호 맞음
	%>
	<script type="text/javascript">
		self.close();
		opener.document.location = "content.jsp?board_num="+ <%=board_num%>+"&pageNum=" + <%=pageNum%> +"&categ=" + <%=categ%>;
	</script>
	<%
	} else { // 비밀번호가 틀린 경우
	%>
	<script type="text/javascript">
		alert("비밀번호가 틀렸습니다!");
		self.close();	
	</script>
	<%
	}
	%>
	<body>
	</body>
	<%
	}
	%>
</html>