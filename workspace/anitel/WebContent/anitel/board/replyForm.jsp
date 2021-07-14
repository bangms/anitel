<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
  	<link rel="stylesheet" href="../style/style.css">
 	<link rel="stylesheet" href="../style/reset.css">
  	<link rel="stylesheet" href="../style/init.css">	
</head>
 
<%   
   	String id = (String)session.getAttribute("sid");
	System.out.println(id);
	
   	//현재 페이지 번호
   	String pageNum = request.getParameter("pageNum"); // 요청시 페이지 번호가 넘어왔으면 꺼내서 담기
   
   	// categ 값 꺼내기 
   	int categ = Integer.parseInt(request.getParameter("categ"));
   	System.out.println("reply.categ=" + categ);
   	
   	String reg_num = request.getParameter("reg_num");
	System.out.println("reply.reg_num=" +reg_num);
   
	// DB에 담아줄 글 관련 정보 선언 및 초기화
	int board_num= Integer.parseInt(request.getParameter("board_num"));
	
 
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
					<button id="mypage" onclick="window.location='../adminMypage/adminUserForm.jsp'">마이페이지</button>
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
		<form action="replyPro.jsp?pageNum=<%=pageNum%>" method="post">
			<%-- 글에 대한 속성값 노출 없이 전송 --%>
			<input type="hidden" name="board_num" value="<%= board_num%>"/>
			<input type="hidden" name="categ" value="<%= categ%>"/>
			<input type="hidden" name="reg_num" value="<%= reg_num%>"/>
			<table>
				<tr>
					<td><h1>답변</h1></td>
				</tr>
				<tr>
					<td><textarea rows="20" cols="60" name="reply_content"></textarea></td>
				</tr> 
				<tr>
					<td colspan="2"><input type="submit" value="등 록" /></td>
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