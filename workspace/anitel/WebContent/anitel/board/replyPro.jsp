<%@page import="anitel.model.MemberDAO"%>
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
    String strReferer = request.getHeader("referer");
    
    if(strReferer == null){
   %>
    <script language="javascript">
     alert("URL 주소창에 주소를 직접 입력해서 접근하셨습니다.\n\n정상적인 경로를 통해 다시 접근해 주십시오.");
     document.location.href="main.jsp";
    </script>
   <%
     return;
    }
   %>
<%
	request.setCharacterEncoding("utf-8");


%>

<jsp:useBean id="article" class="anitel.model.BoardDTO" /> 
<jsp:setProperty property="*" name="article"/>

<%

	String id =(String)session.getAttribute("sid");

	String pageNum = request.getParameter("pageNum"); 
	int categ= Integer.parseInt(request.getParameter("categ"));
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	System.out.println("reply_pro board_num : " + board_num);
	
	String reg_num = request.getParameter("reg_num");
	System.out.println("reply_pro reg_num=" +reg_num);
	
	article.getReply_content(); 
	
	
	BoardDAO dao = BoardDAO.getInstance(); 
	
	String writeId = dao.getWriteId(board_num); 
	
	int result = dao.updateReply(article); 
	
	 
	
	System.out.println("result=" + result);
	
	//response.sendRedirect("content.jsp?board_num=" + article.getBoard_num() + "&pageNum=" + pageNum + "&categ=" + categ + "&reg_num=" + reg_num);
 	
 	
	MemberDAO member = MemberDAO.getInstance(); 
	int checkID = dao.idCk(id);
	
	if(session.getAttribute("sid").equals("admin")){
		response.sendRedirect("../adminMypage/adminUserQnAForm.jsp?categ=" + categ);
	}else {
		response.sendRedirect("content.jsp?board_num=" + article.getBoard_num() + "&pageNum=" + pageNum + "&categ=" + categ + "&reg_num=" + reg_num);
	}
	
 
%>
<body>


</body>
</html>
