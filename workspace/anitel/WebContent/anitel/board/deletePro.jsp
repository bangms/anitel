<%@page import="anitel.model.MemberDAO"%>
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
<body>
<%

	request.setCharacterEncoding("utf-8");
	
 
	String id =(String)session.getAttribute("sid");
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	System.out.println("deletePro - board_num : " + board_num);
	
	String pageNum = request.getParameter("pageNum");  
	int categ= Integer.parseInt(request.getParameter("categ"));
	System.out.println("content:" + id + board_num + pageNum + categ);
	
	String memId = request.getParameter("memId"); // 사업자아이디
	System.out.println(memId);
	String check_in = request.getParameter("check_in");
	String check_out = request.getParameter("check_out");
	String pet_type = request.getParameter("pet_type");

	int result;

	BoardDAO dao = BoardDAO.getInstance();
	String img = dao.getPhoto(board_num, categ);
	System.out.println("imageName:" + img);
	String path = request.getRealPath("save");
	System.out.println("path:" + path);
	path += "//" + img;
	System.out.println("imgpath:" + path);
	
	String writeId = dao.getWriteId(board_num);
	
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
	
	MemberDAO member = MemberDAO.getInstance(); 
	
	int checkID = dao.idCk(id);
	
	
%>

<%	if(result == 1){
		File f= new File(path);
		f.delete(); %>
		
	<%if(categ == 0){%>	
 		<script>
			alert("삭제가 성공적으로 완료되었습니다.");
			window.location="list.jsp?pageNum=<%=pageNum%>&categ=<%=categ%>&board_num<%=board_num%>";
		</script>
		
	<%}else if(categ ==1){ %>
	
		<%if(dao.idCk(writeId) == 1){// 일반유저 %>
		<script>
			alert("삭제가 성공적으로 완료되었습니다.");
			window.location="../adminMypage/adminUserQnAForm.jsp?categ=<%=categ%>";
		</script>
		<%}else if (dao.idCk(writeId) == 2){ %>//사업자
			<script>
			alert("삭제가 성공적으로 완료되었습니다.");
			window.location="../adminMypage/adminMemberQnAForm.jsp?categ=<%=categ%>";
		</script>
		<% }%>	 
		
	<%}else if(categ == 2){%>
		<script type="text/javascript">
		alert("삭제가 성공적으로 완료되었습니다.");
		window.location="../userMypage/userQnA.jsp";
		</script>
	<%}else if(categ == 3){%>
		<%if(session.getAttribute("sid").equals("admin")){ %>
		 <script type="text/javascript">
		alert("삭제가 성공적으로 완료되었습니다.");
		window.location="../adminMypage/adminReviewForm.jsp";
		</script>
		 	
		<%}else{ %> %>
		<script type="text/javascript">
		alert("삭제가 성공적으로 완료되었습니다.");
		window.location="../userMypage/userReview.jsp";
		</script>
	
		<%} %>
<%} %>
		
<%	}else{ %>
		<script>
			alert("삭제 실패 : 비밀번호가 일치하지 않습니다.");
			history.go(-1);
		</script>
<%	} %>
 
 
</body>
</html>
