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
	<style>
		input[type=button] { 
	      	border: none;
	      	border-radius: 6px;
	      	width: 110px;
	      	height:40px;	
		}
		input[type=submit] { 
	      	border: none;
	      	border-radius: 6px;
	      	width: 110px;
	      	height:40px;	
		}
		#withdraw{ 
	      	border: none;
	      	border-radius: 3px;
			width: 65px;
			height:25px;
			font-size: 12px;
	      	margin-top:15px;
	      	margin-left:600px;
	      	position:relative;
      }   	
    </style>
    

<%
	String id = (String)session.getAttribute("sid");
	System.out.println("modify.sid:" + id);

	// &pageNum=<%=pageNum  파라미터 페이지넘  꺼내기 
	String pageNum = request.getParameter("pageNum");

	// content 에서 넘어오는 고유 번호 꺼내서	
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	System.out.println("modify.board_num:" + board_num);

	// 게시판 구분 코드 
	int categ= Integer.parseInt(request.getParameter("categ"));
	System.out.println("modify.categ:" + categ);
	
	
	String memId = request.getParameter("memId"); // 사업자아이디
	System.out.println(memId);
	String check_in = request.getParameter("check_in");
	String check_out = request.getParameter("check_out");
	String pet_type = request.getParameter("pet_type");
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
	<h1 align="center"> 게시판 삭제 </h1>
<%	if(session.getAttribute("sid").equals("admin")){ %>	
<br/><br/><br/><br/>
	<form action="deletePro.jsp?pageNum=<%=pageNum%>&memId=<%=memId%>&check_in=<%=check_in%>&check_out=<%=check_out%>&pet_type=<%=pet_type%>" method="post">
		<input type="hidden" name="board_num" value="<%= board_num %>"/>
		<input type="hidden" name="categ" value="<%= categ%>"/>
		<table align="center" style="margin:  0 auto;">
			<tr>
				<td>관리자 권한 : 삭제하시겠습니까?</td>
			</tr>
			<tr>
				<td><input type="submit" value="삭제"/>
					<%if(pet_type!=null){ %>
						<input type="button" value="취소" onclick="window.location='content.jsp?board_num=<%=board_num%>&pageNum=<%=pageNum%>&categ=<%=categ%>&memId=<%=memId%>&check_in=<%=check_in%>&check_out=<%=check_out%>&pet_type=<%=pet_type%>'"/></td>
					<%}else{ %>
						<input type="button" value="취소" onclick="window.location='content.jsp?board_num=<%=board_num%>&pageNum=<%=pageNum%>&categ=<%=categ%>'"/></td>
					<%} %>
			</tr>
		</table>
	</form>
<%	}else{ %>
<br/><br/><br/><br/>
	<form action="deletePro.jsp?pageNum=<%=pageNum%>" method="post">
		<input type="hidden" name="board_num" value="<%= board_num %>"/>
		<input type="hidden" name="categ" value="<%= categ%>"/>
			<table align="center" style="margin:  0 auto;">
				<tr>
					<td>삭제하려면 비밀번호를 입력하세요.</td>
				</tr>
				<tr>
					<td><input type="password" name="pw"/></td>
				</tr>
				<tr>
					<td><input type="submit" value="삭제"/>
						<input type="button" value="취소" onclick="window.location='content.jsp?board_num=<%=board_num%>&pageNum=<%=pageNum%>&categ=<%=categ%>'"/></td>
				</tr>
			</table>
		</form>
<%	} %>
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
