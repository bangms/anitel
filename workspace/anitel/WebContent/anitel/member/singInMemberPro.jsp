<%@page import="anitel.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); 

System.out.println("호텔이름 넘어왔니? " +request.getParameter("name"));
%>

<jsp:useBean id="member" class="anitel.model.MemberDTO" />
<jsp:useBean id="room" class="anitel.model.RoomDTO" />
<jsp:setProperty property="*" name="member"/><body>
<jsp:setProperty property="*" name="room"/><body>
<%

	// DAO 객체 생성
	MemberDAO dao = MemberDAO.getInstance();
 	dao.insertMember(member); 
	dao.insertRoom(room); 
	
	// 페이징 처리 #1. 가입처리 직후 바로 메인으로 이동시키기 (사용자는 가입 누르면 바로 main 봄)
	// response.sendRedirect("main.jsp");
%>
	<%-- 페이징 처리 #2. 가입처리 후 화면에 가입완료 메세지와 버튼 보임. 
	<h4> 회원 가입 완료! </h4>
	<button onclick="window.location='main.jsp'"> main으로 이동 </button>--%>
	
	<%-- 페이징 처리 #4. 가입처리 후 화면에 가입완료 메세지 보여주고 5초 후 다시 main 이동
	<h4> 회원 가입 완료! </h4>
	<meta http-equiv="Refresh" content="5;url=main.jsp" />	--%>
	
	<script type="text/javascript">
		// 페이징 처리 #3. 
		alert("회원 가입이 정상적으로 처리 되었습니다.");
		window.location.href="main.jsp";
	</script>
</body>
</html>