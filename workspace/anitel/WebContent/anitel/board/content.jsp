<%@page import="java.text.SimpleDateFormat"%>
<%@page import="anitel.model.BoardDTO"%>
<%@page import="anitel.model.BoardDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글조회</title>
  	<link rel="stylesheet" href="../style/style.css">
 	<link rel="stylesheet" href="../style/reset.css">
  	<link rel="stylesheet" href="../style/init.css">	
</head>

<%
 
	request.setCharacterEncoding("utf-8");
	

	// session id 
	String id =(String)session.getAttribute("sid");
	System.out.println("content sid=" + id);
	// list ? 에서 넘어오는 고유 번호 꺼내서	
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	System.out.println("board_num.content = " + board_num);
	
	// 컨텐츠에서 보고 있던 페이지 번호 뽑아오기 
	String pageNum = request.getParameter("pageNum");  
	
	// 게시판 구분 코드 
	int categ= Integer.parseInt(request.getParameter("categ"));
	System.out.println("categ.content = " + categ);
	
	//reg_num 이 넘어올때 
	String reg_num = request.getParameter("reg_num");
	System.out.println("content reg_num=" +reg_num);
	

	//db 에서 글 고유번호 주고 해당 글에 대한 애용 가져오기
	BoardDAO dao = BoardDAO.getInstance();
	BoardDTO article = dao.getArticle(board_num);  
	 
	System.out.println("content subject " + article.getSubject());
	System.out.println("content img name " + article.getImg());
			
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH.mm");
  
	// id 타입 체크
	boolean check = false;
%>
<body>
<div id="container">
	<div id="header">
		<div id="logo" onclick="window.location='../main.jsp'">
			<img src="../imgs/logo.jpg" width="200px" height="100px" alt="logo">
		</div>
		<div id="button">
			<button id="notice" onclick="window.location='list.jsp?categ=0'">공지사항</button>
<% 	
	if(session.getAttribute("sid") == null){ 
%>
			<button id="signin" onclick="window.location='../signIn.jsp'">회원가입</button>
			<button id="login" onclick="window.location='../loginForm.jsp'">로그인</button>
			
<%}else{ %>
			<button id="mypage" onclick="window.location='../mypage.jsp'">마이페이지</button>
			<button id="signout" onclick="window.location='../logout.jsp'">로그아웃</button>
<%}%>

		</div>
	</div>	
	 <div id="section">
		<div id = "boardName">
		<!-- 게시판 이름 분기처리  -->
	 		<% if (categ == 0){ %>
						<h1 align="center" > 공지사항 </h1>
			<%} else if(categ == 1){ %>
						<h1 align="center" > 1:1 문의 </h1>
			<%} else if(categ == 2){ %>
						<h1 align="center" > 호텔Q&A </h1>
			<%} else if(categ == 3){ %>
						<h1 align="center" > 후기 </h1>
			<% } %>
		</div>
		
	 		<table>
			<tr>
				<td colspan="2"><b> <%= article.getSubject()%> </b> </td>
			</tr>
			<tr>
				<td> <%= sdf.format(article.getReg_date()) %> </td>
				<td> <%= article.getReadcount() %> viewed </td>
			</tr>
			<tr>
				<td colspan="2" height="100"> <%= article.getCtt() %></td>
			</tr>
			<tr>
			<%if(article.getImg() != null){%>
				<td colspan="2" height="100"><img src="<%=request.getContextPath()%>/save/<%=article.getImg()%>" style="max-width: 80%" /> </td>	
			<%}else{ %>
				<td colspan="2" height="100"><img src="../save/default.png"/></td>
			<%} %>
			</tr>
			<%if(article.getReply_content() != null){ %> 
			<tr> <td colspan="2"> 답변 </td><tr>
			<tr>
				<td colspan="2" height="100"> <%= article.getReply_content()%></td>
			</tr>
			<%} %>
			
			<tr>
				<td colspan="2">
				<input type="button" value="뒤로가기" onclick="history.back()"/>
				<button onclick="window.location='list.jsp?categ=<%=categ%>'">목록으로</button>
<%if(id== null){ %>
	<%-- 버튼 안보임  --%>
	
<%}else{ %>

 		<% if (categ == 0 && session.getAttribute("sid").equals("admin")){//공지%> 
				<button onclick="window.location='modifyForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=0'">수  정</button>
				<button onclick="window.location='deleteForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=0'">삭  제</button>
		<%} else if(categ == 1){//1:1%>
				<%if(session.getAttribute("sid").equals("admin")){ %>
					<button onclick="window.location='replyForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=0'">답변입력</button>	 
				<%}  
				if(dao.idCk(id) == 1) { %><!-- TODO: 글쓰기, 수정은 고객전용 / 삭제는 고객,관리자 --> 
					<button onclick="window.location='modifyForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=1'">수  정</button>
			<%} 
				if(dao.idCk(id) == 1 || id.equals("admin")) {%>
					<button onclick="window.location='deleteForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=1'">삭  제</button>
			<%} %>
		<%} else if(categ == 2){//호텔QA
				if(dao.idCk(id) == 2) { %><!-- TODO: 답변은 사업자만 쓸수 있게 처리/ 글쓰기,수정은 고객전용 / 삭제는 고객,관리자전용  -->
					<button onclick="window.location='replyForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=2&amp;reg_num=<%=reg_num%>'">답글쓰기</button>
			<%} 
				if(dao.idCk(id) == 1) { %>
					<button onclick="window.location='modifyForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=2&amp;reg_num=<%=reg_num%>'">수  정</button>
					<button onclick="window.location='deleteForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=2'">삭  제</button>
		<%	} 
				if(check || id.equals("admin")) {%>
					<button onclick="window.location='deleteForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=2'">삭  제</button>
			<%} %>
		<%} else if(categ == 3){//후기
					check = dao.paymentUserCk(id, reg_num);
					if(check) { %>
						<!-- TODO: 글쓰기, 수정은  결제고객만, 삭제는 고객, 관리자만 가능   -->
						<button onclick="window.location='modifyForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=3&amp;reg_num=<%=reg_num%>'">수  정</button>
			<%  }
					if(check || id.equals("admin")) { %>
						<button onclick="window.location='deleteForm.jsp?board_num=<%= article.getBoard_num()%>&pageNum=<%=pageNum%>&categ=2'">삭  제</button>
			<%  } %>
		<% } %>
		
<%} //세션 있고 없고   %>
				</td>
			</tr>
		</table>
	 </div>
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
	<div id="footer">
		 <img src="../imgs/logo2.png" width=100px; height=50px;>
		 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
		 이용약관 | 취소정책 | 1:1문의 <br/>
			COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
	</div>
  </div>
</div>
</body>
</html>