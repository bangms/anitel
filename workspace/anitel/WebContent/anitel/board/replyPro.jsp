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
	request.setCharacterEncoding("utf-8");


%>

<jsp:useBean id="article" class="anitel.model.BoardDTO" /> 
<jsp:setProperty property="*" name="article"/>

<%

	String pageNum = request.getParameter("pageNum"); 
	int categ= Integer.parseInt(request.getParameter("categ"));
	String board_num = request.getParameter("board_num");
	System.out.println("board_num : " + board_num);
	
	article.getReply_content(); 
	
	
	BoardDAO dao = BoardDAO.getInstance(); 
	int result = dao.updateReply(article); 
	
	
	System.out.println("result=" + result);
	
	response.sendRedirect("content.jsp?board_num=" + article.getBoard_num() + "&pageNum=" + pageNum + "&categ=" + categ);
 
 
%>

<body>


</body>
</html>