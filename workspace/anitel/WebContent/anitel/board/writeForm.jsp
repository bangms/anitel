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
 
	<script>
	// 유효성 검사  
		function check(){ 
			if(!inputForm.subject.value){
				alert("제목이 입력되지 않았습니다.");
				return false;
			}
			if(!inputForm.pw.value){
				alert("비밀번호가 입력되지 않았습니다.");
				return false;
			}
			if(!inputForm.ctt.value){
				alert("본문이 입력되지 않았습니다.");
				return false;
			}
		}
	</script>
 

<%   
   	String id = (String)session.getAttribute("sid");
	System.out.println(id);
		
	String pageNum = request.getParameter("pageNum");

	// categ 값 꺼내기 
   	int categ = Integer.parseInt(request.getParameter("categ"));
   	System.out.println("writeForm.categ=" + categ);
   	
  	//reg_num 이 넘어올때 
  	String reg_num = request.getParameter("reg_num");
  	System.out.println("writeForm reg_num=" +reg_num);
  	
  	String memId = request.getParameter("memId"); // 사업자아이디
	System.out.println(memId);
	String check_in = request.getParameter("check_in");
	String check_out = request.getParameter("check_out");
	String pet_type = request.getParameter("pet_type");
  	
  	
  	//memId 가 넘어올떄 categ =2,3 일때 hoteldetail 로 보내주기 위함 
  	//String memId = request.getParameter("memId");
  	//System.out.println("writeForm memId=" + memId);
  	
   
	// DB에 담아줄 글 관련 정보 선언 및 초기화
	int board_num=0;
	//int comm = 0;
	
	int hidden_content = 0;
	if (categ == 2){
		hidden_content = 1;
	}
	System.out.println("hiddenWF =" + hidden_content);
  
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
 	<div id="boardName"> 
 		<% if (categ == 0){ %>
					<h1> 공지사항 </h1>
		<%} else if(categ == 1){ %>
					<h1> 1:1 문의 </h1>
		<%} else if(categ == 2){ %>
					<h1> 호텔Q&A </h1>
		<%} else if(categ == 3){ %>
					<h1> 후기 </h1>
		<% } %>
 	</div>
 	<div align="center">
		<form action="writePro.jsp" method="post" enctype="multipart/form-data" name="inputForm" onsubmit="return check()">
			<%-- 글에 대한 속성값 노출 없이 전송 --%>
			<input type="hidden" name="board_num" value="<%=board_num%>"/>
			<input type="hidden" name="categ" value="<%=categ%>"/>
			<input type="hidden" name="hidden_content" value="<%=hidden_content%>"/>
			<input type="hidden" name="reg_num" value="<%=reg_num%>"/>
			<input type="hidden" name="memId" value="<%=memId%>"/>
			<input type="hidden" name="check_in" value="<%=check_in%>"/>
			<input type="hidden" name="check_out" value="<%=check_out%>"/>
			<input type="hidden" name="pet_type" value="<%=pet_type%>"/>
			 
	 
			<table align="center" style="margin:  0 auto;">
				<tr>
					<td><input size="60%" type="text" name="subject" placeholder="제목입력" autofocus/></td>
				</tr>
				<tr>
					<td><input type="password" name="pw" placeholder="비밀번호" /></td>
				</tr>
				<tr>
					<td><input type="file" name="img" /></td>
					
				</tr>
				<tr>
					<td><textarea rows="20" cols="60" name="ctt"></textarea></td>
				</tr> 
				<tr>
					<td>
						<input type="submit" value="등 록" />	
						<%if(categ == 0 || categ == 1){%>
						 	<input type="button" value="취 소" onclick="window.location='list.jsp?&categ=<%=categ %>&amp;reg_num=<%=reg_num%>'" />            
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
