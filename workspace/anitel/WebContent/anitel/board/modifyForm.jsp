<%@page import="anitel.model.BoardDTO"%> 
<%@page import="anitel.model.BoardDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판</title>
	<link rel="stylesheet" href="../style/style.css">
	<link rel="stylesheet" href="../style/reset.css">
	<link rel="stylesheet" href="../style/init.css">	
</head>
<%
	String id = (String)session.getAttribute("sid");

	// &pageNum=<%=pageNum  파라미터 페이지넘  꺼내기 
	String pageNum = request.getParameter("pageNum");

	// content 에서 넘어오는 고유 번호 꺼내서	
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	System.out.println("modify.board_num:" + board_num);
	
	// 게시판 구분 코드 
	int categ= Integer.parseInt(request.getParameter("categ"));
	System.out.println("modify.categ:" + categ);
	
	//reg_num
	String reg_num = request.getParameter("reg_num");
	System.out.println("list reg_num=" +reg_num);
	
	// 디비에서 해당글 가져와 화면에 뿌려주기
	BoardDAO dao = BoardDAO.getInstance();
	BoardDTO article = dao.getUpdateArticle(board_num, categ);  
	
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
				
			<%}else{ 
				if(id.equals("admin")) { %><%-- 관리자 일 때 --%>
					<button id="mypage" onclick="window.location='adminMypage/adminUserForm.jsp'">마이페이지</button>
			<%}
				if(id.equals("일반회원")) { %><%-- 일반 회원 일 때 --%>
					<button id="mypage" onclick="window.location='../mypage.jsp'">마이페이지</button>
			<%}
				if(id.equals("사업자")) { %><%-- 사업자 일 때 --%>
					<button id="mypage" onclick="window.location='../mypage.jsp'">마이페이지</button>
			<%}%>	
				<button id="signout" onclick="window.location='../logout.jsp'">로그아웃</button>
		<%}%>
		</div>
	</div>
	<div id="section">
	 	<div align="center">
 			<form action="modifyPro.jsp?pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data">
	 	 		<input type="hidden" name="board_num" value="<%= board_num%>" />
	 	 		<input type="hidden" name="categ" value="<%= categ%>" />
	 	 		<input type="hidden" name="reg_num" value="<%= reg_num%>" />
				<table align="center" style="margin:  0 auto;">
					<tr>
						<td><input size="60%" type="text" name="subject" value="<%=article.getSubject()%>" placeholder="제목수정" /></td>
					</tr>
					<tr>
						<td><input type="password" name="pw" placeholder="비밀번호" /></td>
					</tr>     
					<tr>
						<td><textarea rows="20" cols="60" name="ctt"><%=article.getCtt()%></textarea></td>
					</tr>
					<tr>
						<td> 
							<%
							if(article.getImg() != null){%>
								<img src="<%=request.getContextPath()%>/save/<%=article.getImg()%>" style="max-width: 80%" />		
							<%}else{ %>
								<img src="../save/default.png"/>
							<%} %>	
							
							<input type="file" name="img" />  
							<input type="hidden" name="exPhoto" value="<%= article.getImg() %>" />
						 
						</td>	
					</tr>
					<tr>
						<td colspan="2">
						   <input type="submit" value="수 정" />
						   
						<%if(categ == 0 || categ == 1){%>
						  <input type="button" value="취 소" onclick="window.location='list.jsp?pageNum=<%=pageNum%>&categ=<%=categ %>&amp;reg_num=<%=reg_num%>'" />            
						<%}else if(categ == 2 || categ == 3){%>
							<input type="button" value="취 소" onclick="history.back(-2)"/>
						<%}%>
						  
						</td>
					</tr>
				</table>
			</form>
 		</div>
	</div>
  <!-- 여기서부터 푸터입니다. 일단  DON't Touch !!!!!  -->     
		<div id="footer">
			 <img src="../imgs/logo2.png" width=100px; height=50px;>
			 <p> 평일 10:00 - 17:00 | anitel@anitel.com <br/>
			 이용약관 | 취소정책 | 1:1문의 <br/>
				COPYRIGHT 콩콩이 ALL RIGHT Reserved.</p>
			</div>
  </div>
</body>
</html>
