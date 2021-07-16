<%@page import="java.io.File"%>
<%@page import="anitel.model.BoardDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<%

	request.setCharacterEncoding("utf-8");
	
 
	String id =(String)session.getAttribute("sid");
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	System.out.println("deletePro - board_num : " + board_num);
	
	String pageNum = request.getParameter("pageNum");  
	int categ= Integer.parseInt(request.getParameter("categ"));
	System.out.println("content:" + id + board_num + pageNum + categ);

	int result;

	BoardDAO dao = BoardDAO.getInstance();
	String img = dao.getPhoto(board_num, categ);
	System.out.println("imageName:" + img);
	String path = request.getRealPath("save");
	System.out.println("path:" + path);
	path += "//" + img;
	System.out.println("imgpath:" + path);
	
	if(session.getAttribute("sid").equals("admin")){
		// 관리자 삭제(pw X)
		result = dao.deleteArticleAdmin(board_num, categ);  
		pageNum = request.getParameter("pageNum");
		System.out.println("deletePro - pageNum : " + pageNum);
		System.out.println("deletePro - 삭제 결과 : " + result + "(삭제실패 : -1, 삭제성공 : 1)");
	}else{
		// 일반사용자 삭제(pw O)
		// 넘어오는 데이터 : num, pw
		String pw = request.getParameter("pw");
		result = dao.deleteArticle(board_num, pw, categ);   
		pageNum = request.getParameter("pageNum");
		System.out.println("deletePro - pageNum : " + pageNum);
		System.out.println("deletePro - 삭제 결과 : " + result + "(삭제실패 : -1, 삭제성공 : 1)");
	}
%>

<%	if(result == 1){
		File f= new File(path);
		f.delete(); %>
		
	<%if(categ == 0 || categ == 1){%>	
 		<script>
			alert("삭제가 성공적으로 완료되었습니다.");
			window.location="list.jsp?pageNum=<%=pageNum%>&categ=<%=categ%>&board_num<%=board_num%>";
		</script>
		
	<%}else if(categ == 2 || categ == 3){%>
		<script type="text/javascript">
		alert("삭제가 성공적으로 완료되었습니다.");
		history.go(-3);
		</script>
	<%} %>
	
		
<%	}else{ %>
		<script>
			alert("삭제 실패 : 비밀번호가 일치하지 않습니다.");
			history.go(-1);
		</script>
<%	} %>
 
 
</body>
</html>
